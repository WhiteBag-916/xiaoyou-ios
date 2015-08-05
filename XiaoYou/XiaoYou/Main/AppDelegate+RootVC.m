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

@implementation AppDelegate(RootVC)

- (void)initRootVC
{
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //初始化登陆控制器
    //    UIStoryboard * chooseSchool = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    //    UINavigationController * home = [chooseSchool instantiateInitialViewController];
    //    self.window.rootViewController = home;
    
    SlideNavigationController *slideNC = [[SlideNavigationController alloc] initWithRootViewController:[[XYTabBarViewController alloc]init]];
    slideNC.enableSwipeGesture = NO;
    slideNC.leftBarButtonItem = [UIBarButtonItem new];
    slideNC.navigationBarHidden = YES;
    self.window.rootViewController = slideNC;
    
    [self.window makeKeyAndVisible];
}

@end
