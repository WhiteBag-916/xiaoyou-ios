//
//  FeedManager.h
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YManager.h"
#import "YAction.h"

@class Feed;

@interface FeedManager : YManager<YManager>
AS_SINGLETON(FeedManager);

//获取我的动态
- (void)getMyFeed:(NSString *)uid limitStart:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd block:(ActionCompleteBlock)block;

//获取动态详情
- (void)getFeedDetailByID:(NSString *)feedID block:(ActionCompleteBlock)block;

//获取feed列表
- (void)feedList:(NSString *)lastId size:(NSInteger)size queryCode:(NSString *)queryCode block:(ActionCompleteBlock)block;

//发送feed
- (void)sendFeed:(Feed *)feed tagIds:(NSString *)tagIds block:(ActionCompleteBlock)block;

//上传feed图片
- (void)uploadFeedImage:(NSString *)imgPath block:(ActionCompleteBlock)block;

//获取feed人列表
- (void)findFriendsByTags:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd queryCode:(NSString *)queryCode block:(ActionCompleteBlock)block;

//Feed敬酒
- (void)addPraise:(NSString *)feedId block:(ActionCompleteBlock)block;

//Feed评论敬酒
- (void)commentAddPraise:(NSString *)commentId block:(ActionCompleteBlock)block;

//获取feed提醒列表
- (void)alertList:(NSString *)lastId size:(NSInteger)size block:(ActionCompleteBlock)block;

//动态评论
- (void)addComment:(NSString *)feedId content:(NSString *)content block:(ActionCompleteBlock)block;

//对动态评论
- (void)addReply:(NSString *)feedId content:(NSString *)content toUserId:(NSString *)toUserId block:(ActionCompleteBlock)block;

//删除关于一个feed的提醒
- (void)readByFeed:(NSString *)affectId block:(ActionCompleteBlock)block;

//删除这个用户所有的提醒
- (void)readAll:(ActionCompleteBlock)block;

//社团搜索条件
- (void)groupConditions:(ActionCompleteBlock)block;

//社团列表
- (void)groupList:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd name:(NSString *)name queryCode:(NSString *)queryCode block:(ActionCompleteBlock)block;

@end
