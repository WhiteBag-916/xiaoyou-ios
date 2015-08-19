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

#define KBOTTOMHEIGHT [DXMessageToolBar defaultHeight]
@interface FeedDetailViewController() <DXMessageToolBarDelegate>

@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) FeedDetailTableView *feedDetailTable;
@property (strong, nonatomic) DXMessageToolBar *chatToolBar;

@end

@implementation FeedDetailViewController

- (id)initWithFeedId:(NSString *)feedId {
    self = [super init];
    if (self) {
        _feedId = feedId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initController];
    [self initTable];
    [self initToolBar];
    
}

- (void)initController {
    [self showCustomNavigationBackButton];
    self.title = @"详情";
    [self showCustomNavigationMoreButton];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [_feedDetailTable loadData:@[@"",@""]];
}

- (void)initTable {
    _feedDetailTable  = [[FeedDetailTableView alloc] init];
    [self.view addSubview:_feedDetailTable];
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
    _chatToolBar.inputTextView.placeHolder = @"您老人家说两句呗";
    _chatToolBar.inputTextView.width += _chatToolBar.inputTextView.originX - _chatToolBar.styleChangeButton.originX + _chatToolBar.faceButton.rightX - _chatToolBar.inputTextView.rightX;
    _chatToolBar.inputTextView.originX = _chatToolBar.styleChangeButton.originX;
    _chatToolBar.faceButton.originX = _chatToolBar.moreButton.originX;
}


-(void)keyBoardHidden
{
    [self.chatToolBar endEditing:YES];
}

- (void)onNavigationRightButtonClicked {
    
}
@end
