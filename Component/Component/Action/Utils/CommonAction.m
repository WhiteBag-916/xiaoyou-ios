//
//  CommonAction.m
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "CommonAction.h"
#import "ResultCommon.h"

@implementation CommonAction

- (void)execute
{
    [self POST:_url parameters:_parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ResultCommon actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
