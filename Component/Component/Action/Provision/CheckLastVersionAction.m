//
//  CheckLastVersionAction.m
//  Component
//
//  Created by 熊宸 on 15/11/18.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CheckLastVersionAction.h"
#import "CheckLastVersionModel.h"
#import "YUtils+Component.h"

@implementation CheckLastVersionAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"version":kBundle_Short_Version, @"appPlatform":@"2"}];
    NSString *url = [YUtils getUrl:api_version_checkLastVersion];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [CheckLastVersionModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
