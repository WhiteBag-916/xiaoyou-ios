//
//  AppDelegate+RootVC.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/4.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AppDelegate+RootVC.h"
#import "ChooseSchoolViewController.h"
#import "XYTabBarViewController.h"
#import "SlideNavigationController.h"
#import "LoginViewController.h"
#import "ProvisionManager.h"
#import "YManagerCenter.h"
#import "YUtils+HUD.h"
#import "YModel+ActionMessage.h"
#import "PerfectInformationViewController.h"

@implementation AppDelegate(RootVC)

- (void)initRootVC
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //初始化登陆控制器
    self.window.backgroundColor = [UIColor whiteColor];
    //自动登录
    //判断是否有token
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kShareData_Token];
    if (token.length > 0) {
        //初始化登录数据
        [[ProvisionManager sharedInstance] initLoginData];
        //抛登录成功通知
        [[YManagerCenter defaultCenter] notifyAppLogined:nil];
        
        [self initTabBarNC];
    } else {
        [self initChooseSchoolNC];
    }

    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initChooseSchoolNC) name:kNotification_Profile_Logout object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenFail:) name:kNotification_Server_Token_Fail object:nil];
}

- (void)tokenFail:(NSNotification *)note {
    //踢下线
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kShareData_Token];
    //抛登出成功通知
    [[YManagerCenter defaultCenter] notifyAppLogouted:@{@"logoutBySelf":@NO}];
    
    //切换
    [self initChooseSchoolNC];
    
    //提示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        YLogE(@"tokenFail : %@", note.object[@"des"]);
        [YUtils showTitle:note.object[@"des"]];
    });
    
}

- (void)initChooseSchoolNC
{
    UINavigationController * home = [[UINavigationController alloc] initWithRootViewController:[[ChooseSchoolViewController alloc] init]];
    self.window.rootViewController = home;
}

- (void)initLoginNC
{
    UINavigationController * home = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    self.window.rootViewController = home;
}

- (void)initTabBarNC
{
    SlideNavigationController *slideNC = [[SlideNavigationController alloc] initWithRootViewController:[[XYTabBarViewController alloc]init]];
    slideNC.enableSwipeGesture = NO;
    slideNC.leftBarButtonItem = [UIBarButtonItem new];
    slideNC.navigationBarHidden = YES;
    self.window.rootViewController = slideNC;
}

- (void)initPerfectNC {
    UINavigationController * home = [[UINavigationController alloc] initWithRootViewController:[[PerfectInformationViewController alloc] init]];
    self.window.rootViewController = home;
}

@end
