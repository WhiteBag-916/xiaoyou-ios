//
//  XYSystemMessageViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYSystemMessageViewController.h"
#import "SystemMessageTableView.h"
#import "EMConversation.h"

@interface XYSystemMessageViewController ()

@property(nonatomic,strong)SystemMessageTableView * systemMessageTableView;

@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSMutableArray *dataSource;//tableView数据源

@end

@implementation XYSystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    [self getDataSource];
    [_systemMessageTableView refreshTableView:_dataSource];
}

-(void)getDataSource
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    for (EMConversation *conversation in conversations) {
        if ([conversation.chatter isEqualToString:@"000001"])
        {
            _dataSource = [[NSMutableArray alloc] initWithArray:[conversation loadAllMessages]];
            // 设置当前conversation的所有message为已读
            [conversation markAllMessagesAsRead:YES];
        }
    }
}

-(void)setUpUI
{
    self.title = @"系统消息";
    [self showCustomNavigationBackButton];
    
    _systemMessageTableView = [[SystemMessageTableView alloc] init];
    [self.view addSubview:_systemMessageTableView];
    [_systemMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
