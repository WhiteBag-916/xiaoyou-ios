//
//  AddPraiseAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AddPraiseAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation AddPraiseAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"feedId" : _feedId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_feed_addPraise];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
