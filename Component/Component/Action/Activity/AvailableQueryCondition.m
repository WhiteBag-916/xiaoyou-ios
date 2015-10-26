//
//  AvailableQueryCondition.m
//  Component
//
//  Created by sheng on 15/10/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AvailableQueryCondition.h"
#import "FilterConditionModels.h"
#import "YUtils+Component.h"

@implementation AvailableQueryCondition

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES needContent:NO];
    NSString *url = [YUtils getUrl:api_filter_condition];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FilterConditionModels actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
