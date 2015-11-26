//
//  TimeFormatterConvert.h
//  XiaoYou
//
//  Created by sheng on 15/10/25.
//  Copyright © 2015年 xc. All rights reserved.
//

/*
 各个地方需要展示时间的函数，统一处理
 */
#import <Foundation/Foundation.h>

@interface TimeFormatterConvert : NSObject

+(NSString*)timeConvertToFommtterScheduleStartTime:(double)startTime EndTime:(double)endTime;

+(NSString*)timeConvertToFommtterAvailable:(double)timestampStr;

+(NSString*)timeConvertToFommtterNotice:(double)timestamp;

+(NSString*)timeConvertToFommtterNoticeHead:(double)timestamp;

+(NSString*)getTimeStamp;

@end
