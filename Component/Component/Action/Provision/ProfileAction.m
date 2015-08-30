//
//  ProfileAction.m
//  Component
//
//  Created by 熊宸 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileAction.h"
#import "YUtils+Component.h"
#import "ProfileInfo.h"

@implementation ProfileAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"uid":SStr(_userID), @"hxId": SStr(_hxId)} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_profile];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ProfileInfo actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
