//
//  ForbiddenMeListAction.m
//  Component
//
//  Created by 熊宸 on 15/8/29.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ForbiddenMeListAction.h"
#import "YUtils+Component.h"
#import "ForbiddenList.h"

@implementation ForbiddenMeListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES];
    NSString *url = [YUtils getUrl:api_contact_forbiddenMeList];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ForbiddenList actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
