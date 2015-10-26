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
    NSTimeInterval time = timestamp + 28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

@end
