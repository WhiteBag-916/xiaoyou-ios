//
//  MessageListAction.m
//  Component
//
//  Created by HuiYin on 15/8/7.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MessageListAction.h"
#import "YDefine.h"
#import "YUtils+Component.h"
#import "SenderListModel.h"

@implementation MessageListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{
                                                    @"schoolCode": [YShareData defaultData][kShareData_SchoolCode],
                                                     @"studentNo": [YShareData defaultData][kShareData_StudentNo]
                                                    }];
    NSString *url = [YUtils getUrl:api_message_list];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [SenderListModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}


@end
