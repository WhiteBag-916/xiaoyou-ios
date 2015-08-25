//
//  FeedListAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedListAction.h"
#import "FeedInfo.h"
#import "YUtils+Component.h"

@implementation FeedListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"limitStart":@(_limitStart), @"limitEnd":@(_limitEnd), @"queryCode":_queryCode} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_ListFeed];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FeedInfo actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
