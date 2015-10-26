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

//获取当前用户活动列表，return：ActivityInfoModel
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;

//获取搜索活动列表，return：ActivityInfoModel
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd search:(NSString *)searchText block:(ActionCompleteBlock)block;

//筛选活动列表，return：ActivityInfoModel
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd dic:(NSDictionary *)condition block:(ActionCompleteBlock)block;

//查询活动类型列表，return：Tags
- (void)findActivityTypes:(ActionCompleteBlock)block;

//根据发布后的活动id查询发布后的活动信息，return：ActivityInfoModel
- (void)findByActivityPublishedId:(NSString *)activityId block:(ActionCompleteBlock)block;

//活动报名
- (void)enrollActivity:(NSString *)activityPublishedId block:(ActionCompleteBlock)block;

//报名审核
- (void)checkEnrollActivity:(NSString *)checkStatus activityId:(NSString *)activityId block:(ActionCompleteBlock)block;

//编辑/发布活动
- (void)editActivity:(ActivityInfoModel *)model block:(ActionCompleteBlock)block;

//上传图片，return：ImageUploadModel
- (void)commonImgUpload:(NSString *)uploadType needSnap:(NSString *)needSnap block:(ActionCompleteBlock)block;

//获取有空筛选条件，return：GetFilterConditionsModel
- (void)getFilterConditions:(ActionCompleteBlock)block;

@end
