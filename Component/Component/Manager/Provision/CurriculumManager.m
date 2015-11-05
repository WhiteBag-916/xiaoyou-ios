//
//  CurriculumManager.m
//  Component
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CurriculumManager.h"
#import "CourseTimeListAction.h"
#import "FindMyCourseAction.h"
#import "CourseTimeListModel.h"
#import "FindMyCourseModel.h"
#import "CourseTeacherlist.h"
#import "FindMyCourseViewModel.h"
#import "CourseTime.h"
#import "CourseDetailAction.h"

#define KCurriculumManagerSyncQueue @"kCurriculumManagerSyncQueue"

@interface CurriculumManager ()

@property (nonatomic, strong) CourseTimeListModel *courseTimeListModel;
@property (nonatomic, strong) NSMutableArray *findMyCourseArray;

@end

@implementation CurriculumManager

DEF_SINGLETON(CurriculumManager);

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)initSource
{
    [YQueue registerSyncQueueWithType:KCurriculumManagerSyncQueue];
}
- (void)clearSource
{
    [YQueue unregisterSyncQueueWithType:KCurriculumManagerSyncQueue];
}

- (void)appDidLogin:(NSDictionary *)loginInfo
{
    [self courseTimeList:^(YActionMessage *message) {
        
    }];
}

- (void)appDidLogout:(NSDictionary *)logoutInfo
{
    
}

//取课程时间
- (CourseTimeListModel *)getCourseTime {
    return self.courseTimeListModel;
}

//根据课时取课程时间
- (NSString *)getCourseTimeByClass:(NSInteger)beginTime endTime:(NSInteger)endTime {
    CourseTime *beginCourseTime = _courseTimeListModel.courseTime[beginTime-1];
    CourseTime *endCourseTime = _courseTimeListModel.courseTime[endTime-1];
    
    return [NSString stringWithFormat:@"%@-%@", beginCourseTime.startTime, endCourseTime.endTime];
}

//根据周取课程数据
- (NSArray *)getDataByWeek:(NSInteger)weekNum {
    NSMutableArray *allData = [[NSMutableArray alloc] init];
    
    [_findMyCourseArray enumerateObjectsUsingBlock:^(FindMyCourseViewModel *courseTeacherlistModel, NSUInteger findMyCourseIdx, BOOL * _Nonnull findMyCourseStop) {
        if (weekNum >= courseTeacherlistModel.beginWeek && weekNum <= courseTeacherlistModel.endWeek) {
            //判断单双周
            if (courseTeacherlistModel.evenodd) {
                //每周
                [allData addObject:courseTeacherlistModel];
            } else {
                //单周
                NSInteger beginWeek = courseTeacherlistModel.beginWeek;
                //取余
                NSInteger week = (weekNum-beginWeek)%2;
                if (0 == week) {
                    [allData addObject:courseTeacherlistModel];
                }
            }
        }
    }];
    
    return allData;
}

//根据model读取课的上课星期
- (NSString *)weekByCourseTimeID:(FindMyCourseViewModel *)model {
    NSString *weekStr = [NSString stringWithFormat:@"%g-%g周", model.beginWeek, model.endWeek];
    
    //判断单双周
    if (!model.evenodd){
        //单周
        NSInteger beginWeek = model.beginWeek;
        //取余
        NSInteger week = beginWeek%2;
        if (0 == week) {
            weekStr = [weekStr stringByAppendingString:@"，双周"];
        } else {
            weekStr = [weekStr stringByAppendingString:@"，单周"];
        }
    }
    
    return weekStr;
}

//整理课程数据
- (void)resetCourseArray:(NSArray *)courseArray {
    self.findMyCourseArray = [[NSMutableArray alloc] init];
    
    [courseArray enumerateObjectsUsingBlock:^(FindMyCourseModel *findMyCourseModel, NSUInteger findMyCourseIdx, BOOL * _Nonnull findMyCourseStop) {
        [findMyCourseModel.courseTeacherlist enumerateObjectsUsingBlock:^(CourseTeacherlist*  _Nonnull courseTeacherlistModel, NSUInteger courseTeacherlistIdx, BOOL * _Nonnull courseTeacherlistStop) {
            
            FindMyCourseViewModel *model = [[FindMyCourseViewModel alloc] initByCourseModel:findMyCourseModel index:courseTeacherlistIdx];
            
            [self.findMyCourseArray addObject:model];
        }];
    }];
}

//获取课程学时对应时间
- (void)courseTimeList:(ActionCompleteBlock)block {
    CourseTimeListAction* action = [[CourseTimeListAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        if (0 == self.findMyCourseArray.count) {
            if (message.isSuccess) {
                self.courseTimeListModel = message.object;
                
                [self findMyCourse:^(YActionMessage *message2) {
                    //主线程处理界面
                    block(message2);
                }];
            } else {
                //主线程处理界面
                block(message);
            }
        } else {
            //主线程处理界面
            block(message);
        }
        
        
    }];
}

//获取我的课程
- (void)findMyCourse:(ActionCompleteBlock)block {
    FindMyCourseAction* action = [[FindMyCourseAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //子线程处理数据
        [YQueue dispatchInSyncQueueWithQueueType:KCurriculumManagerSyncQueue block:^{
            if (message.isSuccess) {
                [self resetCourseArray:message.object];
            }
            
            //主线程处理界面
            [YQueue dispatchInMainQueueWithBlock:^{
                block(message);
            }];
        }];
    }];
}

//获取课程详情
- (void)courseDetail:(NSString *)uid blok:(ActionCompleteBlock)block {
    CourseDetailAction *action = [[CourseDetailAction alloc] init];
    action.uid = uid;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

@end
