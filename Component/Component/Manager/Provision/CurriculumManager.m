//
//  CurriculumManager.m
//  Component
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CurriculumManager.h"
#import "CourseTimeListAction.h"

#define KCurriculumManagerSyncQueue @"kCurriculumManagerSyncQueue"

@interface CurriculumManager ()


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
    
}

- (void)appDidLogout:(NSDictionary *)logoutInfo
{
    
}

//获取课程学时对应时间
- (void)courseTimeList:(ActionCompleteBlock)block {
    CourseTimeListAction* action = [[CourseTimeListAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

@end
