//
//  ActivityResuktViewController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityResultViewController.h"
#import "ActivityResultTableView.h"

@interface ActivityResultViewController ()

@property(nonatomic,strong)ActivityResultTableView * resultTableView;

@end

@implementation ActivityResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

-(void)setUpUI
{
    [self showCustomNavigationBackButton];
    
    _resultTableView = [[ActivityResultTableView alloc] init];
    _resultTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_resultTableView];
    [_resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
