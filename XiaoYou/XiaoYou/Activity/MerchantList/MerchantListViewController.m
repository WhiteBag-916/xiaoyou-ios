//
//  MerchantListViewController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MerchantListViewController.h"
#import "MerchantListTableView.h"

@interface MerchantListViewController ()

@property (nonatomic,strong)MerchantListTableView * merchantListTableView;

@end

@implementation MerchantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_merchantListTableView sendRequest];
}

-(void)setUpUI
{
    [self showCustomNavigationBackButton];
    self.title = @"商家列表";
    
    _merchantListTableView = [[MerchantListTableView alloc] init];
    _merchantListTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_merchantListTableView];
    [_merchantListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
