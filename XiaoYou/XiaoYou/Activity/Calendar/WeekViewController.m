//
//  WeekViewController.m
//  CalendarDemo - Graphical Calendars Library for iOS
//
//  Copyright (c) 2014-2015 Julien Martin. All rights reserved.
//

#import "WeekViewController.h"
#import "MGCDateRange.h"
#import "ActivityManager.h"
#import "UserSchedulingInfo.h"
#import "MGCStandardEventView.h"
#import "ScheduleDetailViewController.h"
#import "NewScheduleViewController.h"
#import "ActivityDetailViewController.h"

static NSString* const EventCellReuseIdentifier = @"EventCellReuseIdentifier";

@interface WeekViewController ()

@property (nonatomic, assign) BOOL needShowToday;

@property (nonatomic, strong) NSDate *userSchedulingListBeginDate;//拉取的第一天
@property (nonatomic, strong) NSDate *userSchedulingListEndDate;  //拉取的最后天

@property (nonatomic, strong) NSMutableArray *userSchedulingInfoArray;

@end

@implementation WeekViewController


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showCustomNavigationBackButton];
    [self initRightBar];
    self.title = @"你的日程卡";
    
	self.dayPlannerView.backgroundColor = [UIColor whiteColor];
	self.dayPlannerView.backgroundView = [UIView new];
	self.dayPlannerView.backgroundView.backgroundColor = [UIColor clearColor];
	self.dayPlannerView.dateFormat = @"eeeee\nd MMM";
	self.dayPlannerView.dayHeaderHeight = 50;
    
    _needShowToday = YES;
    self.userSchedulingInfoArray = [@[] mutableCopy];
    
    self.dayPlannerView.calendar = self.calendar;
    self.dayPlannerView.showsAllDayEvents = NO;
    [self.dayPlannerView registerClass:MGCStandardEventView.class forEventViewWithReuseIdentifier:EventCellReuseIdentifier];
    
    [self initData:nil needLoading:YES needNowWeek:YES needBeforeWeek:YES needAfterWeek:YES];
    //获取提醒时间
    [[ActivityManager sharedInstance] userSchedulingConditions:^(YActionMessage *message) {
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSchedule:) name:KNotification_Change_Schedule object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initRightBar {
    //right barbutton view
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 15, 30);
    [rightButton setImage:[UIImage imageNamed:@"havetime_icon_add"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"havetime_icon_add"] forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:@selector(newPlanner) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnNavRightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = btnNavRightItem;
}

- (void)newPlanner {
    [self newScheduleByInfo:nil];
}

- (void)newScheduleByInfo:(UserSchedulingInfo *)info {
    NewScheduleViewController *vc = [[NewScheduleViewController alloc] initWithInfo:info];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)onNavigationLeftButtonClicked {
    _needShowToday = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_needShowToday) {
        [self.dayPlannerView scrollToToday:YES];
        
        _needShowToday = NO;
    }
    
}

//拉取数据,时间，获取前面一个星期，获取后面一个星期
- (void)initData:(NSDate *)date needLoading:(BOOL)needLoading needNowWeek:(BOOL)needNowWeek needBeforeWeek:(BOOL)needBeforeWeek needAfterWeek:(BOOL)needAfterWeek {
    NSDate *needDate = date==nil?[NSDate date]:date;
    //计算这个星期星期
    NSDate *beginDate;
    NSDate *endDate;
    if (needNowWeek) {
        if (needBeforeWeek) {
            beginDate = [needDate beforeStartOfWeek];
        }
        if (needAfterWeek) {
            endDate = [needDate afterEndOfWeek];
        }
    } else {
        if (needBeforeWeek) {
            beginDate = [needDate beforeStartOfWeek];
            endDate = [beginDate endOfWeek];
        }else if (needAfterWeek) {
            endDate = [needDate afterEndOfWeek];
            beginDate = [endDate beginningOfWeek];
        }
    }
    
    if (_userSchedulingListBeginDate != beginDate || _userSchedulingListEndDate != endDate) {
        if (needBeforeWeek) {
            _userSchedulingListBeginDate = beginDate;
        }
        if (needAfterWeek) {
            _userSchedulingListEndDate = endDate;
        }
        
        [self updateListDate:needLoading];
    }
}

- (void)updateListDate:(BOOL)needLoading {
    if (needLoading) {
        [YUtils showHUDWithTitle];
    }
    
    [[ActivityManager sharedInstance] userSchedulingList:[_userSchedulingListBeginDate timeIntervalSince1970]*1000 endDate:[_userSchedulingListEndDate timeIntervalSince1970]*1000 block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        
        [self addSchedulingArray:message.object];
    }];
}

