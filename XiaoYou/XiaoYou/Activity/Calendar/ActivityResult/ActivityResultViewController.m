//
//  ActivityResuktViewController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityResultViewController.h"
#import "ActivityResultTableView.h"
#import "ActivityManager.h"
#import "ActivityInfoModel.h"

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
    self.title = @"筛选结果";
    [self showCustomNavigationBackButton];
    
    _resultTableView = [[ActivityResultTableView alloc] init];
    _resultTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_resultTableView];
    [_resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [[ActivityManager sharedInstance] getCurrentUseAvailableListLimitStart:1 limitEnd:10 dic:self.requestDic block:^(YActionMessage *message) {
        
        ActivityInfoModel * model = message.object;
        NSLog(@"%@",message.object);
        _resultTableView.dataSouceArr = message.object;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
