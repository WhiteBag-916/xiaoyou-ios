//
//  CalendarDayHeaderView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CalendarDayHeaderView.h"

#define DAY_LABEL_WIDTH 35.0f
#define DAY_FONT_SIZE 18

@interface TKDateLabel : UILabel
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,assign) BOOL today;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign) BOOL weekend;
@end

@implementation TKDateLabel


- (instancetype) initWithFrame:(CGRect)frame{
    if(!(self=[super initWithFrame:frame])) return nil;
    self.textAlignment = NSTextAlignmentCenter;
    self.layer.cornerRadius = DAY_LABEL_WIDTH / 2.0f;
    self.clipsToBounds = YES;
    [self _updateLabelColorState];
    return self;
}


- (void) tintColorDidChange{
    [self _updateLabelColorState];
}

- (void) _updateLabelColorState{
    
    if(self.selected){
        self.backgroundColor = self.today ? KCOLOR_g1 : KCOLOR_B5;
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont boldSystemFontOfSize:DAY_FONT_SIZE];
    }else{
        UIColor *clr = self.weekend ? KCOLOR_B5 : [UIColor blackColor];
        self.textColor = self.today ? KCOLOR_g1 : clr;
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont systemFontOfSize:DAY_FONT_SIZE];
    }
    self.tag = self.today ? 1 : 0;
}

- (void) setSelected:(BOOL)selected{
    if(selected == _selected) return;
    
    _selected = selected;
    [self _updateLabelColorState];
}
- (void) setToday:(BOOL)today{
    if(_today == today) return;
    _today = today;
    [self _updateLabelColorState];
}
- (void) setWeekend:(BOOL)weekend{
    _weekend = weekend;
    [self _updateLabelColorState];
}

@end

@interface TKWeekdaysView : UIView
@property (nonatomic,strong) NSArray *weekdayLabels;
@end

@implementation TKWeekdaysView
- (instancetype) initWithFrame:(CGRect)frame{
    if(!(self=[super initWithFrame:frame])) return nil;
    
    NSInteger per = self.width - (DAY_LABEL_WIDTH *7);
    per /= 7;
    NSInteger minX = per / 2;
    
    NSMutableArray *labels = [NSMutableArray arrayWithCapacity:7];
    for(NSInteger i=0;i<7;i++){
        TKDateLabel *label = [[TKDateLabel alloc] initWithFrame:CGRectMake(minX+(DAY_LABEL_WIDTH+per)*i, 16, DAY_LABEL_WIDTH, DAY_LABEL_WIDTH)];
        label.weekend = i % 6 == 0;
        //label.backgroundColor = [UIColor redColor];
        [self addSubview:label];
        [labels addObject:label];
    }
    
    
    self.weekdayLabels = labels.copy;
    
    return self;
}
@end

@interface CalendarDayHeaderView ()
<UIScrollViewDelegate>

@property (nonatomic,strong) UILabel *monthYearLabel;
@property (nonatomic,strong) UIScrollView *daysScrollView;
@property (nonatomic,strong) NSMutableArray *weekdayPages;
@property (nonatomic,strong) NSCalendar *calendar;
@property (nonatomic,strong) NSDate *currentDay;
@property (nonatomic,assign) NSInteger indexOfCurrentDay;

@end

@implementation CalendarDayHeaderView

- (instancetype)initWithFrame:(CGRect)frame calendar:(NSCalendar *)calendar {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.calendar = calendar;
        
        [self initHeadView];
        
        [self initDateView];
        
        [self initDayView];
    }
    
    return self;
}

//星期
- (void)initHeadView {
    NSInteger cnt = 0;
    NSArray *daySymbols = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];//[[NSCalendar currentCalendar] shortWeekdaySymbols];
    CGFloat wid = CGRectGetWidth(self.frame);
    wid -= 8;
    
    NSInteger per = self.width - (DAY_LABEL_WIDTH *7);
    per /= 7;
    NSInteger minX = per / 2;
    
    for(NSString *str in daySymbols){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(minX + cnt*(DAY_LABEL_WIDTH+per) , 0, DAY_LABEL_WIDTH, 20)];
        label.font = [UIFont systemFontOfSize:10];
        label.text = str;
        label.textColor = cnt == 0 || cnt == 6 ? KCOLOR_B5 : [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = NO;
        [self addSubview:label];
//        [label sizeToFitWithAlignment];
        
        cnt++;
    }
}

