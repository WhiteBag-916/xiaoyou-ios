//
//  AddReplyAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AddReplyAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation AddReplyAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"toUserId" : _toUserId, @"feedId":_feedId, @"content":_content} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_feed_addReply];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
