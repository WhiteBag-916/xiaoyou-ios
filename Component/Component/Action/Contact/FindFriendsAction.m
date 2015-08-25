//
//  FindFriendsAction.m
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FindFriendsAction.h"
#import "YUtils+Component.h"
#import "Author.h"

@implementation FindFriendsAction

- (void)execute
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_condition];
    [dic setObject:@(_limitStart) forKey:@"limitStart"];
    [dic setObject:@(_limitEnd) forKey:@"limitEnd"];
    NSDictionary *parameter = [YUtils getParameter:dic needUserToken:YES];
    NSString *url = [YUtils getUrl:api_contact_FindFriends];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [Author actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
