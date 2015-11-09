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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [self initManager];
    
    [self initNotification:application didFinishLaunchingWithOptions:launchOptions];
    
    [self initRootVC];
    
    [AppConfigData setHaveRemindMessage:NO];
    
    NSDictionary*userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo)
    {
        NSString *message = [userInfo description];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"aa" otherButtonTitles:@"bb", nil];
        
        [alert show];
        
        [self initNotifyRemindNC];
        UILocalNotification *localNoti = [[UILocalNotification alloc]init];
        localNoti.userInfo = userInfo;
        //[self application:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
        [self application:[UIApplication sharedApplication] didReceiveLocalNotification:localNoti];
    }

    return YES;
}


#pragma mark 以下部分是测试代码
//-(void)testDB
//{
//    UserSchedulingInfo *info = [[UserSchedulingInfo alloc]init];
//    info.startTime = 2321321.00;
//    info.endTime = 34324324.0;
//    info.content = @"2313213";
//    info.status = @"ABCDEFRTTT";
//
//    UserSchedulingInfo *info1 = [[UserSchedulingInfo alloc]init];
//    info1.startTime = 2321321.00;
//    info1.endTime = 34324324.0;
//    info1.content = @"2313213";
//    info1.status = @"AAAAAAAAAAAAA";
//
//    YBaseService *service = [[YBaseService alloc]init];
//    [service insertModel:info];
//    [service insertModel:info1];
//    
//    NSLog(@"this is just test....");
//}

@end
