//
//  ListPraisePeoplesAction.m
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ListPraisePeoplesAction.h"
#import "YUtils+Component.h"
#import "Author.h"

@implementation ListPraisePeoplesAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"limitStart":@(_limitStart), @"limitEnd":@(_limitEnd), @"feedId":SStr(_feedId)} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_feed_listPraisePeoples];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [Author actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
