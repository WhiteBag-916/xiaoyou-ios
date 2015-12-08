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
    [zg.config setDebug:false];
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
    [[Zhuge sharedInstance] identify:data.studentNo
                          properties:[YAnalysis getDataFromProfileInfo:data]];
}

+ (NSDictionary *)getDataFromShareInProfile:(NSDictionary *)dic
{
    return @{@"学号":dic[@"studentNo"],
//             @"名字":dic[@"name"],
             @"学校":dic[@"schoolCode"],
//             @"学院":dic[@"department"],
//             @"年级":dic[@"grad"],
//             @"性别":dic[@"gender"]
             };
}

+ (NSDictionary *)getDataFromShareInFeed:(NSDictionary *)dic
{
    if ([dic valueForKey:@"studentNo"] != nil) {
        return @{@"学号":dic[@"studentNo"],
//                 @"名字":dic[@"name"],
                 @"学校":dic[@"schoolCode"],
//                 @"性别":dic[@"gender"]
                 };
    } else {
        return @{@"社团":dic[@"name"], @"学校":dic[@"schoolCode"]};
    }
}

+ (NSDictionary *)getDataFromProfileInfo:(ProfileInfo *)profile
{
    if (profile == nil) {
        return nil;
    }
    return @{@"学号":profile.studentNo,
//             @"名字":profile.userName,
             @"学校":profile.schoolCode,
//             @"学院":profile.college,
//             @"年级":profile.grad,
//             @"性别":profile.gender
             };
}
@end
