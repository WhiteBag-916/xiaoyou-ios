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

//获取我的动态
- (void)getMyFeed:(NSString *)uid limitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;

//获取当前用户活动列表
//- (void)getCurrentUseActivityListWithS



@end
