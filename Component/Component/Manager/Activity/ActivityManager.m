//
//  ActivityManager.m
//  Component
//
//  Created by 熊宸 on 15/10/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityManager.h"
#import "AvailableAction.h"
#import "FindActivityTypesAction.h"
#import "FindByActivityPublishedIdAction.h"
#import "CommonAction.h"
#import "YUtils+Component.h"

#define KActivityManagerSyncQueue @"kActivityManagerSyncQueue"

@implementation ActivityManager

DEF_SINGLETON(ActivityManager);

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)initSource
{
    [YQueue registerSyncQueueWithType:KActivityManagerSyncQueue];
}
- (void)clearSource
{
    [YQueue unregisterSyncQueueWithType:KActivityManagerSyncQueue];
}

- (void)appDidLogin:(NSDictionary *)loginInfo
{
    
}

- (void)appDidLogout:(NSDictionary *)logoutInfo
{
    
}

//获取当前用户活动列表
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block
{
    AvailableAction *action = [[AvailableAction alloc]init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

//查询活动类型列表接口
- (void)findActivityTypes:(ActionCompleteBlock)block {
    FindActivityTypesAction *action = [[FindActivityTypesAction alloc]init];
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

//根据发布后的活动id查询发布后的活动信息
- (void)findByActivityPublishedId:(NSString *)activityId block:(ActionCompleteBlock)block {
    FindByActivityPublishedIdAction *action = [[FindByActivityPublishedIdAction alloc]init];
    action.activityId = activityId;
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

//活动报名
- (void)enrollActivity:(NSString *)activityPublishedId block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"activityPublishedId":activityPublishedId} needUserToken:YES];
    action.url = [YUtils getUrl:api_available_enrollActivity];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

@end
