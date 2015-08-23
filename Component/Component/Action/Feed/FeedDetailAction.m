//
//  FeedDetailAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedDetailAction.h"
#import "FeedDetail.h"
#import "YUtils+Component.h"

@implementation FeedDetailAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"feedId":_feedId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_DetailFeed];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FeedDetail actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
