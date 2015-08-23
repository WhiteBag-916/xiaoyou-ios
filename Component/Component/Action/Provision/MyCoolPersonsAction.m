//
//  MyCoolPersonsAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MyCoolPersonsAction.h"
#import "YUtils+Component.h"
#import "Author.h"

@implementation MyCoolPersonsAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"limitStart":@(_limitStart), @"limitEnd":@(_limitEnd)} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_myCoolPersons];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [Author actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
