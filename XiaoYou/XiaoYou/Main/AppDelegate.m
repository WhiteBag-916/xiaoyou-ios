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
#import "UserSchedulingInfo.h"
#import "YBaseService.h"
#import "AppConfigData.h"
#import "MessageManager.h"
#import "AppDelegate+Update.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [self initManager];
    
    [self initNotification:application didFinishLaunchingWithOptions:launchOptions];
    
    [self initRootVC];
    
    [self isNeedToUpDate];
    
    return YES;
}


#pragma mark 从其他应用跳转到此APP,需要在plist设置url sheme,然后分割url参数跳转到对应界面
-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation
{
    YLogD(@"this is %@",url);
    return YES;
}
@end
