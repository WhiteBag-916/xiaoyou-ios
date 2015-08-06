//
//  XYMessageAndContactsViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYMessageAndContactsViewController.h"
#import "MessageTableViewCell.h"
#import "ContactsTableViewCell.h"
#import "YTableView.h"
#import "YCPSystemDefine.h"

@interface XYMessageAndContactsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView * navigationView;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *contactsButton;
@property (strong, nonatomic) YTableView *messageTableView;
@property (strong, nonatomic) YTableView *contactsTableView;

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
    
    _messageTableView = [[YTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KTabBarheight)];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    [self.view addSubview:_messageTableView];
    
    _contactsTableView = [[YTableView alloc] initWithFrame:CGRectMake(0, KNavigationBarheight, SCREEN_WIDTH, SCREEN_HEIGHT-KNavigationBarheight-KTabBarheight)];
    _contactsTableView.delegate = self;
    _contactsTableView.dataSource = self;
    _contactsTableView.hidden = YES;
    [self.view addSubview:_contactsTableView];
    [_messageTableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kMessageTableViewCell];
    [_contactsTableView registerNib:[UINib nibWithNibName:@"ContactsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kContactsTableViewCell];
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

#pragma mark - UITableViewDataSource和UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.messageTableView]) {
        MessageTableViewCell *cell = [_messageTableView dequeueReusableCellWithIdentifier:kMessageTableViewCell];
        return cell;
    }
    else
    {
        ContactsTableViewCell * cell = [_contactsTableView dequeueReusableCellWithIdentifier:kContactsTableViewCell];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
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
