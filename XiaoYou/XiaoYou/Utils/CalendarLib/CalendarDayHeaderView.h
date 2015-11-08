//
//  CalendarDayHeaderView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//
// 引用于：http://github.com/devinross/tapkulibrary

#import "YView.h"

@protocol CalendarDayHeaderDelegate <NSObject>

- (void)moveToDate:(NSDate *)date;

@end

@interface CalendarDayHeaderView : YView

@property (nonatomic, assign) id<CalendarDayHeaderDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame calendar:(NSCalendar *)calendar;

//初始化
- (void)resetData:(NSDate *)currentDay;

//外面滚动
- (void) _movePagesToIndex:(NSDate *)currentDay animated:(BOOL)animated;

@end
