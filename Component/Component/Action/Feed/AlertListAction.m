//
//  AlertListAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AlertListAction.h"
#import "AlertList.h"
#import "YUtils+Component.h"

@implementation AlertListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"lastId":SStr(_lastId), @"size":@(_size)} needUserToken:YES needAddUserID:YES];
    NSString *url = [YUtils getUrl:api_alert_list];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [AlertList actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
