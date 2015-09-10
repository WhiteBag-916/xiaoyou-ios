//
//  FeedDetailAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedDetailAction.h"
#import "FeedInfo.h"
#import "YUtils+Component.h"

@implementation FeedDetailAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"feedId":_feedId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_feed_DetailFeed];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FeedInfo actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
