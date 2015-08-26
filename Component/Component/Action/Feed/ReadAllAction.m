//
//  ReadAllAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ReadAllAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation ReadAllAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES needAddUserID:YES];
    NSString *url = [YUtils getUrl:api_alert_readAll];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
