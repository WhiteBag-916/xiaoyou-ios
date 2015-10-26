//
//  ActivityManager.h
//  Component
//
//  Created by 熊宸 on 15/10/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

@class ActivityInfoModel;

@interface ActivityManager : YManager<YManager>
AS_SINGLETON(ActivityManager);

//获取当前用户活动列表
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;

//查询活动类型列表
- (void)findActivityTypes:(ActionCompleteBlock)block;

//根据发布后的活动id查询发布后的活动信息
- (void)findByActivityPublishedId:(NSString *)activityId block:(ActionCompleteBlock)block;

//活动报名
- (void)enrollActivity:(NSString *)activityPublishedId block:(ActionCompleteBlock)block;

//报名审核
- (void)checkEnrollActivity:(NSString *)checkStatus activityId:(NSString *)activityId block:(ActionCompleteBlock)block;

//编辑/发布活动
- (void)editActivity:(ActivityInfoModel *)model block:(ActionCompleteBlock)block;

@end
