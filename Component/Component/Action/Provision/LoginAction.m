//
//  LoginAction.m
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "LoginAction.h"
#import "YDefine.h"
#import "LoginResp.h"
#import "YUtils+Component.h"

@implementation LoginAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"password": _password,
                                                     @"schoolCode": _schoolCode,
                                                     @"deviceId": _deviceId,
                                                     @"studentNo": _studentNo,
                                                     @"platform": _platform}];
    NSString *url = [YUtils getUrl:api_user_login];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [LoginResp actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
