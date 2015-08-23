//
//  ReceiveAuthCodeAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ReceiveAuthCodeAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation ReceiveAuthCodeAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"flag":@"1", @"mobilePhone":_mobilePhone} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_UpdateSelfIntro];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
