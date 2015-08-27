//
//  GroupDetailInfoAction.m
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupDetailInfoAction.h"
#import "GroupFeedList.h"
#import "YUtils+Component.h"

@implementation GroupDetailInfoAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"size":@(_size), @"groupId":_groupId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_group_groupDetailInfo];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [GroupFeedList actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
