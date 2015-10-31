//
//  AppConfigData.h
//  Component
//
//  Created by sheng on 15/10/14.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HAVETIME_USE_KEY   @"isFirstUseHaveTime"
#define FEED_USE_KEY       @"isFirstUseFeed"
#define READCODE_USE_KEY   @"isFirstUseReadCode"
#define HAVE_REMIND_MESSAGE @"isHaveRemindMessage"

@interface AppConfigData : NSObject

//是否第一次使用有空
+(BOOL)isUserFirstUseHaveTime;
//第一次使用人脉
+(BOOL)isUserFirstUseFeed;
//第一次使用扫码
+(BOOL)isUserFirstUseReadCode;
//是否有提醒消息
+(BOOL)isHaveRemindMessage;
//设置是否有提醒消息
+(void)setHaveRemindMessage:(BOOL)haveMessage;
@end
