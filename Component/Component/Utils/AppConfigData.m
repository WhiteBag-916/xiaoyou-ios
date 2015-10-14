//
//  AppConfigData.m
//  Component
//
//  Created by sheng on 15/10/14.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AppConfigData.h"
#define FIRST_USE_KEY   @"isFirstUse"
@implementation AppConfigData


+(BOOL)isUserFirstUseIt
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefault objectForKey:FIRST_USE_KEY];
    
    //第一次使用
    if(!value) {
        [userDefault setValue:@"NO" forKey:FIRST_USE_KEY];
        return YES;
    }
    return NO;
}


@end
