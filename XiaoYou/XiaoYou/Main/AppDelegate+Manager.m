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
#import "YCommonShare.h"
#import "YDirectory+Data.h"

@implementation AppDelegate (Manager)

- (void)initManager
{
    //注册log
    [YLog setLevel:YLogLevelAll];
    //创建文件夹
    [YDirectory createFolders];
    
    //注册组件
    [ProvisionManager sharedInstance];
    [FeedManager sharedInstance];
    [MessageManager sharedInstance];
    [ContactManager sharedInstance];
    
    //注册umeng
    [[YCommonShare sharedInstance] registUmengSDK];
}

@end
