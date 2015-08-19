//
//  ChooseSchoolViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/7/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ChooseSchoolViewController.h"
#import "Masonry.h"
#import "ProvisionManager.h"
#import "SlideNavigationController.h"
#import "XYTabBarViewController.h"
#import "YDefine.h"
#import "AppDelegate+RootVC.h"

@interface ChooseSchoolViewController ()

@end

@implementation ChooseSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(100, 100, 100, 100));
    }];
}

- (void)goLogin
{
    //login
    [[ProvisionManager sharedInstance] goLogin:^(YActionMessage *message) {
        if (message.isSuccess)
        {
            //成功
            [kAppDelegateAccessor initTabBarNC];
        }
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
