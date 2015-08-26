//
//  AgreeFriendApplyAction.m
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AgreeFriendApplyAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation AgreeFriendApplyAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"applyId":_applyId} needUserToken:YES needAddUserID:YES];
    NSString *url = [YUtils getUrl:api_friend_AgreeApply];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
