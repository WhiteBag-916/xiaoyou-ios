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

@interface XYMessageAndContactsViewController ()
@property (weak, nonatomic) UIView * navigationView;
@property (weak, nonatomic) UIButton *chatButton;
@property (weak, nonatomic) UIButton *contactsButton;
@property (strong, nonatomic) MessageTableView *messageTableView;
@property (strong, nonatomic) ContactsTableView *contactsTableView;
@property (strong, nonatomic) CommonSwitchView *commonSwitchView;

@property (nonatomic,strong) NSMutableArray *messageDataSource;

@end

@implementation XYMessageAndContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"yinhui" password:@"123123" completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            NSLog(@"登陆成功");
        }
    } onQueue:nil];
    
    [self setUpUI];
    
    //聊天列表请求
    [[MessageManager sharedInstance] getMessageListData:^(YActionMessage *message) {
        YLogD(@"%@",message);
    }];
    //联系人列表请求
    [[ContactManager sharedInstance] getContactsListData:^(YActionMessage *message) {
        YLogD(@"%@",message);
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
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(50);
    }];
    //联系人
    _contactsTableView = [[ContactsTableView alloc]init];
    _contactsTableView.hidden = YES;
    [self.view addSubview:_contactsTableView];
    [_contactsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(50);
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
    }
    else
    {
        _contactsTableView.hidden = NO;
        _messageTableView.hidden = YES;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
