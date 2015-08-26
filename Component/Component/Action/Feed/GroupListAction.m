//
//  GroupListAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupListAction.h"
#import "YUtils+Component.h"
#import "GroupModel.h"

@implementation GroupListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"limitStart":@(_limitStart), @"limitEnd":@(_limitEnd), @"queryCode":SStr(_queryCode), @"name":SStr(_name)} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_group_groupList];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [GroupModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
