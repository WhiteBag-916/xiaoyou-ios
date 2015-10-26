//
//  RemindManager.h
//  Component
//
//  Created by sheng on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"
@interface RemindManager : YManager<YManager>
AS_SINGLETON(RemindManager);

//获取提醒
- (void)getMyFeed:(NSString *)uid limitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;
@end
