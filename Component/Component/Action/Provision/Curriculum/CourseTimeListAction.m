//
//  CourseTimeListAction.m
//  Component
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CourseTimeListAction.h"
#import "YUtils+Component.h"
#import "CourseTimeListModel.h"

@implementation CourseTimeListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"schoolCode":[YShareData defaultData][kShareData_SchoolCode]} needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_courseTime_list];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [CourseTimeListModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
