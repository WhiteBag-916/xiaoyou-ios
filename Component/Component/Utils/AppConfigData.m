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
#define HAVE_REMIND_MESSAGE @"isHaveRemindMessage"
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

+(BOOL)isHaveRemindMessage
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefault objectForKey:HAVE_REMIND_MESSAGE];
    
    //第一次使用
    if(!value) {
        [userDefault setValue:@"NO" forKey:HAVE_REMIND_MESSAGE];
        return YES;
    }
    return NO;
}

+(void)setHaveRemindMessage:(BOOL)haveMessage
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (haveMessage) {
        [userDefault setValue:@"YES" forKey:HAVE_REMIND_MESSAGE];
    }
    else
    {
        [userDefault removeObjectForKey:HAVE_REMIND_MESSAGE];
    }
}

@end
