//
//  TagListAction.m
//  Component
//
//  Created by 熊宸 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "TagListAction.h"
#import "Tags.h"
#import "YUtils+Component.h"

@implementation TagListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES];
    NSString *url = [YUtils getUrl:api_login_listTag];
//    __weak TagListAction *weakself = self;
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [Tags actionMessageWithHttpRequest:request];
        self.completionBlock(message);
//        weakself.completionBlock(message);
//        [weakself completed];
    }];
}

@end
