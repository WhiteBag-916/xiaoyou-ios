//
//  AppConfigData.m
//  Component
//
//  Created by sheng on 15/10/14.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AppConfigData.h"
#define HAVETIME_USE_KEY   @"isFirstUseHaveTime"
#define FEED_USE_KEY       @"isFirstUseFeed"
#define READCODE_USE_KEY   @"isFirstUseReadCode"
@implementation AppConfigData


+(BOOL)isUserFirstUseHaveTime
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefault objectForKey:HAVETIME_USE_KEY];
    
    //第一次使用
    if(!value) {
        [userDefault setValue:@"NO" forKey:HAVETIME_USE_KEY];
        return YES;
    }
    return NO;
}


+(BOOL)isUserFirstUseFeed
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefault objectForKey:FEED_USE_KEY];
    
    //第一次使用
    if(!value) {
        [userDefault setValue:@"NO" forKey:FEED_USE_KEY];
        return YES;
    }
    return NO;
}


+(BOOL)isUserFirstUseReadCode
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefault objectForKey:READCODE_USE_KEY];
    
    //第一次使用
    if(!value) {
        [userDefault setValue:@"NO" forKey:READCODE_USE_KEY];
        return YES;
    }
    return NO;
}
@end
