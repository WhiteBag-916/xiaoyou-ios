//
//  WeekViewController.m
//  CalendarDemo - Graphical Calendars Library for iOS
//
//  Copyright (c) 2014-2015 Julien Martin. All rights reserved.
//

#import "WeekViewController.h"
#import "MGCDateRange.h"

@interface WeekViewController ()

@property (nonatomic, assign) BOOL needShowToday;

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
    [self.dayPlannerView addNewPlanner];
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

#pragma mark - MGCDayPlannerViewController
- (BOOL)dayPlannerView:(MGCDayPlannerView*)view canCreateNewEventOfType:(MGCEventType)type atDate:(NSDate*)date
{
    return YES;
    //星期天不能加事件
//	NSDateComponents *comps = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
//	return comps.weekday != 1;
}
//
//#pragma mark - CalendarControllerNavigation
//
//- (void)moveToDate:(NSDate*)date animated:(BOOL)animated
//{
//	if (!self.dayPlannerView.dateRange || [self.dayPlannerView.dateRange containsDate:date]) {
//		[self.dayPlannerView scrollToDate:date options:MGCDayPlannerScrollDateTime animated:animated];
//	}
//}
//
//- (void)moveToNextPageAnimated:(BOOL)animated
//{
//	NSDate *date;
//	[self.dayPlannerView pageForwardAnimated:animated date:&date];
//	//NSLog(@"paging forward to %@", date);
//}
//
//- (void)moveToPreviousPageAnimated:(BOOL)animated
//{
//	NSDate *date;
//	[self.dayPlannerView pageBackwardsAnimated:animated date:&date];
//	//NSLog(@"paging backwards to %@", date);
//}
//
//- (NSDate*)centerDate
//{
//	NSDate *date = [self.dayPlannerView dateAtPoint:self.dayPlannerView.center rounded:NO];
//	return date;
//}

@end
