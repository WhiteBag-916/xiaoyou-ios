//
//  FeedManager.h
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

@interface FeedManager : YManager<YManager>
AS_SINGLETON(FeedManager);

//获取我的动态
- (void)getMyFeed:(ActionCompleteBlock)block;

//获取动态详情
- (void)getFeedDetailByID:(NSString *)feedID block:(ActionCompleteBlock)block;

@end
