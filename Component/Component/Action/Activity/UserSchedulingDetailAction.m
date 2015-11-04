//
//  UserSchedulingDetailAction.m
//  Component
//
//  Created by 熊宸 on 15/10/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "UserSchedulingDetailAction.h"
#import "YUtils+Component.h"
#import "UserSchedulingInfo.h"

@implementation UserSchedulingDetailAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"id":@(_uid)} needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_userScheduling_findById];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [UserSchedulingInfo actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