#pragma mark - Properties
- (NSCalendar*)calendar
{
    if (_calendar == nil) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

- (void)changeSchedule:(NSNotification *)notification {
    NSDictionary *dic = [notification userInfo];
    
    UserSchedulingInfo *info = dic[@"info"];
    
    if ([dic[@"state"] isEqualToString:@"del"]) {
        //删除
        [self delScheduling:info.internalBaseClassIdentifier scheduleType:info.type];
    } else {
        //添加
        [self addSchedulingArray:@[info]];
    }
}

//删除
- (void)delScheduling:(NSInteger)internalBaseClassIdentifier scheduleType:(NSString *)scheduleType {
    [_userSchedulingInfoArray enumerateObjectsUsingBlock:^(UserSchedulingInfo * _Nonnull userSchedulingInfoObj, NSUInteger userSchedulingInfoIdx, BOOL * _Nonnull userSchedulingInfoStop) {
        
        if (userSchedulingInfoObj.internalBaseClassIdentifier == internalBaseClassIdentifier
            && [userSchedulingInfoObj.type isEqualToString:scheduleType]) {
            
            [_userSchedulingInfoArray removeObjectAtIndex:userSchedulingInfoIdx];
            [self.dayPlannerView reloadAllEvents];
            
            *userSchedulingInfoStop = YES;
        }
        
    }];
}

//增加数组
- (void)addSchedulingArray:(NSArray *)array {
    if (array.count <= 0) {
        return;
    }
    //去重
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:array];
    
    [_userSchedulingInfoArray enumerateObjectsUsingBlock:^(UserSchedulingInfo * _Nonnull userSchedulingInfoObj, NSUInteger userSchedulingInfoIdx, BOOL * _Nonnull userSchedulingInfoStop) {

        [dataArray enumerateObjectsUsingBlock:^(UserSchedulingInfo * _Nonnull dataArrayObj, NSUInteger dataArrayIdx, BOOL * _Nonnull dataArrayStop) {
            if (userSchedulingInfoObj.internalBaseClassIdentifier == dataArrayObj.internalBaseClassIdentifier
                && [userSchedulingInfoObj.type isEqualToString:dataArrayObj.type]) {
                //删除旧的，加新的
                [_userSchedulingInfoArray removeObject:userSchedulingInfoObj];
                *dataArrayStop = YES;
            }
        }];
        
    }];
    
    [_userSchedulingInfoArray addObjectsFromArray:dataArray];
    
    [self.dayPlannerView reloadAllEvents];
}

//根据时间获取array
- (NSArray *)eventArrayOfDate:(NSDate *)date {
    NSMutableArray *eventArray = [@[] mutableCopy];
    
    [_userSchedulingInfoArray enumerateObjectsUsingBlock:^(UserSchedulingInfo * _Nonnull userSchedulingInfoObj, NSUInteger userSchedulingInfoIdx, BOOL * _Nonnull userSchedulingInfoStop) {
        NSDate *eventStartTime = [NSDate dateWithTimeIntervalSince1970:userSchedulingInfoObj.startTime/1000];
        if ([eventStartTime isSameDay:date timeZone:[NSTimeZone defaultTimeZone]]) {
            [eventArray addObject:userSchedulingInfoObj];
        } else {
            //时间被包含
            NSTimeInterval dateTime1970 = [date timeIntervalSince1970]*1000;
            if (userSchedulingInfoObj.startTime <= dateTime1970 && dateTime1970 <= userSchedulingInfoObj.endTime) {
                [eventArray addObject:userSchedulingInfoObj];
            }
        }
    }];
    
    return eventArray;
}

//根据时间获取model
- (UserSchedulingInfo *)eventOfDate:(NSInteger)index date:(NSDate *)date {
    NSArray *eventArray = [self eventArrayOfDate:date];
    
    return eventArray[index];
}

- (UIColor *)colorByType:(NSString *)type {
    UIColor *color;
    
    if ([type isEqualToString:@"user_scheduling"]) {
        color = [UIColor hexChangeFloat:@"465a65"];
    } else if ([type isEqualToString:@"course"]) {
        color = [UIColor hexChangeFloat:@"5297b8"];
    } else if ([type isEqualToString:@"activity"]) {
        color = [UIColor hexChangeFloat:@"eca433"];
    }
    
    return color;
}

#pragma mark - MGCDayPlannerViewController
- (BOOL)dayPlannerView:(MGCDayPlannerView*)view canCreateNewEventOfType:(MGCEventType)type atDate:(NSDate*)date
{
    return YES;
}

#pragma mark - MGCDayPlannerViewDataSource

- (NSInteger)dayPlannerView:(MGCDayPlannerView*)weekView numberOfEventsOfType:(MGCEventType)type atDate:(NSDate*)date
{
    NSInteger count = 0;
    
    count = [[self eventArrayOfDate:date] count];

    return count;
}

- (MGCEventView*)dayPlannerView:(MGCDayPlannerView*)view viewForEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
{
    UserSchedulingInfo *ev = [self eventOfDate:index date:date];
    
    MGCStandardEventView *evCell = (MGCStandardEventView*)[view dequeueReusableViewWithIdentifier:EventCellReuseIdentifier forEventOfType:type atIndex:index date:date];
    evCell.title = ev.content;
//    evCell.subtitle = ev.address;
    evCell.color = [self colorByType:ev.type];//[UIColor colorWithCGColor:ev.calendar.CGColor];
    evCell.style = MGCStandardEventViewStylePlain|MGCStandardEventViewStyleSubtitle;
    evCell.style |= (type == MGCAllDayEventType) ?: MGCStandardEventViewStyleBorder;
    evCell.font = CONTENT_FONT(12);
    return evCell;
}

