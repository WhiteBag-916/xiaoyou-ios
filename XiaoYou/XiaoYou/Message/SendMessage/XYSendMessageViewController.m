//
//  XYSendMessageViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYSendMessageViewController.h"
#import "SendMessageTableView.h"
#import "DXMessageToolBar.h"

#define KBOTTOMHEIGHT [DXMessageToolBar defaultHeight]
#define kBackViewHeight                 118
#define kPaddingDistance                12
#define kLabelHeight                    20
#define kTableViewHeight                290

@interface XYSendMessageViewController ()<DXMessageToolBarDelegate>

@property(nonatomic,strong)SendMessageTableView * sendMessageTableView;

@property(nonatomic,strong) UILabel * sendPersonLabel;
@property(nonatomic,strong) UILabel * remindLabel;

@property (strong, nonatomic) DXMessageToolBar *chatToolBar;


@end

@implementation XYSendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    [self initToolBar];
}

-(void)setUpUI
{
    self.title = @"发信";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kBackViewHeight);
    }];
    //发送Label
    _sendPersonLabel = [[UILabel alloc] init];
    _sendPersonLabel.backgroundColor = [UIColor clearColor];
    _sendPersonLabel.text = @"发送对象：小明等9人";
    _sendPersonLabel.font = CONTENT_FONT(13);
    [backView addSubview:_sendPersonLabel];
    [_sendPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(kPaddingDistance);
        make.right.mas_equalTo(-kPaddingDistance);
        make.height.mas_equalTo(kLabelHeight);
    }];
    //提示Label
    _remindLabel = [[UILabel alloc] init];
    _remindLabel.backgroundColor = [UIColor clearColor];
    _remindLabel.text = @"你可以选择以下模板，然后再编辑";
    _remindLabel.textColor = [UIColor hexChangeFloat:@"aaaaaa"];
    _remindLabel.font = CONTENT_FONT(12);
    _remindLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:_remindLabel];
    [_remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPaddingDistance);
        make.right.bottom.mas_equalTo(-kPaddingDistance);
        make.height.mas_equalTo(kLabelHeight);
    }];
    //模板tableView
    _sendMessageTableView = [[SendMessageTableView alloc] init];
    _sendMessageTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_sendMessageTableView];
    [_sendMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_HEIGHT - KBOTTOMHEIGHT - kBackViewHeight - KNavigationBarheight);
    }];
    
}

- (void)initToolBar {
    _chatToolBar = [[DXMessageToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [DXMessageToolBar defaultHeight], self.view.frame.size.width, KBOTTOMHEIGHT)];
    _chatToolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    _chatToolBar.delegate = self;
    [self.view addSubview:_chatToolBar];
    _chatToolBar.moreButton.hidden = true;
    _chatToolBar.styleChangeButton.hidden = true;
    _chatToolBar.inputTextView.placeHolder = @"聊聊呗";
    _chatToolBar.inputTextView.width += _chatToolBar.inputTextView.originX - _chatToolBar.styleChangeButton.originX + _chatToolBar.faceButton.rightX - _chatToolBar.inputTextView.rightX;
    _chatToolBar.inputTextView.originX = _chatToolBar.styleChangeButton.originX;
    _chatToolBar.faceButton.originX = _chatToolBar.moreButton.originX;
}


-(void)keyBoardHidden
{
    [self.chatToolBar endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
