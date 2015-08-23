//
//  MyFeedAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MyFeedAction.h"
#import "YDefine.h"
#import "FeedInfo.h"
#import "YUtils+Component.h"

@implementation MyFeedAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_myFeed];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FeedInfo actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
