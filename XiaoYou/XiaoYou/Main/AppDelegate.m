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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [self initManager];
    
    [self initNotification:application didFinishLaunchingWithOptions:launchOptions];
    
    [self initRootVC];
    
    [AppConfigData setHaveRemindMessage:NO];
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(nil != userInfo && nil != userInfo[@"e"])
    {
        
        NSDictionary *dic = userInfo[@"e"];
        NSMutableDictionary *dataDictExt = [NSMutableDictionary dictionaryWithDictionary:dic[@"obj"]];
        
        if (userInfo[@"e"][@"type"] != nil )
            [dataDictExt setObject:userInfo[@"e"][@"type"] forKey:@"type"];
        if (userInfo[@"e"][@"timestamp"] != nil )
            [dataDictExt setObject:userInfo[@"e"][@"timestamp"] forKey:@"timestamp"];
        
        if (userInfo[@"e"][@"headIcon"] != nil)
            [dataDictExt setObject:userInfo[@"e"][@"headIcon"] forKey:@"headIcon"];
        if (userInfo[@"e"][@"id"] != nil)
            [dataDictExt setObject:userInfo[@"e"][@"id"] forKey:@"id"];
        if (userInfo[@"e"][@"name"] != nil)
            [dataDictExt setObject:userInfo[@"e"][@"name"] forKey:@"name"];
        if (userInfo[@"e"][@"organizer"] != nil)
            [dataDictExt setObject:userInfo[@"e"][@"organizer"] forKey:@"organizer"];
        
        if (userInfo[@"aps"][@"alert"] != nil)
            [dataDictExt setObject:userInfo[@"aps"][@"alert"] forKey:@"contentTxt"];
        if (dataDictExt != nil) {
            [[MessageManager sharedInstance] dealMessageWithDict:dataDictExt];
            
            
            if (userInfo[@"e"][@"type"] != nil) {
                NSInteger type = [userInfo[@"e"][@"type"] integerValue];
                
                if (type == 13 || type == 16)
                    [self initNotifyRemindListNC];
                else if (type >=13 && type <= 19)
                    [self initNotifyRemindNC];
            }

        }
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
