//
//  TimeFormatterConvert.h
//  XiaoYou
//
//  Created by sheng on 15/10/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeFormatterConvert : NSObject

+(NSString*)timeConvertToFommtterAvailable:(double)timestampStr;

+(NSString*)timeConvertToFommtterNotice:(double)timestamp;

+(NSString*)timeConvertToFommtterNoticeHead:(double)timestamp;
@end
