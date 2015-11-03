//
//  CurriculumManager.h
//  Component
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

@class CourseTimeListModel;

@interface CurriculumManager : YManager<YManager>
AS_SINGLETON(CurriculumManager);

//取课程时间
- (CourseTimeListModel *)getCourseTime;

//根据课时取课程时间
- (NSString *)getCourseTimeByClass:(NSInteger)beginTime endTime:(NSInteger)endTime;

//根据周取课程数据
- (NSArray *)getDataByWeek:(NSInteger)weekNum;

/*********************************************************************
 函数名称 : courseTimeList
 函数描述 : 获取课程学时对应时间
 参数 : N/A
 返回值 : CourseTimeListModel
 作者 : XiongChen
 *********************************************************************/
- (void)courseTimeList:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : findMyCourse
 函数描述 : 获取我的课程
 参数 : N/A
 返回值 : FindMyCourseModel
 作者 : XiongChen
 *********************************************************************/
- (void)findMyCourse:(ActionCompleteBlock)block;

@end
