//
//  FindFriendsByTagsAction.m
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FindFriendsByTagsAction.h"
#import "Author.h"
#import "YUtils+Component.h"

@implementation FindFriendsByTagsAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"limitStart":@(_limitStart), @"limitEnd":@(_limitEnd), @"queryCode":_queryCode} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_FindFriendsByTags];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [Author actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
