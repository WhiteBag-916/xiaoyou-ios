//
//  MyFeedAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MyFeedAction.h"
#import "FeedInfo.h"
#import "YUtils+Component.h"

@implementation MyFeedAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"uid":SStr(_userID), @"limitStart":@(_limitStart), @"limitEnd":@(_limitEnd)} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_feed_MyFeed];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FeedInfo actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
