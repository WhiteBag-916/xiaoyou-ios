//
//  YDate+Ext.m
//  YFramework
//
//  Created by 熊宸 on 15/4/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YDate+Ext.h"

@implementation NSDate(Ext)

//获取年月日如:19871127.
- (NSString *)getFormatYearMonthDay
{
    NSString *string = [NSString stringWithFormat:@"%lu%02lu%02lu",(unsigned long)[self getYear],(unsigned long)[self getMonth],(unsigned long)[self getDay]];
    return string;
}

//该日期是该年的第几周
- (int )getWeekOfYear
{
    int i;
    int year = [self getYear];
    NSDate *date = [self endOfWeek];
    for (i = 1;[[date dateAfterDay:-7 * i] getYear] == year;i++)
    {
    }
    return i;
}
//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterDay;
}
//month个月后的日期
- (NSDate *)dateafterMonth:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterMonth;
}
//获取日
- (NSUInteger)getDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
    return [dayComponents day];
}
//获取月
- (NSUInteger)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
    return [dayComponents month];
}
//获取年
- (NSUInteger)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
    return [dayComponents year];
}
//根据时间计算几几后
- (NSString *)yearAfter
{
    NSUInteger year = [self getYear];
    
    //大于40岁显示 >40 00后都显示95后
    if (year < 1970)
    {
        return @">45";
    }
    else if (year > 1999)
    {
        return @"95后";
    }    
    
    //计算个位
    NSInteger bits = year%10;
    NSString *bitsStr = @"0";
    if (bits >= 5)
    {
        bitsStr = @"5";
    }
    NSString *yearStr = [NSString stringWithFormat:@"%lu", (unsigned long)year];
    //取十位
    NSString *tenStr = [yearStr substringWithRange:NSMakeRange(2, 1)];
    
    return [NSString stringWithFormat:@"%@%@后", tenStr, bitsStr];
}
//获取小时
- (int )getHour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger hour = [components hour];
    return (int)hour;
}
//获取分钟
- (int)getMinute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger minute = [components minute];
    return (int)minute;
}
- (int )getHour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger hour = [components hour];
    return (int)hour;
}
- (int)getMinute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger minute = [components minute];
    return (int)minute;
}
//在当前日期前几天
- (NSUInteger)daysAgo {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}
//午夜时间距今几天
- (NSUInteger)daysAgoAgainstMidnight {
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    
    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo {
    return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
    NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
    NSString *text = nil;
    switch (daysAgo) {
        case 0:
            text = @"Today";
            break;
        case 1:
            text = @"Yesterday";
            break;
        default:
            text = [NSString stringWithFormat:@"%lu days ago", (unsigned long)daysAgo];
    }
    return text;
}

//返回一周的第几天(周末为第一天)
- (NSUInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekday) fromDate:self];
    return [weekdayComponents weekday];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

- (NSString *)string {
    return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    return outputString;
}
//返回周日的开始时间
- (NSDate *)beginningOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:self];
    
    // 得到星期几
    // 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff;
    if (weekDay == 1) {
        firstDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
    }
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    return firstDayOfWeek;
}
//返回当前天的年月日.
- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}
//返回该月的第一天
- (NSDate *)beginningOfMonth
{
    return [self dateAfterDay:-[self getDay] + 1];
}
//该月的最后一天
- (NSDate *)endOfMonth
{
    return [[[self beginningOfMonth] dateafterMonth:1] dateAfterDay:-1];
}
//返回当前周的周末
- (NSDate *)endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:self];
    
    // 得到星期几
    // 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long lastDiff;
    if (weekDay == 1) {
        lastDiff = 7-1;
    }else{
        lastDiff = 7 - weekDay;
    }
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    return lastDayOfWeek;
}

//上个星期的第一天
- (NSDate *)beforeStartOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:self];
    
    // 得到星期几
    // 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff;
    if (weekDay == 1) {
        firstDiff = 1-7;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay-7;
    }
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    return firstDayOfWeek;
}
//下个星期的最后天
- (NSDate *)afterEndOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:self];
    
    // 得到星期几
    // 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long lastDiff;
    if (weekDay == 1) {
        lastDiff = 14-1;
    }else{
        lastDiff = 14 - weekDay;
    }
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    return lastDayOfWeek;
}

- (BOOL) isTodayWithTimeZone:(NSTimeZone*)timeZone{
    return [self isSameDay:[NSDate date] timeZone:timeZone];
}

- (BOOL) isSameDay:(NSDate*)anotherDate timeZone:(NSTimeZone*)timeZone{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.timeZone = timeZone;
    NSDateComponents* components1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    NSDateComponents* components2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}

//转为NSString类型的
+ (NSDate *)dateFromString:(NSString *)string {
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date {
    return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
    /*
     * if the date is in today, display 12-hour time with meridian,
     * if it is within the last 7 days, display weekday name (Friday)
     * if within the calendar year, display as Jan 23
     * else display as Nov 11, 2008
     */
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                                                     fromDate:today];
    
    NSDate *midnight = [calendar dateFromComponents:offsetComponents];
    
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    NSString *displayString = nil;
    
    // comparing against midnight
    if ([date compare:midnight] == NSOrderedDescending) {
        if (prefixed) {
            [displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
        } else {
            [displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
        }
    } else {
        // check if date is within last 7 days
        NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
        [componentsToSubtract setDay:-7];
        NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
        if ([date compare:lastweek] == NSOrderedDescending) {
            [displayFormatter setDateFormat:@"EEEE"]; // Tuesday
        } else {
            // check if same calendar year
            NSInteger thisYear = [offsetComponents year];
            
            NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                                                           fromDate:date];
            NSInteger thatYear = [dateComponents year];
            if (thatYear >= thisYear) {
                [displayFormatter setDateFormat:@"MMM d"];
            } else {
                [displayFormatter setDateFormat:@"MMM d, yyyy"];
            }
        }
        if (prefixed) {
            NSString *dateFormat = [displayFormatter dateFormat];
            NSString *prefix = @"'on' ";
            [displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
        }
    }
    
    // use display formatter to return formatted date string
    displayString = [displayFormatter stringFromDate:date];
    return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
    return [self stringForDisplayFromDate:date prefixed:NO];
}

+ (NSString *)monthFormatString {
    return @"yyyy年MM月";
}

+ (NSString *)dateFormatString {
    return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString {
    return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString {
    return @"yyyy-MM-dd HH:mm:ss";
}

// preserving for compatibility
+ (NSString *)dbFormatString {
    return [NSDate timestampFormatString];
}

#pragma mark - 转换成标准时间
+(NSString *)transformDate:(NSString *) date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    NSDate * tempDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr = [formatter stringFromDate:tempDate];
    
    return dateStr;
}

@end