//日期
- (void)initDayView {
    self.weekdayPages = [NSMutableArray arrayWithCapacity:3];
    
    [self addSubview:self.daysScrollView];

    UIView *dayContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.daysScrollView.width*3, CGRectGetHeight(self.daysScrollView.frame))];
    [self.daysScrollView addSubview:dayContainerView];
    
    CGRect weekFrame = self.daysScrollView.frame;
    weekFrame.origin = CGPointZero;
    for(NSInteger i=0;i<3;i++){
        
        weekFrame.origin.x = CGRectGetWidth(weekFrame) * i;
        TKWeekdaysView *weekdayView = [[TKWeekdaysView alloc] initWithFrame:weekFrame];
        for(UILabel *label in weekdayView.weekdayLabels){
            label.userInteractionEnabled = YES;
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapWeekdayLabel:)]];
        }
        [dayContainerView addSubview:weekdayView];
        [weekdayView bringSubviewToFront:dayContainerView];
        [self.weekdayPages addObject:weekdayView];
    }
}

//完整日期
- (void)initDateView {
    [self addSubview:self.monthYearLabel];
}

#pragma mark WeekDay
- (void) _advanceWeekToIndex:(NSInteger)index animated:(BOOL)animated{
    self.userInteractionEnabled = NO;
    
    BOOL moveRight = index > 1 ? YES : NO;
    NSInteger pageToUpdate = moveRight ? 2 : 0;
    
    TKWeekdaysView *weekView = self.weekdayPages[pageToUpdate];
    TKDateLabel *currentLabel = weekView.weekdayLabels[self.indexOfCurrentDay];
    NSDate *theNewDate = currentLabel.date;
    [self _resetWeekdayOrderByMoving:moveRight];
    
    if (self.delegate) {
        [self.delegate moveToDate:theNewDate];
    }
    
//    [self _timelineAtIndex:pageToUpdate].date = theNewDate;
//    [self _refreshDataWithPageAtIndex:pageToUpdate];
//
//    
//    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
//        
//        self.horizontalScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.horizontalScrollView.frame) * pageToUpdate, 0);
//        
//    }completion:^(BOOL finished){
//        
//        
//        UIScrollView *needsUpdating = nil;
//        NSInteger updateIndex = 1;
//        
//        if(pageToUpdate<1){
//            UIScrollView *sv = [self.pages lastObject];
//            [self.pages insertObject:sv atIndex:0];
//            [self.pages removeLastObject];
//            needsUpdating = sv;
//            updateIndex = 0;
//        }else if(pageToUpdate>1){
//            UIScrollView *sv = self.pages[0];
//            [self.pages addObject:sv];
//            [self.pages removeObjectAtIndex:0];
//            needsUpdating = sv;
//            updateIndex = 2;
//        }
//        
//        self.currentDay = theNewDate;
//        [self _updateDateLabel];
//        
//        NSDateComponents *info = [self.currentDay dateComponentsWithTimeZone:self.calendar.timeZone];
//        info.day += pageToUpdate < 1 ? -1 : 1;
//        [self _timelineWithScrollView:needsUpdating].date = [NSDate dateWithDateComponents:info];
//        
//        
//        NSInteger i = 0;
//        for(UIScrollView *sv in self.pages){
//            CGRect r = sv.frame;
//            r.origin.x = HORIZONTAL_PAD + CGRectGetWidth(self.horizontalScrollView.frame) * i;
//            sv.frame = r;
//            i++;
//        }
//        self.horizontalScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.horizontalScrollView.frame), 0);
//        
//        NSArray *allLabels = [self _allDayLabels];
//        [self _timelineAtIndex:0].date = [allLabels[self.indexOfCurrentDay+7-1] date];
//        [self _timelineAtIndex:2].date = [allLabels[self.indexOfCurrentDay+7+1] date];
//        ((UIScrollView*)self.pages[0]).contentOffset = CGPointZero;
//        ((UIScrollView*)self.pages[2]).contentOffset = CGPointZero;
//        [self _refreshDataWithPageAtIndex:0];
//        [self _refreshDataWithPageAtIndex:2];
//        
//        needsUpdating.contentOffset = CGPointZero;
//        [self _refreshDataWithPageAtIndex:updateIndex];
//        
//        
//        if(self.delegate && [self.delegate respondsToSelector:@selector(calendarDayTimelineView:didMoveToDate:)])
//            [self.delegate calendarDayTimelineView:self didMoveToDate:self.currentDay];
//        
//        [self _scrollToTopEvent:YES];
//        
//        
//        if(self.delegate && [self.delegate respondsToSelector:@selector(calendarDayTimelineView:didMoveToDate:)])
//            [self.delegate calendarDayTimelineView:self didMoveToDate:self.currentDay];
//        
//
        [self resetData:theNewDate];
//        [UIView transitionWithView:self.daysScrollView.subviews.firstObject duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self _updateSelectedWeekdayAtIndex:self.indexOfCurrentDay+7];
//        }completion:nil];
//
//        [self _scrollToTopEvent:animated];
        self.userInteractionEnabled = YES;
//
//        
//    }];
    
    
    
}
- (void)_resetWeekdayOrderByMoving:(BOOL)forwards{
    
    if(forwards){
        TKWeekdaysView *weekView = [self.weekdayPages firstObject];
        [self.weekdayPages addObject:weekView];
        [self.weekdayPages removeObjectAtIndex:0];
        
        TKWeekdaysView *currentWeekView = self.weekdayPages[1];
        TKDateLabel *currentPageLabel  = currentWeekView.weekdayLabels.lastObject;
        
        NSDateComponents *mutedCom = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra fromDate:currentPageLabel.date];
        mutedCom.day++;
        for(TKDateLabel *label in weekView.weekdayLabels){
            
            NSDate *aDate = [self.calendar dateFromComponents:mutedCom];
            mutedCom = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra fromDate:aDate];
            label.text = [NSString stringWithFormat:@"%@",@(mutedCom.day)];
            label.date = aDate;
            label.today = [aDate isTodayWithTimeZone:self.calendar.timeZone];
            label.selected = [aDate isSameDay:self.currentDay timeZone:self.calendar.timeZone];
            mutedCom.day++;
            
        }
        
    }else{
        TKWeekdaysView *weekView = [self.weekdayPages lastObject];
        [self.weekdayPages insertObject:weekView atIndex:0];
        [self.weekdayPages removeLastObject];
        
        TKWeekdaysView *currentWeekView = self.weekdayPages[1];
        TKDateLabel *currentPageLabel  = currentWeekView.weekdayLabels.firstObject;
        
        NSDateComponents *mutedCom = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra fromDate:currentPageLabel.date];
        mutedCom.day --;
        for(TKDateLabel *label in weekView.weekdayLabels.reverseObjectEnumerator){
            
            NSDate *aDate = [self.calendar dateFromComponents:mutedCom];
            mutedCom = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra fromDate:aDate];
            label.text = [NSString stringWithFormat:@"%@",@(mutedCom.day)];
            label.date = aDate;
            label.today = [aDate isTodayWithTimeZone:self.calendar.timeZone];
            label.selected = [aDate isSameDay:self.currentDay timeZone:self.calendar.timeZone];
            mutedCom.day --;
            
        }
        
        
    }
    
    
    NSInteger i = 0;
    for(TKWeekdaysView *sv in self.weekdayPages){
        CGRect r = sv.frame;
        r.origin.x = CGRectGetWidth(self.daysScrollView.frame) * i;
        sv.frame = r;
        i++;
    }
    self.daysScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.daysScrollView.frame), 0);
    
}
- (void) _updateSelectedWeekdayAtIndex:(NSInteger)allLabelsIndex{
    
    NSArray *allLabel = [self _allDayLabels];
    
    NSInteger index = allLabelsIndex;
    NSInteger i=0;
    for(TKDateLabel *label in allLabel){
        label.selected = i == index;
        i++;
    }
    
    
}
- (void) didTapWeekdayLabel:(UITapGestureRecognizer*)sender{
    
    NSArray *allLabels = [self _allDayLabels];
    NSInteger indexOfSelectedLabel = [allLabels indexOfObject:sender.view];
    
    if(indexOfSelectedLabel == NSNotFound) return;
    
    TKDateLabel *label = allLabels[indexOfSelectedLabel];
    NSDate *theNewDate = label.date;
    
    if([label.date isSameDay:self.currentDay timeZone:self.calendar.timeZone]) return;
    
//    BOOL moveRight = [label.date compare:self.currentDay] == NSOrderedDescending;
//    NSInteger pageToUpdate = moveRight ? 2 : 0;
    
    self.userInteractionEnabled = NO;
    
//    [self _timelineAtIndex:pageToUpdate].date = label.date;
//    [self _refreshDataWithPageAtIndex:pageToUpdate];
    
    if (self.delegate) {
        [self.delegate moveToDate:theNewDate];
    }
    
    [UIView transitionWithView:self.daysScrollView.subviews.firstObject duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self _updateSelectedWeekdayAtIndex:indexOfSelectedLabel];
    }completion:nil];
