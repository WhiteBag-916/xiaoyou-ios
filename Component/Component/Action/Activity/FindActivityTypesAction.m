//
//  FindActivityTypesAction.m
//  Component
//
//  Created by 熊宸 on 15/10/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FindActivityTypesAction.h"
#import "Tags.h"
#import "YUtils+Component.h"

@implementation FindActivityTypesAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_activity_findActivityTypes];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [Tags actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
