//
//  YAnalysis.m
//  XiaoYou
//
//  Created by 李思良 on 15/12/4.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YAnalysis.h"
#import "Zhuge.h"
#import "LoginResp.h"
#import "ProfileInfo.h"
@implementation YAnalysis

+ (void)configAnalysis:(NSDictionary*)launchOptions
{
    Zhuge *zg = [Zhuge sharedInstance];
    [zg.config setDebug:true];
    [zg startWithAppKey:ZHUGE_APPKEY launchOptions:launchOptions];
}

+ (void)trackEvent:(NSString *)eventName withPara:(NSDictionary *)param
{
    if (param != nil) {
        [[Zhuge sharedInstance] track:eventName properties:param];
    } else {
        [[Zhuge sharedInstance] track:eventName];
    }
}

+ (void)collectUserInfo:(ProfileInfo *)data
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [[Zhuge sharedInstance] identify:data.studentNo properties:userInfo];
}
@end
