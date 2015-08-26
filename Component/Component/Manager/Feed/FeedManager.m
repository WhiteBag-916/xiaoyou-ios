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
#import "NewFeedAction.h"
#import "UploadFeedImageAction.h"
#import "FindFriendsByTagsAction.h"

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
- (void)getMyFeed:(NSString *)uid limitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block {
    MyFeedAction *action = [[MyFeedAction alloc] init];
    action.userID = uid;
    action.limitEnd = limitEnd;
    action.limitStart = limitStart;
    
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
- (void)feedList:(NSString *)lastId size:(NSInteger)size queryCode:(NSString *)queryCode block:(ActionCompleteBlock)block {
    FeedListAction *action = [[FeedListAction alloc] init];
    action.lastId = lastId;
    action.size = size;
    action.queryCode = queryCode;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//发送feed
- (void)sendFeed:(Feed *)feed tagIds:(NSString *)tagIds block:(ActionCompleteBlock)block {
    NewFeedAction *action = [[NewFeedAction alloc] init];
    action.feed = feed;
    action.tagIds = tagIds;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//上传feed图片,传图片存储的绝对路径,UploadImage
- (void)uploadFeedImage:(NSString *)imgPath block:(ActionCompleteBlock)block {
    UploadFeedImageAction *action = [[UploadFeedImageAction alloc] init];
    action.imagePath = imgPath;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取feed人列表,Author
- (void)findFriendsByTags:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd queryCode:(NSString *)queryCode block:(ActionCompleteBlock)block {
    FindFriendsByTagsAction *action = [[FindFriendsByTagsAction alloc] init];
    action.limitEnd = limitEnd;
    action.limitStart = limitStart;
    action.queryCode = queryCode;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

@end
