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

#import "MessageManager.h"
#import "ContactManager.h"
#import "LinkManModel.h"

@interface XYMessageAndContactsViewController ()<IChatManagerDelegate>
@property (strong, nonatomic) UIView * navigationView;
@property (strong, nonatomic) UIButton *chatButton;
@property (strong, nonatomic) UIButton *contactsButton;
@property (strong, nonatomic) MessageTableView *messageTableView;
@property (strong, nonatomic) ContactsTableView *contactsTableView;
@property (strong, nonatomic) CommonSwitchView *commonSwitchView;

@property (nonatomic,strong) NSMutableArray *messageDataSource;
@property (nonatomic,strong) NSMutableArray *contactsDataSource;
@property (nonatomic,strong) NSMutableArray *contactsHeadDataSouce;

@end

@implementation XYMessageAndContactsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    
    WS(weakSelf)
    
    //聊天列表请求
    [[MessageManager sharedInstance] getMessageListData:^(YActionMessage *message) {
        YLogD(@"%@",message);
//        weakSelf.messageDataSource = [NSMutableArray arrayWithArray:message.object];
//        [weakSelf.messageTableView refreshTableView:self.messageDataSource];
    }];
    //联系人列表请求
    [[ContactManager sharedInstance] getContactsListData:^(YActionMessage *message) {
        YLogD(@"%@",message);
        if (message.isSuccess) {
            LinkManModel * model = message.object;
            
            [[ContactManager sharedInstance] saveContactsList:model];
            
            weakSelf.contactsDataSource = [NSMutableArray arrayWithArray:model.linkManList];
            [weakSelf.contactsDataSource addObjectsFromArray:model.unionList];
            
            weakSelf.contactsHeadDataSouce = [NSMutableArray arrayWithArray:model.classList];
        
            [weakSelf.contactsTableView refreshTableView:weakSelf.contactsDataSource AndHeaderView:weakSelf.contactsHeadDataSouce];
        }
    }];
    
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    
    
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.conversationType == eConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated navigationBarHidden:NO tabBarHidden:NO];
    
    [self refreshDataSource];
    [self registerNotifications];
    [self removeEmptyConversationsFromDB];
}

//刷新数据源
-(void)refreshDataSource
{
    _messageDataSource = [self loadDataSource];
    [_messageTableView refreshTableView:_messageDataSource];
    [self hideHud];
}

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    
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
    return ret;
}

#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self refreshDataSource];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self refreshDataSource];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

-(void)viewWillLayoutSubviews
{
    self.hidesBottomBarWhenPushed = NO;
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
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(KTabBarheight);
    }];
    //联系人
    _contactsTableView = [[ContactsTableView alloc]init];
    _contactsTableView.separatorStyle = NO;
    _contactsTableView.myController = self;
    _contactsTableView.hidden = YES;
    [self.view addSubview:_contactsTableView];
    [_contactsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(KTabBarheight);
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
        [_contactsTableView reloadData];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