//
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        self.horizontalScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.horizontalScrollView.frame) * pageToUpdate, 0);
//    }completion:^(BOOL finished){
//        
//        
//        UIScrollView *needsUpdating = nil;
//        NSInteger updateIndex = 1;
//        
//        if(pageToUpdate<1){
//            UIScrollView *sv = [self.pages lastObject];
//            [self.pages insertObject:sv atIndex:0];
//            [self.pages removeLastObject];
//            needsUpdating = sv;
//            updateIndex = 0;
//        }else if(pageToUpdate>1){
//            UIScrollView *sv = self.pages[0];
//            [self.pages addObject:sv];
//            [self.pages removeObjectAtIndex:0];
//            needsUpdating = sv;
//            updateIndex = 2;
//        }
//        
//        self.currentDay = theNewDate;
//        [self _updateDateLabel];
//        
//        NSDateComponents *info = [self.currentDay dateComponentsWithTimeZone:self.calendar.timeZone];
//        info.day += pageToUpdate < 1 ? -1 : 1;
//        [self _timelineWithScrollView:needsUpdating].date = [NSDate dateWithDateComponents:info];
//        
//        
//        NSInteger i = 0;
//        for(UIScrollView *sv in self.pages){
//            CGRect r = sv.frame;
//            r.origin.x = HORIZONTAL_PAD + CGRectGetWidth(self.horizontalScrollView.frame) * i;
//            sv.frame = r;
//            i++;
//        }
//        self.horizontalScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.horizontalScrollView.frame), 0);
//        
//        
//        [self _timelineAtIndex:0].date = [allLabels[indexOfSelectedLabel-1] date];
//        [self _timelineAtIndex:2].date = [allLabels[indexOfSelectedLabel+1] date];
//        ((UIScrollView*)self.pages[0]).contentOffset = CGPointZero;
//        ((UIScrollView*)self.pages[2]).contentOffset = CGPointZero;
//        [self _refreshDataWithPageAtIndex:0];
//        [self _refreshDataWithPageAtIndex:2];
//        
//        needsUpdating.contentOffset = CGPointZero;
//        [self _refreshDataWithPageAtIndex:updateIndex];
//        
//        
//        if(self.delegate && [self.delegate respondsToSelector:@selector(calendarDayTimelineView:didMoveToDate:)])
//            [self.delegate calendarDayTimelineView:self didMoveToDate:self.currentDay];
//        
//        [self _scrollToTopEvent:YES];
//        
        self.userInteractionEnabled = YES;
        self.indexOfCurrentDay = indexOfSelectedLabel - 7;
        [self resetData:theNewDate];
