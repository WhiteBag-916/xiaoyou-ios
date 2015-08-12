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

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface XYMessageAndContactsViewController ()
@property (strong, nonatomic) UIView * navigationView;
@property (strong, nonatomic) UIButton *chatButton;
@property (strong, nonatomic) UIButton *contactsButton;
@property (strong, nonatomic) MessageTableView *messageTableView;
@property (strong, nonatomic) ContactsTableView *contactsTableView;
@property (strong, nonatomic) CommonSwitchView *commonSwitchView;

@property (nonatomic,strong) NSMutableArray *messageDataSource;
@property (nonatomic,strong) NSMutableArray *contactsDataSource;

@end

@implementation XYMessageAndContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"yinhui" password:@"123123" completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            YLogD(@"登陆成功");
        }
    } onQueue:nil];
    
    [self setUpUI];
    
    WeakSelf(weakSelf)
    
    //聊天列表请求
    [[MessageManager sharedInstance] getMessageListData:^(YActionMessage *message) {
        YLogD(@"%@",message);
        weakSelf.messageDataSource = [NSMutableArray arrayWithArray:message.object];
        [weakSelf.messageTableView refreshTableView:self.messageDataSource];
    }];
    //联系人列表请求
    [[ContactManager sharedInstance] getContactsListData:^(YActionMessage *message) {
        YLogD(@"%@",message);
        [message.object enumerateObjectsUsingBlock:^(LinkManModel * obj, NSUInteger idx, BOOL *stop) {

        }];
        
//        weakSelf.contactsDataSource = [NSMutableArray arrayWithArray:message.object];
//        [weakSelf.contactsTableView refreshTableView:self.contactsDataSource];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated navigationBarHidden:NO tabBarHidden:NO];
}

#pragma mark - setUpUI方法

-(void)setUpUI
{
    //switch
    _commonSwitchView = [[CommonSwitchView alloc] initWithFrame:CGRectMake(0, 0, 127, 27) textArray:@[@"聊天", @"联系人"]];
    [_commonSwitchView changedType:^(CommonSwitchType type) {
        [self changeSwitchView:type];
    }];
    self.navigationItem.titleView = _commonSwitchView;
    //聊天
    _messageTableView = [[MessageTableView alloc] init];
    [self.view addSubview:_messageTableView];
    [_messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(KTabBarheight);
    }];
    //联系人
    _contactsTableView = [[ContactsTableView alloc]init];
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
