//
//  MyPraisePersonsAction.m
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MyPraisePersonsAction.h"
#import "YUtils+Component.h"
#import "Author.h"

@implementation MyPraisePersonsAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_myPraisePersons];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [Author actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
