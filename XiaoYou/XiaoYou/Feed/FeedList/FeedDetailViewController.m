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
@interface FeedDetailViewController()
<DXMessageToolBarDelegate, UIGestureRecognizerDelegate,UITextViewDelegate>

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
}

- (void)initController {
    [self showCustomNavigationBackButton];
    self.title = @"详情";
    [self showCustomNavigationMoreButton];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
//    [self.feedDetailTable addGestureRecognizer:tap1];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
//定制输入框
- (void)initToolBar {
    _chatToolBar = [[DXMessageToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [DXMessageToolBar defaultHeight], self.view.frame.size.width, KBOTTOMHEIGHT)];
    _chatToolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _chatToolBar.delegate = self;
    _chatToolBar.maxEnterNum = 200;
    _chatToolBar.maxEnterText = @"评论不能超过200字";
    [self.view addSubview:_chatToolBar];
    _chatToolBar.moreButton.hidden = true;
    _chatToolBar.styleChangeButton.hidden = true;
    _chatToolBar.inputTextView.width += _chatToolBar.inputTextView.originX - _chatToolBar.styleChangeButton.originX + _chatToolBar.faceButton.rightX - _chatToolBar.inputTextView.rightX;
    _chatToolBar.inputTextView.originX = _chatToolBar.styleChangeButton.originX;
    _chatToolBar.faceButton.originX = _chatToolBar.moreButton.originX;
    _chatToolBar.inputTextView.placeHolder = @"说两句呗";
}
//默认恢复到回复feed状态
-(void)keyBoardHidden
{
    _replyId = nil;
    _chatToolBar.inputTextView.placeHolder = @"说两句呗";
    [_chatToolBar endEditing:YES];
}
- (void)onNavigationRightButtonClicked {
    [YAnalysis trackEvent:@"更多操作_FEED详情" withPara:nil];
    [_feedDetailTable openTool];
}
//回复处理
- (void)didSendText:(NSString *)text {
    //如果为空字符串，不处理
    if ([[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        [YUtils showTitle:@"输入不能为空" hideAfter:1];
        return;
    }
    [YAnalysis trackEvent:@"评论_FEED详情" withPara:nil];
    text = [ConvertToCommonEmoticonsHelper convertToCommonEmoticons:text];
    if (_replyId.length == 0) {//回复feed
        [[FeedManager sharedInstance] addComment:_feedId content:text block:^(YActionMessage *message) {
            if (!message.isSuccess) {
                [YUtils showTitle:message.desc];
            }
            //恢复到回复feed状态
            _replyId = nil;
            _chatToolBar.inputTextView.placeHolder = @"说两句呗";
            [_chatToolBar endEditing:YES];
            [_feedDetailTable refresh];
        }];
    } else {//回复人
        [[FeedManager sharedInstance] addReply:_feedId content:text toUserId:_replyId block:^(YActionMessage *message) {
            if (!message.isSuccess) {
                [YUtils showTitle:message.desc];
            }
            //恢复到回复feed状态
            _replyId = nil;
            _chatToolBar.inputTextView.placeHolder = @"说两句呗";
            [_chatToolBar endEditing:YES];
            [_feedDetailTable refresh];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}

//准备回复人
- (void)openInputWithId:(NSString *)userId name:(NSString *)userName {
    _replyId = userId;
    _chatToolBar.inputTextView.placeHolder =[NSString stringWithFormat:@"回复：%@", userName];
    [_chatToolBar.inputTextView becomeFirstResponder];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.chatToolBar isEditing]) {
        return true;
    }
    return false;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - DXMessageToolBarDelegate
- (void)didChangeFrameToHeight:(CGFloat)toHeight {
    
}

@end
