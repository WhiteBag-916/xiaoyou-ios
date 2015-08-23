//
//  ReceiveMobileAuthCodeAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ReceiveMobileAuthCodeAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation ReceiveMobileAuthCodeAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"mobilePhone":_mobilePhone, @"authCode":_authCode} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_ReceiveMobileAuthCode];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
