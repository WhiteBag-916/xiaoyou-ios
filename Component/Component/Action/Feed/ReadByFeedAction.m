//
//  ReadByFeedAction.m
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ReadByFeedAction.h"
#import "ReadFeedCount.h"
#import "YUtils+Component.h"

@implementation ReadByFeedAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"affectId":_affectId} needUserToken:YES needAddUserID:YES];
    NSString *url = [YUtils getUrl:api_alert_readByFeed];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ReadFeedCount actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