- (BOOL)dayPlannerView:(MGCDayPlannerView*)view shouldStartMovingEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
{
//    UserSchedulingInfo *ev = [self eventOfDate:index date:date];
//    if ([ev.type isEqualToString:@"user_scheduling"]) {
//        return YES;
//    }
    return NO;
}

//- (BOOL)dayPlannerView:(MGCDayPlannerView*)view canMoveEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date toType:(MGCEventType)targetType date:(NSDate*)targetDate
//{
//    return NO;
//}


- (MGCDateRange*)dayPlannerView:(MGCDayPlannerView*)view dateRangeForEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
{
    UserSchedulingInfo *ev = [self eventOfDate:index date:date];
    
    NSDate *start = [NSDate dateWithTimeIntervalSince1970:ev.startTime/1000];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:ev.endTime/1000];
//    if (type == MGCAllDayEventType) {
//        end = [self.calendar mgc_nextStartOfDayForDate:end];
//    }
    
    return [MGCDateRange dateRangeWithStart:start end:end];
}

//- (void)dayPlannerView:(MGCDayPlannerView*)view moveEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date toType:(MGCEventType)targetType date:(NSDate*)targetDate
//{
//    UserSchedulingInfo *ev = [self eventOfDate:index date:date];
//    
//    if (ev) {
//        NSDateComponents *duration = [self.calendar components:NSMinuteCalendarUnit fromDate:[NSDate dateWithTimeIntervalSince1970:ev.startTime/1000] toDate:[NSDate dateWithTimeIntervalSince1970:ev.endTime/1000] options:0];
//        NSDate *end = [self.calendar dateByAddingComponents:duration toDate:targetDate options:0];
//        
//        // allDay property has to be set before start and end dates !
//        ev.startTime = [targetDate timeIntervalSince1970];
//        ev.endTime = [end timeIntervalSince1970];
//        
//        //修改
//        [self editUserScheduling:ev];
//    }
//}
//
- (MGCEventView*)dayPlannerView:(MGCDayPlannerView*)view viewForNewEventOfType:(MGCEventType)type atDate:(NSDate*)date
{
    //	EKCalendar *defaultCalendar = [self.eventStore defaultCalendarForNewEvents];
    
    MGCStandardEventView *evCell = [MGCStandardEventView new];
    evCell.title = NSLocalizedString(@"New Event", nil);
    evCell.color = KCOLOR_g1;//[UIColor colorWithCGColor:defaultCalendar.CGColor];
    return evCell;
}

- (void)dayPlannerView:(MGCDayPlannerView *)view createNewEventOfType:(MGCEventType)type atDate:(NSDate*)date
{
    [self.dayPlannerView endInteraction];
    
    UserSchedulingInfo *ev = [UserSchedulingInfo new];
    ev.startTime = [date timeIntervalSince1970]*1000;
    //后一个小时
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *lastDayComp = [self.calendar components:unitFlags fromDate:date];
    [lastDayComp setHour:1+lastDayComp.hour];
    NSDate *lastDayOfWeek= [self.calendar dateFromComponents:lastDayComp];
    ev.endTime = [lastDayOfWeek timeIntervalSince1970]*1000;
    ev.noticeTimePeriod = -1;
    
    [self newScheduleByInfo:ev];
}

#pragma mark - MGCDayPlannerViewDelegate

- (void)dayPlannerView:(MGCDayPlannerView*)view didSelectEventOfType:(MGCEventType)type atIndex:(NSUInteger)index date:(NSDate*)date
{
    UserSchedulingInfo *ev = [self eventOfDate:index date:date];
    
    if ([ev.type isEqualToString:@"activity"]) {
        ActivityDetailViewController *vc = [[ActivityDetailViewController alloc] initWithPublishID:[NSString stringWithFormat:@"%g", ev.internalBaseClassIdentifier]];
        [self.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
    } else {
        ScheduleDetailViewController *vc = [[ScheduleDetailViewController alloc] initWithInfo:ev];
        [self.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
    }
}

- (void)dayPlannerView:(MGCDayPlannerView*)view didEndDisplayingDate:(NSDate*)date {
    if ([date beginningOfWeek] <= _userSchedulingListBeginDate) {
        //取上个星期的
        [self initData:date needLoading:NO needNowWeek:NO needBeforeWeek:YES needAfterWeek:NO];
    } else if ([date endOfWeek] >= _userSchedulingListEndDate) {
        //取下个星期的
        [self initData:date needLoading:NO needNowWeek:NO needBeforeWeek:NO needAfterWeek:YES];
    }
}

@end
