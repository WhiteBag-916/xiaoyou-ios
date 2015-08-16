//
//  ContactsListAction.m
//  Component
//
//  Created by HuiYin on 15/8/7.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsListAction.h"
#import "YDefine.h"
#import "ContactsListModel.h"
#import "YUtils+Component.h"

@implementation ContactsListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{
                                                     @"schoolCode": [YShareData defaultData][kShareData_SchoolCode],
                                                     @"myStudentNo": [YShareData defaultData][kShareData_StudentNo],@"token":[YShareData defaultData][kShareData_Token]
                                                     }];
    NSString *url = [YUtils getUrl:api_contacts_list];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ContactsListModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}


@end
