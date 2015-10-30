//
//  MyTimetableView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YView.h"

@class CourseTimeListModel;

@interface MyTimetableView : YView

//刷新课程时间
- (void)refreshCourseTimeList:(CourseTimeListModel *)courseTimeListModel;

@end
