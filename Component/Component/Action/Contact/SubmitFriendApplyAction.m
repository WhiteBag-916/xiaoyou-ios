//
//  SubmitFriendApplyAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SubmitFriendApplyAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation SubmitFriendApplyAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"targetId":_targetId} needUserToken:YES needAddUserID:YES];
    NSString *url = [YUtils getUrl:api_friend_SubmitFriendApply];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
