//
//  GroupConditionsAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupConditionsAction.h"
#import "YUtils+Component.h"
#import "Tags.h"

@implementation GroupConditionsAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES];
    NSString *url = [YUtils getUrl:api_group_groupConditions];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [Tags actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
