//
//  CalendarDayHeaderView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YView.h"

@interface CalendarDayHeaderView : YView

- (instancetype)initWithFrame:(CGRect)frame calendar:(NSCalendar *)calendar;

//初始化
- (void)resetData:(NSDate *)currentDay;

//外面滚动
- (void) _movePagesToIndex:(NSInteger)nowPage animated:(BOOL)animated;

@end
