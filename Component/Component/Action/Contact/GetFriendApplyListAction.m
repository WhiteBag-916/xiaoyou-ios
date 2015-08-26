//
//  GetFriendApplyListAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GetFriendApplyListAction.h"
#import "YUtils+Component.h"
#import "ApplicantList.h"

@implementation GetFriendApplyListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES needAddUserID:YES];
    NSString *url = [YUtils getUrl:api_friend_GetApplyList];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ApplicantList actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
