//
//  UploadTagCodes.m
//  Component
//
//  Created by 熊宸 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "UploadTagCodes.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation UploadTagCodes

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"tagCodes" : _tagCodes} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_addTag];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
