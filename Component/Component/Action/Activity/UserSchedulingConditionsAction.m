//
//  UserSchedulingConditionsAction.m
//  Component
//
//  Created by 熊宸 on 15/10/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "UserSchedulingConditionsAction.h"
#import "YUtils+Component.h"
#import "UserSchedulingListConditionsModel.h"

@implementation UserSchedulingConditionsAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES];
    NSString *url = [YUtils getUrl:api_userScheduling_getUserSchedulingListConditions];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [UserSchedulingListConditionsModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
