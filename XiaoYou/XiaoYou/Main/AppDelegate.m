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
#import "EaseMob.h"

#import "ProvisionManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //环信初始化
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"jiankun#xiaoyou" apnsCertName:@"xiaoyou_development"];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    [self initManager];
    
    [self initNotification];
    
    [self initRootVC];
    
    //login
    [[ProvisionManager sharedInstance] goLogin:^(YActionMessage *message) {
        
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
     [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end
