//
//  RegNoticeAction.m
//  Component
//
//  Created by 熊宸 on 15/8/31.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "RegNoticeAction.h"
#import "EasyModel.h"
#import "YUtils+Component.h"

@implementation RegNoticeAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{}];
    NSString *url = [YUtils getUrl:api_user_notice];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [EasyModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
