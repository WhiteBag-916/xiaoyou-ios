//
//  MerchantDetailViewController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "TopView.h"
#import "MiddleInfoView.h"
#import "PrivilegeDetailView.h"

@interface MerchantDetailViewController ()

@property(nonatomic,strong)TopView * topView;
@property(nonatomic,strong)MiddleInfoView * middleInfoView;
@property(nonatomic,strong)PrivilegeDetailView * privilegeDetailView;

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
    
    _topView = [[TopView alloc] init];
    _topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(150));
    }];
    
    _middleInfoView = [[MiddleInfoView alloc] init];
    _middleInfoView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_middleInfoView];
    [_middleInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(132));
        make.top.equalTo(_topView.mas_bottom);
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
