//
//  YLog.m
//  YFramework
//
//  Created by abc on 15/4/16.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YLog.h"
#import <CocoaLumberjack/DDDispatchQueueLogFormatter.h>

#ifdef DEBUG
int YLog_logLevel = YLogLevelVerbose;
#else
int YLog_logLevel = YLogLevelWarning;
#endif

@interface YLogFormatter : DDDispatchQueueLogFormatter
@end

@implementation YLogFormatter
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    // One-charecter log level

    NSString *logLevel = nil;
    switch (logMessage.flag)
    {

        case DDLogFlagError:
            logLevel = @"[ERROR] > ";
            break;
        case DDLogFlagWarning:
            logLevel = @"[WARN]  > ";
            break;
        case DDLogFlagInfo:
            logLevel = @"[INFO]  > ";
            break;
        case DDLogFlagDebug:
            logLevel = @"[DEBUG] > ";
            break;
        case DDLogFlagVerbose:
            logLevel = @"[VBOSE] > ";
            break;
        default:
            logLevel = @"[VBOSE] > ";
            break;
    }

    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:logMessage.timestamp];
    NSDate *localeDate = [logMessage.timestamp dateByAddingTimeInterval:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSString *formatStr = [NSString stringWithFormat:@"%@ %@[%@ %@][line %@][thread:%@]:\n%@",
                                                     [dateFormatter stringFromDate:localeDate],
                                                     logLevel,
                                                     logMessage.fileName,
                                                     logMessage.function,
                                                     @(logMessage.line),
                                                     [self queueThreadLabelForLogMessage:logMessage],
                                                     logMessage.message];
    return formatStr;
}
@end

@implementation YLog

+ (void)initialize
{
    if (self == [YLog class])
    {
    }
}

+ (void)setLevel:(YLogLevel)logLevel
{
    YLog_logLevel = (int) logLevel;
    [DDLog removeAllLoggers];
    [self addTTYLoggerWithLevel:(YLogLevel) logLevel];
    [self addFileLoggerWithLevel:(YLogLevel) logLevel];
}

#pragma mark - Adding loggers

//+ (void)addDashboardLogger
//{
//#if __has_include(<LumberjackConsole/PTEDashboard.h>)
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^
//                  {
//                      [self restoreLogLevels];
//                      [PTEDashboard.sharedDashboard show];
//                  });
//#else
//    NBULogError(@"%@ Error: LumberjackConsole is required", THIS_METHOD);
//#endif
//}

+ (void)addASLLoggerWithLevel:(YLogLevel)logLevel
{
    DDASLLogger *logger = [DDASLLogger sharedInstance];
    logger.logFormatter = [[YLogFormatter alloc] init];
    [DDLog addLogger:logger withLevel:(DDLogLevel) logLevel];
}

+ (void)addTTYLoggerWithLevel:(YLogLevel)logLevel
{
    DDTTYLogger *ttyLogger = [DDTTYLogger sharedInstance];
    ttyLogger.logFormatter = [[YLogFormatter alloc] init];
    [DDLog addLogger:ttyLogger withLevel:(DDLogLevel) logLevel];

    // XcodeColors installed and enabled?
    char *xcode_colors = getenv("XcodeColors");
    if (xcode_colors && (strcmp(xcode_colors, "YES") == 0))
    {
        // Set default colors
        [ttyLogger setForegroundColor:[DDColor colorWithRed:0.65
                                                      green:0.65
                                                       blue:0.65
                                                      alpha:1.0]
                      backgroundColor:nil
                              forFlag:DDLogFlagVerbose];
        [ttyLogger setForegroundColor:[DDColor colorWithRed:0.4
                                                      green:0.4
                                                       blue:0.4
                                                      alpha:1.0]
                      backgroundColor:nil
                              forFlag:DDLogFlagDebug];
        [ttyLogger setForegroundColor:[DDColor colorWithRed:26.0 / 255.0
                                                      green:158.0 / 255.0
                                                       blue:4.0 / 255.0
                                                      alpha:1.0]
                      backgroundColor:nil
                              forFlag:DDLogFlagInfo];
        [ttyLogger setForegroundColor:[DDColor colorWithRed:244.0 / 255.0
                                                      green:103.0 / 255.0
                                                       blue:8.0 / 255.0
                                                      alpha:1.0]
                      backgroundColor:nil
                              forFlag:DDLogFlagWarning];
        [ttyLogger setForegroundColor:[DDColor redColor]
                      backgroundColor:nil
                              forFlag:DDLogFlagError];

        // Enable colors
        [ttyLogger setColorsEnabled:YES];
    }
}

+ (void)addFileLoggerWithLevel:(YLogLevel)logLevel
{
    DDFileLogger *fileLogger = [DDFileLogger new];
    fileLogger.logFileManager.maximumNumberOfLogFiles = 10;
    fileLogger.logFormatter = [[YLogFormatter alloc] init];
    [DDLog addLogger:fileLogger withLevel:(DDLogLevel) logLevel];
}

@end
