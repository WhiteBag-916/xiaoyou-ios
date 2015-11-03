//
//  ScanfResultViewController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScanfResultViewController.h"
#import "ScanfResultTableView.h"

@interface ScanfResultViewController ()

@property(nonatomic,strong)ScanfResultTableView * scanfResultTableView;
@property(nonatomic,strong)NSString * resultStr;

@end

@implementation ScanfResultViewController

- (instancetype)initWithResult:(NSString *)result
{
    self = [super init];
    if (self) {
        _resultStr = result;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setUpUI
{
    
    
    _scanfResultTableView = [[ScanfResultTableView alloc] init];
    [self.view addSubview:_scanfResultTableView];
    [_scanfResultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
