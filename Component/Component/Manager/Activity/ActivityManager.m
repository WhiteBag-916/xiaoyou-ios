//
//  ActivityManager.m
//  Component
//
//  Created by 熊宸 on 15/10/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityManager.h"
#import "AvailableAction.h"

#define KActivityManagerSyncQueue @"kActivityManagerSyncQueue"

@implementation ActivityManager

DEF_SINGLETON(ActivityManager);

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)initSource
{
    [YQueue registerSyncQueueWithType:KActivityManagerSyncQueue];
}
- (void)clearSource
{
    [YQueue unregisterSyncQueueWithType:KActivityManagerSyncQueue];
}

- (void)appDidLogin:(NSDictionary *)loginInfo
{
    
}

- (void)appDidLogout:(NSDictionary *)logoutInfo
{
    
}


////发送feed
//- (void)sendFeed:(Feed *)feed tagIds:(NSString *)tagIds block:(ActionCompleteBlock)block {
//    CommonAction *action = [[CommonAction alloc] init];
//    NSDictionary *dic = @{@"sendGroupId": SStr(feed.sendGroupId), @"type":SStr(feed.type), @"content":SStr(feed.content), @"img":SStr(feed.img)};
//    action.parameter = [YUtils getParameter:@{@"feed":dic, @"tagIds" : tagIds} needUserToken:YES];
//    action.url = [YUtils getUrl:api_feed_AddFeed];
//    
//    [YAction startAction:action completionBlock:^(YActionMessage* message) {
//        
//        //主线程处理界面
//        block(message);
//    }];
//}

- (void)getCurrentUseAvailableListLimitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block
{
    AvailableAction *action = [[AvailableAction alloc]init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    
    [YAction startAction:action completionBlock:^(YActionMessage *message) {
        block(message);
    }];
}

@end
