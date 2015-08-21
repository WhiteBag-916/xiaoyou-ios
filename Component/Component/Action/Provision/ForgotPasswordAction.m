//
//  ForgotPasswordAction.m
//  Component
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ForgotPasswordAction.h"
#import "ResultCommon.h"
#import "YUtils+Component.h"

@implementation ForgotPasswordAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"schoolCode": [YShareData defaultData][kShareData_SchoolCode],
                                                     @"studentNo": _studentNo}];
    NSString *url = [YUtils getUrl:api_login_forgetPwd];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
