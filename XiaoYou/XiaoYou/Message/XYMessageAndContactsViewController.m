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

@interface XYMessageAndContactsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView * navigationView;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *contactsButton;
@property (strong, nonatomic) MessageTableView *messageTableView;
@property (strong, nonatomic) ContactsTableView *contactsTableView;

@property (nonatomic,strong) NSMutableArray *messageDataSource;

@end

@implementation XYMessageAndContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated navigationBarHidden:NO tabBarHidden:NO];
}

#pragma mark - setUpUI方法

-(void)setUpUI
{
    
    _navigationView.layer.cornerRadius = 10;
    _navigationView.clipsToBounds = YES;
    _navigationView.layer.borderWidth = 1;
    _navigationView.layer.borderColor = [UIColor blueColor].CGColor;
    
    _messageTableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KTabBarheight)];
    [self.view addSubview:_messageTableView];
    
    _contactsTableView = [[ContactsTableView alloc] initWithFrame:CGRectMake(0, KNavigationBarheight, SCREEN_WIDTH, SCREEN_HEIGHT-KNavigationBarheight-KTabBarheight)];
    _contactsTableView.hidden = YES;
    [self.view addSubview:_contactsTableView];
}

#pragma mark - NavigationBar点击方法

- (IBAction)tapChatButton:(id)sender
{
    _messageTableView.hidden = NO;
    _contactsTableView.hidden = YES;
    self.chatButton.backgroundColor = [UIColor blueColor];
    [self.chatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.contactsButton.backgroundColor = [UIColor whiteColor];
    [self.contactsButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
}
- (IBAction)tapContactsButton:(id)sender
{
    _contactsTableView.hidden = NO;
    _messageTableView.hidden = YES;
    self.chatButton.backgroundColor = [UIColor whiteColor];
    [_chatButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.contactsButton.backgroundColor = [UIColor blueColor];
    [self.contactsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
