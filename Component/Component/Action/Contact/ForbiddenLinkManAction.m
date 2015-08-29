//
//  ForbiddenLinkManAction.m
//  Component
//
//  Created by 熊宸 on 15/8/29.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ForbiddenLinkManAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation ForbiddenLinkManAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"forbiddenId":_forbiddenId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_contact_forbiddenLinkMan];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
