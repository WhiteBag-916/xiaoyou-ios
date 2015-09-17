//
//  XYMessageAndContactsViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYMessageAndContactsViewController.h"
#import "YTableView.h"
#import "YSystemDefine.h"
#import "ContactsTableView.h"
#import "MessageTableView.h"
#import "Masonry.h"
#import "CommonSwitchView.h"
#import "EaseMob.h"
#import "YNotificationDefine.h"
#import "MessageManager.h"
#import "MessageManager.h"
#import "ContactManager.h"
#import "LinkManModel.h"
#import "ContactManager.h"

@interface XYMessageAndContactsViewController ()<IChatManagerDelegate>
@property (strong, nonatomic) UIView * navigationView;
@property (strong, nonatomic) UIButton *chatButton;
@property (strong, nonatomic) UIButton *contactsButton;
@property (strong, nonatomic) MessageTableView *messageTableView;
@property (strong, nonatomic) ContactsTableView *contactsTableView;
@property (strong, nonatomic) CommonSwitchView *commonSwitchView;
@property (nonatomic,strong) EMMessage * systemMessage;

@end

@implementation XYMessageAndContactsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMeesageRes:) name:kNotification_Refresh_Message object:nil];
    [self refreshDataSource];
    [[MessageManager sharedInstance] setupUnreadMessageCount];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillLayoutSubviews
{
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    
    WS(weakSelf)
    
    //联系人列表请求
    [[ContactManager sharedInstance] getContactsListData:^(YActionMessage *message) {
        YLogD(@"%@",message);
        if (message.isSuccess) {
            
            [weakSelf.contactsTableView refreshTableView:[[ContactManager sharedInstance] getContactsListData]];
        }
    }];
}
#pragma mark - 删除数据库中空会话
- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations = [@[] mutableCopy];
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.conversationType == eConversationTypeChatRoom)) {
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}

#pragma mark - 刷新消息
- (void)refreshMeesageRes:(NSNotification *)notification {
    EMError *error = [notification userInfo][kNotification_Request_Error];
    if (nil == error) {
        [self refreshDataSource];
    } else {
        switch (error.errorCode) {
            case EMErrorServerNotReachable:
                TTAlertNoTitle(NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!"));
                break;
            case EMErrorServerDuplicatedAccount:
                TTAlertNoTitle(NSLocalizedString(@"register.repeat", @"You registered user already exists!"));
                break;
            case EMErrorNetworkNotConnected:
                [YUtils showTitle:@"无网络连接"];
                break;
            case EMErrorServerTimeout:
                TTAlertNoTitle(NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!"));
                break;
            default:
                TTAlertNoTitle(NSLocalizedString(@"register.fail", @"Registration failed"));
                break;
        }
    }
}

#pragma mark - 刷新数据源
-(void)refreshDataSource
{
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    [self removeEmptyConversationsFromDB];
    [_messageTableView refreshTableView:[self loadDataSource] AndHeaderModel:_systemMessage];
    [_contactsTableView refreshTableView:[[ContactManager sharedInstance] getContactsListData]];
    [self hideHud];
}

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSMutableArray *conversations = [[NSMutableArray alloc] initWithArray:[[EaseMob sharedInstance].chatManager conversations]];
    
    for (EMConversation *conversation in conversations) {
        if ([conversation.chatter isEqualToString:KSYSTEM_MESSAGEID])
        {
            _systemMessage = [conversation latestMessage];
            [conversations removeObject:conversation];
            break;
        }
    }
    
    NSArray* sorte = [conversations sortedArrayUsingComparator:
                      ^(EMConversation *obj1, EMConversation* obj2){
                          EMMessage *message1 = [obj1 latestMessage];
                          EMMessage *message2 = [obj2 latestMessage];
                          if(message1.timestamp > message2.timestamp) {
                              return(NSComparisonResult)NSOrderedAscending;
                          }else {
                              return(NSComparisonResult)NSOrderedDescending;
                          }
                      }];
    
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    
//    //置顶 
//    __block NSInteger index = -1;
//    [ret enumerateObjectsUsingBlock:^(EMConversation *conversation, NSUInteger idx, BOOL *stop) {
//        if ([conversation.chatter isEqualToString:KSYSTEM_MESSAGEID])
//        {
//            index = idx;
//            *stop = YES;
//        }
//    }];
//    
//    if (index >= 0) {
//        EMConversation *conversation = [ret objectAtIndex:index];
//        [ret removeObjectAtIndex:index];
//        [ret insertObject:conversation atIndex:0];
//    }
    
    
    return ret;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - setUpUI方法
-(void)setUpUI
{
    //switch
    _commonSwitchView = [[CommonSwitchView alloc] initWithFrame:CGRectMake(0, 0, SCALE_NUM(119), SCALE_NUM(24)) textArray:@[@"聊天", @"联系人"]];
    [_commonSwitchView changedType:^(CommonSwitchType type) {
        [self changeSwitchView:type];
    }];
    self.navigationItem.titleView = _commonSwitchView;
    //聊天
    _messageTableView = [[MessageTableView alloc] init];
    _messageTableView.myController = self;
    _messageTableView.separatorStyle = NO;
    [self.view addSubview:_messageTableView];
    [_messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    //联系人
    _contactsTableView = [[ContactsTableView alloc]init];
    _contactsTableView.separatorStyle = NO;
    _contactsTableView.myController = self;
    _contactsTableView.hidden = YES;
    [self.view addSubview:_contactsTableView];
    [_contactsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - NavigationBar点击方法
//改变switch
- (void)changeSwitchView:(CommonSwitchType)type;
{
    if (type == CommonSwitchTypeFir)
    {
        _messageTableView.hidden = NO;
        _contactsTableView.hidden = YES;
        [_messageTableView reloadData];
        [self removeEmptyConversationsFromDB];
    }
    else
    {
        _contactsTableView.hidden = NO;
        _messageTableView.hidden = YES;
        [_contactsTableView refreshTableView:[[ContactManager sharedInstance] getContactsListData]];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
