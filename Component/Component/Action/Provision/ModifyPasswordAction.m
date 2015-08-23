//
//  ModifyPasswordAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ModifyPasswordAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation ModifyPasswordAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"password":_password, @"oldPassWord":_oldPassWord} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_ModifyPassword];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
