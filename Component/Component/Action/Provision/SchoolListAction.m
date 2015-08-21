//
//  SchoolListAction.m
//  Component
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SchoolListAction.h"
#import "SchoolListModel.h"
#import "YUtils+Component.h"

@implementation SchoolListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"schoolName": _schoolName}];
    NSString *url = [YUtils getUrl:api_login_schoolList];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [SchoolListModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
