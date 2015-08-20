//
//  XYSystemMessageViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYSystemMessageViewController.h"
#import "SystemMessageTableView.h"

@interface XYSystemMessageViewController ()

@property(nonatomic,strong)SystemMessageTableView * systemMessageTableView;

@end

@implementation XYSystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
