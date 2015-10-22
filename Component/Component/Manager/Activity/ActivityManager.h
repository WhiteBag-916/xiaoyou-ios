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

//有空界面,获取当前用户活动列表
- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;

@end
