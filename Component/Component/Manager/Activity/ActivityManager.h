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

//根据时间取日程提醒text
- (NSString *)remindTextByTime:(NSInteger)time;

//根据text取日程提醒时间
- (NSInteger)timeByRemindText:(NSString *)remindText;

//提醒列表
- (NSArray *)remindArray;

//提醒文字列表
- (NSArray *)remindTextArray;

/*********************************************************************
 函数名称 : getCurrentUseAvailableListLimitStart
 函数描述 : 获取当前用户活动列表
 参数 : limitStart：开始
        limitEnd：结束
 返回值 : return：ActivityInfoModel
 作者 : XiongChen
 *********************************************************************/
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : getCurrentUseAvailableListLimitStart
 函数描述 : 获取搜索活动列表
 参数 : limitStart：开始
        limitEnd：结束
        searchText：搜索文字
 返回值 : return：ActivityInfoModel
 作者 : XiongChen
 *********************************************************************/
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd search:(NSString *)searchText block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : getCurrentUseAvailableListLimitStart
 函数描述 : 筛选活动列表
 参数 : limitStart：开始
        limitEnd：结束
        dic：字典类型，根据GetFilterConditionsModel拼凑
 返回值 : return：ActivityInfoModel
 作者 : XiongChen
 *********************************************************************/
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd dic:(NSDictionary *)condition block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : findActivityTypes
 函数描述 : 查询活动类型列表
 参数 : N/A
 返回值 : Tags
 作者 : XiongChen
 *********************************************************************/
- (void)findActivityTypes:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : findByActivityPublishedId
 函数描述 : 根据发布后的活动id查询发布后的活动信息
 参数 : activityId:活动id
 返回值 : ActivityInfoModel
 作者 : XiongChen
 *********************************************************************/
- (void)findByActivityPublishedId:(NSString *)activityId block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : checkEnrollActivity
 函数描述 : 活动报名
 参数 : checkStatus:发布后的活动id
 返回值 : N/A
 作者 : XiongChen
 *********************************************************************/
- (void)enrollActivity:(NSString *)activityPublishedId block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : checkEnrollActivity
 函数描述 : 报名审核
 参数 : checkStatus:活动审核状态(见wiki附录1)
        activityId：活动id
 返回值 : N/A
 作者 : XiongChen
 *********************************************************************/
- (void)checkEnrollActivity:(NSString *)checkStatus activityId:(NSString *)activityId block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : editActivity
 函数描述 : 编辑/发布活动
 参数 : 构造活动详情的model
 返回值 : N/A
 作者 : XiongChen
 *********************************************************************/
- (void)editActivity:(NSDictionary *)dic block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : commonImgUpload
 函数描述 : 上传图片
 参数 : uploadType:目前取值范围为（apps、school、group、user、feed、qr、activity）
        needSnap:是否要缩略图（true/false）
        imagePath:图片沙盒路径，用","隔开
 返回值 : ImageUploadModel
 作者 : XiongChen
 *********************************************************************/
- (void)commonImgUpload:(NSString *)uploadType needSnap:(NSString *)needSnap imagePath:(NSString *)imagePath block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : getFilterConditions
 函数描述 : 获取有空筛选条件
 参数 : N/A
 返回值 : GetFilterConditionsModel
 作者 : XiongChen
 *********************************************************************/
- (void)getFilterConditions:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : findActivityDetailInfo
 函数描述 : 查询活动详情接口
 参数 : activityPublishedId:活动id getDetail:是否获取详情
 返回值 : ActivityDetailModel
 作者 : XiongChen
 *********************************************************************/
- (void)findActivityDetailInfo:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd activityPublishedId:(NSString *)activityPublishedId getDetail:(BOOL)getDetail block:(ActionCompleteBlock)block;

/**
 *  取消活动报名
 */
- (void)cancleActivitySignUpByActivityID:(NSString*)activityID block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : freeBuildingList
 函数描述 : 获取自习室大楼以及对应的自习教室数量
 参数 : N/A
 返回值 : FreeBuildingListModel
 作者 : XiongChen
 *********************************************************************/
- (void)freeBuildingList:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : freeBuildingDetail
 函数描述 : 获取自习室大楼的自习教室详情
 参数 : buildName：教学楼名称
 返回值 : FreeBuildingListModel
 作者 : XiongChen
 *********************************************************************/
- (void)freeBuildingDetail:(NSString *)buildName block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : userSchedulingConditions
 函数描述 : 日程提醒条件列表查询
 参数 : N/A
 返回值 : UserSchedulingListConditionsModel
 作者 : XiongChen
 *********************************************************************/
- (void)userSchedulingConditions:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : userSchedulingEdit
 函数描述 : 新增或修改日程
 参数 : dic：请求参数见 http://wiki.xiaoyou.com/wiki/index.php/%E6%97%A5%E7%A8%8B%E6%8E%A5%E5%8F%A3
 返回值 : N/A
 作者 : XiongChen
 *********************************************************************/
- (void)userSchedulingEdit:(NSDictionary *)dic block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : userSchedulingList
 函数描述 : 查询日程列表
 参数 : startDate：起始时间  endDate:结束时间
 返回值 : UserSchedulingInfo
 作者 : XiongChen
 *********************************************************************/
- (void)userSchedulingList:(NSInteger)startDate endDate:(NSInteger)endDate block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : userSchedulingDelete
 函数描述 : 删除日程接口
 参数 : uid:ID
 返回值 : N/A
 作者 : XiongChen
 *********************************************************************/
- (void)userSchedulingDelete:(NSString *)uid block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 : userSchedulingDetail
 函数描述 : 根据日程id查询
 参数 : uid:ID
 返回值 : N/A
 作者 : XiongChen
 *********************************************************************/
- (void)userSchedulingDetail:(NSString *)uid block:(ActionCompleteBlock)block;

/*********************************************************************
 函数名称 :getCurrentUseMainAvailableListLimitStart
 函数描述 :有空列表
 参数 : uid:ID
 返回值 : N/A
 作者 : XiongChen
 *********************************************************************/
- (void)getCurrentUseMainAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;

@end
