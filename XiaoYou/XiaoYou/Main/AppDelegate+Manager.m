//
//  AppDelegate+Manager.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/4.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AppDelegate+Manager.h"
#import "ProvisionManager.h"
#import "FeedManager.h"
#import "ContactManager.h"
#import "MessageManager.h"

@implementation AppDelegate (Manager)

- (void)initManager
{
    //注册log
    [YLog setLevel:YLogLevelAll];
    
    //注册组件
    [ProvisionManager sharedInstance];
    [FeedManager sharedInstance];
    [MessageManager sharedInstance];
    [ContactManager sharedInstance];
}

@end
