//
//  NewFeedAction.m
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "NewFeedAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"
#import "Feed.h"

@implementation NewFeedAction

- (void)execute
{
    NSDictionary *dic = @{@"sendGroupId": SStr(_feed.sendGroupId), @"type":SStr(_feed.type), @"content":SStr(_feed.content), @"img":SStr(_feed.img)};
    NSDictionary *parameter = [YUtils getParameter:@{@"feed":dic, @"tagIds" : _tagIds} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_feed_AddFeed];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