//
//        if(self.delegate && [self.delegate respondsToSelector:@selector(calendarDayTimelineView:didMoveToDate:)])
//            [self.delegate calendarDayTimelineView:self didMoveToDate:self.currentDay];
//    }];
    
    
    
    
    
}
- (void) _setupDaysView{
    
    NSArray *labels =  [self _allDayLabels];
    NSDateComponents *comp = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra | NSCalendarUnitWeekday fromDate:self.currentDay];
    NSDateComponents *mutedCom = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra fromDate:self.currentDay];
    for(NSInteger cnt= comp.weekday + 6;cnt>=0;cnt--){
        NSDate *aDate = [self.calendar dateFromComponents:mutedCom];
        mutedCom = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra fromDate:aDate];
        TKDateLabel *label = labels[cnt];
        label.text = [NSString stringWithFormat:@"%@",@(mutedCom.day)];
        label.date = aDate;
        label.today = [aDate isTodayWithTimeZone:self.calendar.timeZone];
        label.selected = [aDate isSameDay:self.currentDay timeZone:self.calendar.timeZone];
        mutedCom.day --;
    }
    
    mutedCom = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra fromDate:self.currentDay];
    
    for(NSInteger cnt= comp.weekday + 6;cnt<labels.count;cnt++){
        
        NSDate *aDate = [self.calendar dateFromComponents:mutedCom];
        mutedCom = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra fromDate:aDate];
        TKDateLabel *label = labels[cnt];
        label.text = [NSString stringWithFormat:@"%@",@(mutedCom.day)];
        label.date = aDate;
        label.today = [aDate isTodayWithTimeZone:self.calendar.timeZone];
        label.selected = [aDate isSameDay:self.currentDay timeZone:self.calendar.timeZone];
        mutedCom.day ++;
        
    }
    
    self.indexOfCurrentDay = comp.weekday-1;
}
- (NSArray*) _allDayLabels{
    NSMutableArray *labels = [NSMutableArray array];
    for(TKWeekdaysView *page in self.weekdayPages){
        [labels addObjectsFromArray:page.weekdayLabels];
    }
    return labels.copy;
}


