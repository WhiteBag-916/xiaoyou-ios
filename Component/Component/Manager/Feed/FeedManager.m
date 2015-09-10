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
#import "UploadFeedImageAction.h"
#import "FindFriendsByTagsAction.h"
#import "AlertListAction.h"
#import "GroupConditionsAction.h"
#import "GroupListAction.h"
#import "GroupDetailInfoAction.h"
#import "GroupFeedsAction.h"
#import "CommonAction.h"
#import "YUtils+Component.h"
#import "Feed.h"
#import "ListPraisePeoplesAction.h"
#import "ListCommentAction.h"
#import "ReadByFeedAction.h"
#import "ReadFeedCount.h"
#import "ProvisionManager.h"

#define KFeedManagerSyncQueue @"kFeedManagerSyncQueue"

@implementation FeedManager

DEF_SINGLETON(FeedManager);

- (instancetype)init
{
    if (self = [super init]) {
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

- (void)appDidLogout:(NSDictionary *)logoutInfo
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

//获取动态详情，FeedInfo
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
    CommonAction *action = [[CommonAction alloc] init];
    NSDictionary *dic = @{@"sendGroupId": SStr(feed.sendGroupId), @"type":SStr(feed.type), @"content":SStr(feed.content), @"img":SStr(feed.img)};
    action.parameter = [YUtils getParameter:@{@"feed":dic, @"tagIds" : tagIds} needUserToken:YES];
    action.url = [YUtils getUrl:api_feed_AddFeed];
    
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
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"feedId" : feedId} needUserToken:YES];
    action.url = [YUtils getUrl:api_feed_addPraise];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//Feed评论敬酒
- (void)commentAddPraise:(NSString *)commentId block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"commentId" : commentId} needUserToken:YES];
    action.url = [YUtils getUrl:api_feed_commonAddPraise];
    
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
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"feedId":feedId, @"content":content} needUserToken:YES];
    action.url = [YUtils getUrl:api_feed_addComment];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//对动态评论
- (void)addReply:(NSString *)feedId content:(NSString *)content toUserId:(NSString *)toUserId block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"toUserId" : toUserId, @"feedId":feedId, @"content":content} needUserToken:YES];
    action.url = [YUtils getUrl:api_feed_addReply];
    
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
        if (message.isSuccess) {
            NSInteger readCount = [message.object delCount];
            
            [[ProvisionManager sharedInstance] delUnreadAlterCount:readCount];
        }
        
        //主线程处理界面
        block(message);
    }];
}

//删除这个用户所有的提醒
- (void)readAll:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:nil needUserToken:YES needAddUserID:YES];
    action.url = [YUtils getUrl:api_alert_readAll];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        
        if (message.isSuccess) {
            [[ProvisionManager sharedInstance] resetUnreadAlterCount:0];
        }
        
        //主线程处理界面
        block(message);
    }];
}

//社团搜索条件
- (void)groupConditions:(ActionCompleteBlock)block {
    GroupConditionsAction *action = [[GroupConditionsAction alloc] init];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//社团列表
- (void)groupList:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd name:(NSString *)name queryCode:(NSString *)queryCode block:(ActionCompleteBlock)block {
    GroupListAction *action = [[GroupListAction alloc] init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    action.name = name;
    action.queryCode = queryCode;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//社团详情
- (void)groupDetailInfo:(NSInteger)size groupId:(NSString *)groupId block:(ActionCompleteBlock)block {
    GroupDetailInfoAction *action = [[GroupDetailInfoAction alloc] init];
    action.size = size;
    action.groupId = groupId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//社团feed列表
- (void)groupFeeds:(NSString *)lastId size:(NSInteger)size groupId:(NSString *)groupId block:(ActionCompleteBlock)block {
    GroupFeedsAction *action = [[GroupFeedsAction alloc] init];
    action.size = size;
    action.groupId = groupId;
    action.lastId = lastId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//feed点赞人列表
- (void)listPraisePeoples:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd feedId:(NSString *)feedId block:(ActionCompleteBlock)block {
    ListPraisePeoplesAction *action = [[ListPraisePeoplesAction alloc] init];
    action.limitStart = limitStart;
    action.limitEnd = limitEnd;
    action.feedId = feedId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//Feed评论删除
- (void)deleteComment:(NSString *)commentId block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"commentId":commentId} needUserToken:YES];
    action.url = [YUtils getUrl:api_feed_deleteComment];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//feed删除
- (void)deleteFeed:(NSString *)feedId block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"feedId":feedId} needUserToken:YES];
    action.url = [YUtils getUrl:api_feed_deleteFeed];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//获取评论列表
- (void)listComment:(NSString *)lastId size:(NSInteger)size feedId:(NSString *)feedId block:(ActionCompleteBlock)block{
    ListCommentAction *action = [[ListCommentAction alloc] init];
    action.lastId = lastId;
    action.size = size;
    action.feedId = feedId;
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

//社团点赞
- (void)addGroupPraise:(NSString *)groupId block:(ActionCompleteBlock)block {
    CommonAction *action = [[CommonAction alloc] init];
    action.parameter = [YUtils getParameter:@{@"groupId":groupId} needUserToken:YES];
    action.url = [YUtils getUrl:api_group_addPraise];
    
    [YAction startAction:action completionBlock:^(YActionMessage* message) {
        //主线程处理界面
        block(message);
    }];
}

@end
