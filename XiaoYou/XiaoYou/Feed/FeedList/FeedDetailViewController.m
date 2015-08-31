//
//  FeedDetailViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedDetailViewController.h"
#import "FeedDetailTableView.h"
#import "Masonry.h"
#import "DXMessageToolBar.h"
#import "YCommonActionSheet.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "FeedManager.h"

#define KBOTTOMHEIGHT [DXMessageToolBar defaultHeight]
@interface FeedDetailViewController() <DXMessageToolBarDelegate, UIGestureRecognizerDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) FeedDetailTableView *feedDetailTable;
@property (nonatomic, strong) DXMessageToolBar *chatToolBar;
@property (nonatomic, strong) NSString *replyId;

@end

@implementation FeedDetailViewController

- (id)initWithFeedId:(NSString *)feedId {
    self = [super init];
    if (self) {
        _feedId = feedId;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTable];
    [self initController];
    [self initToolBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMode:) name:@"UITextInputCurrentInputModeDidChangeNotification" object:nil];
}

- (void)initController {
    [self showCustomNavigationBackButton];
    self.title = @"详情";
    [self showCustomNavigationMoreButton];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [_feedDetailTable loadDataWithFeedId:_feedId];
    [[FeedManager sharedInstance] readByFeed:_feedId block:^(YActionMessage *message) {
        
    }];
}

- (void)initTable {
    _feedDetailTable  = [[FeedDetailTableView alloc] init];
    [self.view addSubview:_feedDetailTable];
    _feedDetailTable.parent = self;
    [_feedDetailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-KBOTTOMHEIGHT);
    }];
}
- (void)initToolBar {
    _chatToolBar = [[DXMessageToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [DXMessageToolBar defaultHeight], self.view.frame.size.width, KBOTTOMHEIGHT)];
    _chatToolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _chatToolBar.delegate = self;
    [self.view addSubview:_chatToolBar];
    _chatToolBar.moreButton.hidden = true;
    _chatToolBar.styleChangeButton.hidden = true;
    _chatToolBar.inputTextView.width += _chatToolBar.inputTextView.originX - _chatToolBar.styleChangeButton.originX + _chatToolBar.faceButton.rightX - _chatToolBar.inputTextView.rightX;
    _chatToolBar.inputTextView.originX = _chatToolBar.styleChangeButton.originX;
    _chatToolBar.faceButton.originX = _chatToolBar.moreButton.originX;
}

-(void)keyBoardHidden
{
    _replyId = nil;
    _chatToolBar.inputTextView.placeHolder = @"您老人家说两句呗";
    [_chatToolBar endEditing:YES];
}
-(void) changeMode:(NSNotification *)notification{
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString:@"emoji"]) {
        [YUtils showTitle:@"不支持emoji"];
    }
}
- (void)onNavigationRightButtonClicked {
    [_feedDetailTable openTool];
}
- (void)didSendText:(NSString *)text {
    text = [ConvertToCommonEmoticonsHelper convertToCommonEmoticons:text];
    if (_replyId.length == 0) {
        [[FeedManager sharedInstance] addComment:_feedId content:text block:^(YActionMessage *message) {
            if (!message.isSuccess) {
                [YUtils showTitle:message.desc];
            }
            _replyId = nil;
            _chatToolBar.inputTextView.placeHolder = @"您老人家说两句呗";
            [_chatToolBar endEditing:YES];
            [_feedDetailTable refresh];
        }];
    } else {
        [[FeedManager sharedInstance] addReply:_feedId content:text toUserId:_replyId block:^(YActionMessage *message) {
            if (!message.isSuccess) {
                [YUtils showTitle:message.desc];
            }
            _replyId = nil;
            _chatToolBar.inputTextView.placeHolder = @"您老人家说两句呗";
            [_chatToolBar endEditing:YES];
            [_feedDetailTable refresh];
        }];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}
- (void)openInputWithId:(NSString *)userId name:(NSString *)userName {
    _replyId = userId;
    _chatToolBar.inputTextView.placeHolder =[NSString stringWithFormat:@"回复：%@", userName];
    [_chatToolBar.inputTextView becomeFirstResponder];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.chatToolBar.inputTextView isFirstResponder]) {
        return true;
    }
    return false;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
