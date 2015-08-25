//
//  AgreeApplyAction.m
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AgreeApplyAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation AgreeApplyAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"applyId":_applyId,@"userId":_userId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_contact_AgreeApply];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
