//
//  AppDelegate.m
//  XiaoYou
//
//  Created by 熊宸 on 15/7/9.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Manager.h"
#import "AppDelegate+RootVC.h"
#import "AppDelegate+Notification.h"

#import "InterestViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [self initManager];
    
    [self initNotification:application didFinishLaunchingWithOptions:launchOptions];
    
    [self initRootVC];
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[InterestViewController alloc] init]];
    return YES;
}

@end
