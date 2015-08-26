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
#import "AddPraiseAction.h"
#import "CommentAddPraiseAction.h"
#import "AlertListAction.h"
#import "AddReplyAction.h"
#import "AddCommentAction.h"
#import "ReadAllAction.h"
#import "ReadByFeedAction.h"

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

//Feed敬酒
- (void)addPraise:(NSString *)feedId block:(ActionCompleteBlock)block {
    AddPraiseAction *action = [[AddPraiseAction alloc] init];
    action.feedId = feedId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//Feed评论敬酒
- (void)commentAddPraise:(NSString *)commentId block:(ActionCompleteBlock)block {
    CommentAddPraiseAction *action = [[CommentAddPraiseAction alloc] init];
    action.commentId = commentId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取feed提醒列表
- (void)alertList:(NSString *)lastId size:(NSInteger)size block:(ActionCompleteBlock)block {
    AlertListAction *action = [[AlertListAction alloc] init];
    action.lastId = lastId;
    action.size = size;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//动态评论
- (void)addComment:(NSString *)feedId content:(NSString *)content block:(ActionCompleteBlock)block {
    AddCommentAction *action = [[AddCommentAction alloc] init];
    action.feedId = feedId;
    action.content = content;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//对动态评论
- (void)addReply:(NSString *)feedId content:(NSString *)content toUserId:(NSString *)toUserId block:(ActionCompleteBlock)block {
    AddReplyAction *action = [[AddReplyAction alloc] init];
    action.feedId = feedId;
    action.content = content;
    action.toUserId = toUserId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//删除关于一个feed的提醒
- (void)readByFeed:(NSString *)affectId block:(ActionCompleteBlock)block {
    ReadByFeedAction *action = [[ReadByFeedAction alloc] init];
    action.affectId = affectId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//删除这个用户所有的提醒
- (void)readAll:(ActionCompleteBlock)block {
    ReadAllAction *action = [[ReadAllAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

@end
