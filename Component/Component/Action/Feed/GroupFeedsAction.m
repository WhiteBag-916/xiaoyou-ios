//
//  GroupFeedsAction.m
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupFeedsAction.h"
#import "FeedInfo.h"
#import "YUtils+Component.h"

@implementation GroupFeedsAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"lastId":SStr(_lastId), @"size":@(_size), @"groupId":_groupId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_feed_ListFeed];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FeedInfo actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
