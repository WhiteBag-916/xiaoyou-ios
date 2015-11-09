//
//  TimeFormatterConvert.m
//  XiaoYou
//
//  Created by sheng on 15/10/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TimeFormatterConvert.h"

#define TIME_OFFSET 0

@implementation TimeFormatterConvert


+(NSString *)timeConvertToFommtterScheduleStartTime:(double)startTime EndTime:(double)endTime
{
    NSTimeInterval timeNowInter = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeStartInter = startTime /1000;
    NSTimeInterval endTimeInter = endTime/1000;
    
    NSTimeInterval jiange = timeStartInter - timeNowInter;
    if (timeNowInter >= timeStartInter && timeNowInter <= endTimeInter) {
        return @"进行中";
    }
    else if (timeNowInter < timeStartInter) {
        jiange = timeStartInter - timeNowInter;
    }
    if (jiange > 24 * 60 * 60) {
        jiange = jiange /(24 * 60 * 60)*1.0;
        return [NSString stringWithFormat:@"还有%d天开始",(int)jiange];
    } else if (jiange > 60 * 60) {
        jiange = jiange /(60 * 60)*1.0;
        return [NSString stringWithFormat:@"还有%dh开始",(int)jiange];
    } else {
        jiange = jiange /60.0;
        return [NSString stringWithFormat:@"还有%dmin开始",(int)jiange];
    }
    return @"";
}

//@"2015/10/25 06:00"
+(NSString*)timeConvertToFommtterAvailable:(double)timestamp
{
    NSTimeInterval time = (timestamp + TIME_OFFSET)/1000;//因为时差问题要加8小时 == 28800 sec
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
    NSTimeInterval time = (timestamp + TIME_OFFSET)/1000;//因为时差问题要加8小时 == 28800 sec
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
    NSTimeInterval nowDateTime = date.timeIntervalSince1970 + TIME_OFFSET;
    //传递过来时间
    NSTimeInterval time = (timestamp + TIME_OFFSET)/1000;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    
    if ([[self compareDate:detaildate] isEqualToString:@"今天"]) {
        [dateFormatter setDateFormat:@"今天 HH:mm"];
    } else if ([[self compareDate:detaildate] isEqualToString:@"昨天"]) {
        [dateFormatter setDateFormat:@"昨天 HH:mm"];
    } else
    {
        [dateFormatter setDateFormat:@"yy/MM/dd HH:mm"];
    }
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+(NSString *)compareDate:(NSDate *)date{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {
        return dateString;
    }
}
@end
