//
//  SubmitApplyAction.m
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SubmitApplyAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation SubmitApplyAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"groupId":_groupId, @"applicant":_applicant} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_contact_SubmitApply];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
