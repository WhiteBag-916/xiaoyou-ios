//
//  XYSendMessageViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYSendMessageViewController.h"
#import "SendMessageTableView.h"
#import "Author.h"
#import "ChatSendHelper.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"
#import "LoginResp.h"
#import "RobotManager.h"
#import "Tags.h"

#define KBOTTOMHEIGHT [DXMessageToolBar defaultHeight]
#define kBackViewHeight                 SCALE_NUM(118)
#define kPaddingDistance                SCALE_NUM(12)
#define kLabelHeight                    SCALE_NUM(20)
#define kTableViewHeight                SCALE_NUM(290)

@interface XYSendMessageViewController ()
<SendMessageTableViewDelegate,DXMessageToolBarDelegate>

@property(nonatomic,strong)SendMessageTableView * sendMessageTableView;

@property(nonatomic,strong) UILabel * sendPersonLabel;
@property(nonatomic,strong) UILabel * remindLabel;
@property (nonatomic) BOOL isRobot;

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
    [self showCustomNavigationBackButton];
    
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
    Author * model = _sendPersonsArr[0];
    _sendPersonLabel.text = [NSString stringWithFormat:@"%@等%ld人",model.name,
                             _sendPersonsArr.count];
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
    _sendMessageTableView.myDelegate = self;
    [self.view addSubview:_sendMessageTableView];
    [_sendMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_HEIGHT-KBOTTOMHEIGHT-kBackViewHeight-KNavigationBarheight);
    }];
    
}

#pragma mark - 初始化输入框

- (void)initToolBar {
    _chatToolBar =
    [[DXMessageToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - [DXMessageToolBar defaultHeight], self.view.frame.size.width, KBOTTOMHEIGHT)];
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


-(void)didSelectCell:(NSString *)text
{
    _chatToolBar.inputTextView.text = [_chatToolBar.inputTextView.text stringByAppendingString:text];
}

-(void)keyBoardHidden
{
    NSLog(@"this is data......");
    [self.chatToolBar endEditing:YES];
}

- (void)didSendText:(NSString *)text
{
    if (text && text.length > 0) {
        [self sendTextMessage:text];
    }
}

#pragma mark - 点击发送事件

-(void)sendTextMessage:(NSString *)textMessage
{
    NSString * groupName = [NSString string];
    
    ProfileInfo * info =[[ProvisionManager sharedInstance] getProfile];
    for (Tags * obj in info.managerGroups)
    {
        if ([_groupId isEqualToString:obj.internalBaseClassIdentifier])
        {
            groupName = obj.name;
        }
    }
    
    NSDictionary *ext = @{@"headImage":[[ProvisionManager sharedInstance] getLoginInfo].icon,
                          @"userName":[[ProvisionManager sharedInstance] getLoginInfo].studentName,
                          @"em_apns_ext":@{@"em_push_title":[NSString stringWithFormat:@"%@社社长[%@]发来一条消息", groupName,[[ProvisionManager sharedInstance] getLoginInfo].studentName]}};
     
    
    if (_isRobot) {
        ext = @{kRobot_Message_Ext:[NSNumber numberWithBool:YES]};
    }
    for (int i = 0 ; i < _sendPersonsArr.count; i++)
    {
        Author * model = _sendPersonsArr[i];
        EMMessage *tempMessage =
        [ChatSendHelper sendTextMessageWithString:textMessage
                                       toUsername:[NSString stringWithFormat:@"%@_%@",model.schoolCode,model.studentNo]
                                      messageType:eMessageTypeChat
                                requireEncryption:NO
                                              ext:ext];
        EMConversation *conversation =
        [[EaseMob sharedInstance].chatManager conversationForChatter:tempMessage.conversationChatter
                                                    conversationType:eConversationTypeChat];
        [conversation removeMessage:tempMessage];
    }
    [YUtils showTitle:@"发送成功"];
}

#pragma mark - DXMessageToolBarDelegate
- (void)didChangeFrameToHeight:(CGFloat)toHeight {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
