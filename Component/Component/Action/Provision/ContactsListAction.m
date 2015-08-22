//
//  ContactsListAction.m
//  Component
//
//  Created by HuiYin on 15/8/7.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsListAction.h"
#import "YDefine.h"
#import "LinkManModel.h"
#import "YUtils+Component.h"

@implementation ContactsListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES];
    NSString *url = [YUtils getUrl:api_contacts_list];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [LinkManModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}


@end
