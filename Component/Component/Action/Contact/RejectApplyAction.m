//
//  RejectApplyAction.m
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "RejectApplyAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation RejectApplyAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"userId":_userId, @"applyId":_applyId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_contact_RejectApply];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
