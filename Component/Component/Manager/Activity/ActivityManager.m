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
#import "ActivityInfoModel.h"
#import "CommonImgUpload.h"
#import "GetFilterConditionsAction.h"
#import "FindActivityDetailInfoAction.h"
#import "CancleActivityAction.h"
#import "FreeBuildingListAction.h"
#import "FreeBuildingDetailAction.h"
#import "UserSchedulingConditionsAction.h"
#import "UserSchedulingListAction.h"
#import "UserSchedulingDetailAction.h"
#import "MainAvailableTimeAction.h"

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

//获取搜索活动列表
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd search:(NSString *)searchText block:(ActionCompleteBlock)block {
    AvailableAction *action = [[AvailableAction alloc]init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    action.searchText = searchText;
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

//筛选活动列表
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd dic:(NSDictionary *)condition block:(ActionCompleteBlock)block {
    AvailableAction *action = [[AvailableAction alloc]init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    action.condition = [NSDictionary dictionaryWithDictionary:condition];
    
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
    action.parameter = [YUtils getParameter:@{@"activityPublishedId":activityPublishedId} needUserToken:YES needContent:YES];
    action.url = [YUtils getUrl:api_available_enrollActivity];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

//报名审核
- (void)checkEnrollActivity:(NSString *)checkStatus activityId:(NSString *)activityId block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"checkStatus":checkStatus, @"activityId":activityId} needUserToken:YES needContent:YES];
    action.url = [YUtils getUrl:api_available_enrollActivity];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

//编辑/发布活动
- (void)editActivity:(NSDictionary *)dic block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:dic needUserToken:YES needContent:YES];
    action.url = [YUtils getUrl:api_available_edit];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

//上传图片
- (void)commonImgUpload:(NSString *)uploadType needSnap:(NSString *)needSnap imagePath:(NSString *)imagePath block:(ActionCompleteBlock)block {
    CommonImgUpload *action = [[CommonImgUpload alloc] init];
    action.uploadType = uploadType;
    action.needSnap = needSnap;
    action.imagePath = imagePath;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

//获取有空筛选条件
- (void)getFilterConditions:(ActionCompleteBlock)block {
    GetFilterConditionsAction *action = [[GetFilterConditionsAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

//查询活动详情接口
- (void)findActivityDetailInfo:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd activityPublishedId:(NSString *)activityPublishedId getDetail:(BOOL)getDetail block:(ActionCompleteBlock)block {
    FindActivityDetailInfoAction *action = [[FindActivityDetailInfoAction alloc] init];
    action.activityPublishedId = activityPublishedId;
    action.getDetail = getDetail;
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

//取消活动报名
-(void)cancleActivitySignUpByActivityID:(NSString *)activityID block:(ActionCompleteBlock)block
{
    CancleActivityAction *action = [[CancleActivityAction alloc]init];
    action.activityPublishedId = activityID;
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

//获取自习室大楼以及对应的自习教室数量
- (void)freeBuildingList:(ActionCompleteBlock)block {
    FreeBuildingListAction *action = [[FreeBuildingListAction alloc]init];

    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

//获取自习室大楼的自习教室详情
- (void)freeBuildingDetail:(NSString *)buildName block:(ActionCompleteBlock)block {
    FreeBuildingDetailAction *action = [[FreeBuildingDetailAction alloc]init];
    action.buildName = buildName;
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

//日程提醒条件列表查询
- (void)userSchedulingConditions:(ActionCompleteBlock)block {
    UserSchedulingConditionsAction *action = [[UserSchedulingConditionsAction alloc]init];
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

//新增或修改日程
- (void)userSchedulingEdit:(NSDictionary *)dic block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:dic needUserToken:YES needContent:YES];
    action.url = [YUtils getUrl:api_userScheduling_edit];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

//查询日程列表
- (void)userSchedulingList:(NSInteger)startDate endDate:(NSInteger)endDate block:(ActionCompleteBlock)block {
    UserSchedulingListAction *action = [[UserSchedulingListAction alloc] init];
    action.startDate = startDate;
    action.endDate = endDate;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

//删除日程接口
- (void)userSchedulingDelete:(NSString *)uid block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"id":uid} needUserToken:YES needContent:YES];
    action.url = [YUtils getUrl:api_userScheduling_delete];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

//根据日程id查询
- (void)userSchedulingDetail:(NSString *)uid block:(ActionCompleteBlock)block {
    UserSchedulingDetailAction *action = [[UserSchedulingDetailAction alloc] init];
    action.uid = uid;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        //主线程处理界面
        block(message);
    }];
}

-(void)getCurrentUseMainAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block
{
    MainAvailableTimeAction *action = [[MainAvailableTimeAction alloc] init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        //主线程处理界面
        block(message);
    }];
}

@end
