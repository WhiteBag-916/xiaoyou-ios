//
//  YLog.h
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YObject.h"
#import "CocoaLumberjack.h"

#ifdef LOG_LEVEL_DEF
#undef LOG_LEVEL_DEF
#define LOG_LEVEL_DEF YLog_logLevel
#endif

#ifdef LOG_ASYNC_ENABLED
#undef LOG_ASYNC_ENABLED
#ifdef DEBUG
#define LOG_ASYNC_ENABLED YES
#else
#define LOG_ASYNC_ENABLED YES
#endif
#endif

typedef NS_ENUM(NSUInteger, YLogLevel)
{
    YLogLevelOff = DDLogLevelOff,
    YLogLevelError = DDLogLevelError,
    YLogLevelWarning = DDLogLevelWarning,
    YLogLevelInfo = DDLogLevelInfo,
    YLogLevelDebug = DDLogLevelDebug,
    YLogLevelVerbose = DDLogLevelVerbose,
    YLogLevelAll = DDLogLevelAll
};

extern int YLog_logLevel;

#define YLogE(frmt, ...) DDLogError(frmt, ##__VA_ARGS__)
#define YLogW(frmt, ...) DDLogWarn(frmt, ##__VA_ARGS__)
#define YLogI(frmt, ...) DDLogInfo(frmt, ##__VA_ARGS__)
#define YLogD(frmt, ...) DDLogDebug(frmt, ##__VA_ARGS__)
#define YLogV(frmt, ...) DDLogVerbose(frmt, ##__VA_ARGS__)

@interface YLog : YObject

/**
 *  @author Abc
 *
 *  设置日志级别,必须设置,否则不打开日志
 *
 *  @param logLevel 级别,见枚举.
 */
+ (void)setLevel:(YLogLevel)logLevel;

@end
