//
//  TimeFormatterConvert.m
//  XiaoYou
//
//  Created by sheng on 15/10/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TimeFormatterConvert.h"

@implementation TimeFormatterConvert


//@"2015/10/25 06:00"
+(NSString*)timeConvertToFommtterAvailable:(double)timestamp
{
    NSTimeInterval time = (timestamp + 28800)/1000;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

//15/12/12 18:00-20:00
+(NSString*)timeConvertToFommtterNotice:(double)timestamp
{
    NSTimeInterval time = (timestamp + 28800)/1000;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yy/MM/dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+(NSString*)timeConvertToFommtterNoticeHead:(double)timestamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval nowDateTime = date.timeIntervalSince1970 + 28800;
    NSTimeInterval time = (timestamp + 28800)/1000;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    
    if (nowDateTime - time < 24 * 60 * 60) {
        [dateFormatter setDateFormat:@"今天 HH:mm"];
    } else if (nowDateTime - time < 2 * 24 * 60 * 60) {
        [dateFormatter setDateFormat:@"昨天 HH:mm"];
    } else
    {
        [dateFormatter setDateFormat:@"yy/MM/dd HH:mm"];
    }
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
@end
