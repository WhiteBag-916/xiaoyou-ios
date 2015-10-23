//
//  ActivityManager.h
//  Component
//
//  Created by 熊宸 on 15/10/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

@interface ActivityManager : YManager<YManager>
AS_SINGLETON(ActivityManager);

//获取当前用户活动列表
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;

//查询活动类型列表
- (void)findActivityTypes:(ActionCompleteBlock)block;

//根据发布后的活动id查询发布后的活动信息
- (void)findByActivityPublishedId:(NSString *)activityId block:(ActionCompleteBlock)block;

@end
