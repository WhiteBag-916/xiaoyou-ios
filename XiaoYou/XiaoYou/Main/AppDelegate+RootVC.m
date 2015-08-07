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
#import "ChooseSchoolViewController.h"

@implementation AppDelegate(RootVC)

- (void)initRootVC
{
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //初始化登陆控制器
    [self initLoginNC];

    [self.window makeKeyAndVisible];
}

- (void)initLoginNC
{
    UINavigationController * home = [[UINavigationController alloc] initWithRootViewController:[[ChooseSchoolViewController alloc] init]];
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

@end
