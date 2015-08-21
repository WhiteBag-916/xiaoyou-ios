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

@end
