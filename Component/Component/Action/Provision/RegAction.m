//
//  RegAction.m
//  Component
//
//  Created by 熊宸 on 15/8/30.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "RegAction.h"
#import "LoginResp.h"
#import "YUtils+Component.h"

@implementation RegAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"authCode": _password,
                                                     @"schoolCode": _schoolCode,
                                                     @"studentNo": _studentNo,
                                                     @"platform": _platform,
                                                     @"mobilePhone": _mobilePhone}];
    NSString *url = [YUtils getUrl:api_user_reg];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [LoginResp actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
