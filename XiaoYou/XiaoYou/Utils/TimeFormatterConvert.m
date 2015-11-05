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
        return [NSString stringWithFormat:@"还有%dH开始",(int)jiange];
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
    NSTimeInterval time = (timestamp + TIME_OFFSET)/1000;//因为时差问题要加8小时 == 28800 sec
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