- (void) tintColorDidChange{
    [super tintColorDidChange];
//    self.nowLineView.tintColor = self.tintColor;
    
    for(TKDateLabel *label in [self _allDayLabels])
        label.tintColor = self.tintColor;
    
}

- (void)resetData:(NSDate *)currentDay{
    
    if (![self.currentDay isEqual:currentDay]) {
        self.currentDay = currentDay;
        [self _updateDateLabel];
        [self _setupDaysView];
    }
}

- (void) _updateDateLabel{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月d日 EE";
    formatter.timeZone = self.calendar.timeZone;
    self.monthYearLabel.text = [formatter stringFromDate:self.currentDay];
}

- (UILabel *) monthYearLabel{
    if(_monthYearLabel) return _monthYearLabel;
    
    _monthYearLabel = [[UILabel alloc] initWithFrame:CGRectInset(CGRectMake(0, self.height - 24 - 6, self.width, 24), 40, 0)];
    _monthYearLabel.backgroundColor = [UIColor greenColor];
    _monthYearLabel.textAlignment = NSTextAlignmentCenter;
    _monthYearLabel.backgroundColor = [UIColor clearColor];
    _monthYearLabel.font = [UIFont systemFontOfSize:16.0f];
    _monthYearLabel.textColor = [UIColor blackColor];
    _monthYearLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    return _monthYearLabel;
}

- (UIScrollView*) daysScrollView{
    if(_daysScrollView) return _daysScrollView;
    _daysScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetMinY(self.monthYearLabel.frame))];
//    _daysScrollView.backgroundColor = [UIColor redColor];
    _daysScrollView.pagingEnabled = YES;
    _daysScrollView.delegate = self;
    _daysScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.daysScrollView.frame)*3.0, 0);
    _daysScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.daysScrollView.frame), 0);
    _daysScrollView.showsHorizontalScrollIndicator = NO;
    return _daysScrollView;
}

#pragma mark UIScrollViewDelegate
- (NSInteger) _currentScrolledWeek{
    CGFloat w = CGRectGetWidth(self.daysScrollView.frame);
    CGFloat x = self.daysScrollView.contentOffset.x + (w/2.0f);
    return x / w;
}
- (void) _checkForAdvancingWeek{
    NSInteger page = [self _currentScrolledWeek];
    if(page!=1) [self _advanceWeekToIndex:page animated:YES];
}
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate) return;
    [self _checkForAdvancingWeek];
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self _checkForAdvancingWeek];
}
- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self _checkForAdvancingWeek];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
