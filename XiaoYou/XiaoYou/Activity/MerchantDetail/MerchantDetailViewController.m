//
//  MerchantDetailViewController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "MerchantDetailTableView.h"

@interface MerchantDetailViewController ()


@property(nonatomic,strong)MerchantDetailTableView * merchantDetailTableView;

@end

@implementation MerchantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

-(void)setUpUI
{
    
    self.title = @"必胜客";
    [self showCustomNavigationBackButton];
    
    _merchantDetailTableView = [[MerchantDetailTableView alloc] init];
    _merchantDetailTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_merchantDetailTableView];
    [_merchantDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
