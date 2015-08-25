//
//  FriendsConditionAction.m
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FriendsConditionAction.h"
#import "YUtils+Component.h"
#import "FriendsCondition.h"

@implementation FriendsConditionAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES];
    NSString *url = [YUtils getUrl:api_contact_FriendsCondition];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FriendsCondition actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
