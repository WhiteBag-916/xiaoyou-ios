//
//  GroupDetailAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupDetailAction.h"
#import "YUtils+Component.h"
#import "GroupDetail.h"

@implementation GroupDetailAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"groupId":_groupId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_group_GroupDetail];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [GroupDetail actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
