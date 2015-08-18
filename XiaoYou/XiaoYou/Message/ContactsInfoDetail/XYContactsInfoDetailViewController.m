//
//  XYContactsInfoDetailViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYContactsInfoDetailViewController.h"
#import "ContactsInfoDetailTableView.h"

@interface XYContactsInfoDetailViewController ()

@property(nonatomic,strong)ContactsInfoDetailTableView * contactsInfoDetailTableView;

@end

@implementation XYContactsInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    
    [self setUpUI];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated navigationBarHidden:NO tabBarHidden:YES];
//}

//-(void)viewDidLayoutSubviews
//{
//    self.hidesBottomBarWhenPushed = NO;
//}

-(void)setUpUI
{
    _contactsInfoDetailTableView = [[ContactsInfoDetailTableView alloc] init];
    _contactsInfoDetailTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contactsInfoDetailTableView];
    
    [_contactsInfoDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
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
