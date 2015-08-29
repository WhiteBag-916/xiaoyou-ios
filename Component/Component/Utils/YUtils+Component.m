//
//  YUtils+Component.m
//  Component
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YUtils+Component.h"
#import "RegExCategories.h"
#import "Reachability.h"

@implementation YUtils(Component)

+ getUrl:(NSString *)bussinessPath
{
    NSString *baseUrl = api_server_base_url;
    NSString *url = [baseUrl stringByAppendingString:bussinessPath];
    
    return url;
}

+ getUrl:(NSString *)bussinessPath needUserToken:(BOOL)needUserToken {
    NSString *url = [self getUrl:bussinessPath];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?token=%@&schoolCode=%@&studentNo=%@", [YShareData defaultData][kShareData_Token], [YShareData defaultData][kShareData_SchoolCode] ,[YShareData defaultData][kShareData_StudentNo]]];
    return url;
}

+ getParameter {
    NSMutableDictionary *dic = [@{kYHttpRequestHeader : @{@"Content-type":@"application/json"}} mutableCopy];
    
    return dic;
}

+ getParameter:(NSDictionary *)parameters
{
    NSMutableDictionary *dic = [@{kYHttpRequestPostData : [self dictionaryToJson:parameters], kYHttpRequestHeader : @{@"Content-type":@"application/json"}} mutableCopy];
    
    return dic;
}

+ getParameter:(NSDictionary *)parameters needUserToken:(BOOL)needUserToken
{
    if (needUserToken)
    {
        NSMutableDictionary *dic;
        if (nil != parameters) {
            dic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        }
        else {
            dic = [[NSMutableDictionary alloc] init];
        }
        [dic setValue:@{@"schoolCode": [YShareData defaultData][kShareData_SchoolCode],
                        @"studentNo": [YShareData defaultData][kShareData_StudentNo],
                        @"token": [YShareData defaultData][kShareData_Token]}
               forKey:@"userToken"];
        return [self getParameter:dic];
    }
    
    return [self getParameter:parameters];
}

+ getParameter:(NSDictionary *)parameters needUserToken:(BOOL)needUserToken needAddUserID:(BOOL)needAddUserID {
    
    NSMutableDictionary *dic;
    if (nil != parameters) {
        dic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        [dic setObject:[YShareData defaultData][kShareData_UserID] forKey:@"userId"];
    } else {
        dic = [@{@"userId":[YShareData defaultData][kShareData_UserID]} mutableCopy];
    }
    
    return [self getParameter:dic needUserToken:needUserToken];
}

+ (NSString *)distanceTimeToday:(NSDate *)date
{
    NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return result;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSString *)dateStringWithTimeIntervalString:(NSString *)timeIntervalString
{
    if (timeIntervalString.length == 0 || timeIntervalString.integerValue == 0) {
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeIntervalString longLongValue]];
    return [NSString stringWithFormat:@"%ld年%ld月",(unsigned long)[date getYear],[date getMonth]];
}

//根据需求进行图片裁剪的url
+ (NSString*)initImageProcessingUrl:(NSString *)type width:(int)imageWidth height:(int)imageHeight
{
    NSString *url = [NSString stringWithFormat:@"?imageView2/%@",type];
    if (imageWidth > 0)
    {
        url = [url stringByAppendingPathComponent:[NSString stringWithFormat:@"/w/%d", imageWidth]];
    }
    
    if (imageHeight > 0)
    {
        url = [url stringByAppendingPathComponent:[NSString stringWithFormat:@"/h/%d", imageHeight]];
    }
    return url;
}

// 是否能有网络连接
+ (BOOL) IsEnableConnection {
    if (([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) &&
        ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable)) {
        return NO;
    }
    
    return YES;
}
@end