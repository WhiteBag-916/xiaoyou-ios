//
//  AvailableAction.m
//  Component
//
//  Created by sheng on 15/10/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AvailableAction.h"
#import "YUtils+Component.h"
#import "ActivityInfoModel.h"

@implementation AvailableAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"limitStart":@(_limitStart), @"limitEnd":@(_limitEnd)} needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_available_list];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ActivityInfoModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
