//
//  ApplyListAction.m
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ApplyListAction.h"
#import "YUtils+Component.h"
#import "ApplicantList.h"

@implementation ApplyListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"groupId":_groupId} needUserToken:YES needAddUserID:YES];
    NSString *url = [YUtils getUrl:api_contact_ApplyList];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ApplicantList actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
