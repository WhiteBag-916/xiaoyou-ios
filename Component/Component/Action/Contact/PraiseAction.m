//
//  PraiseAction.m
//  Component
//
//  Created by 熊宸 on 15/8/24.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "PraiseAction.h"
#import "YUtils+Component.h"
#import "ResultCommon.h"

@implementation PraiseAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"bePraiseId":_bePraiseId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_contact_Praise];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
