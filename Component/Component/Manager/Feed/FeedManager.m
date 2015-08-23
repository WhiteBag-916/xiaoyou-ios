//
//  FeedManager.m
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedManager.h"
#import "YFoundation.h"
#import "YQueue.h"
#import "MyFeedAction.h"
#import "FeedDetailAction.h"
#import "FeedListAction.h"

#define KFeedManagerSyncQueue @"kFeedManagerSyncQueue"

@implementation FeedManager

DEF_SINGLETON(FeedManager);

- (instancetype)init
{
    if (self == [super init]) {
    }
    return self;
}

- (void)initSource
{
    [YQueue registerSyncQueueWithType:KFeedManagerSyncQueue];
}
- (void)clearSource
{
    [YQueue unregisterSyncQueueWithType:KFeedManagerSyncQueue];
}

- (void)appDidLogin:(NSDictionary *)loginInfo
{
    
}

- (void)appDidLogout
{
    
}

//获取我的动态,FeedInfo
- (void)getMyFeed:(ActionCompleteBlock)block {
    MyFeedAction *action = [[MyFeedAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取动态详情，FeedDetail
- (void)getFeedDetailByID:(NSString *)feedID block:(ActionCompleteBlock)block {
    FeedDetailAction *action = [[FeedDetailAction alloc] init];
    action.feedId = feedID;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取feed列表,FeedInfo
- (void)feedList:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block {
    FeedListAction *action = [[FeedListAction alloc] init];
    action.limitEnd = limitEnd;
    action.limitStart = limitStart;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

@end
