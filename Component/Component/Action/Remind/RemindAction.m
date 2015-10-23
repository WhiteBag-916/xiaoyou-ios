//
//  RemindAction.m
//  Component
//
//  Created by sheng on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindAction.h"
#import "YUtils+Component.h"
#import "RemindInfoTest.h"
@implementation RemindAction

-(void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"uid":SStr(@"test"), @"limitStart":@("test"), @"limitEnd":@("test")} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_remind_list];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [RemindInfoTest actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
