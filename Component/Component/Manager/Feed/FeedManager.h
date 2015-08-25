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
- (void)feedList:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd queryCode:(NSString *)queryCode block:(ActionCompleteBlock)block;

//发送feed
- (void)sendFeed:(Feed *)feed tagIds:(NSString *)tagIds block:(ActionCompleteBlock)block;

//上传feed图片
- (void)uploadFeedImage:(NSString *)imgPath block:(ActionCompleteBlock)block;

//获取feed人列表
- (void)findFriendsByTags:(NSInteger)limitStart limitEnd:(NSInteger)limitEnd queryCode:(NSString *)queryCode block:(ActionCompleteBlock)block;

@end
