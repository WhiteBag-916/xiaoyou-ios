//
//  FindMyCourseAction.m
//  Component
//
//  Created by 熊宸 on 15/10/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FindMyCourseAction.h"
#import "YUtils+Component.h"
#import "FindMyCourseModel.h"

@implementation FindMyCourseAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:nil needUserToken:YES];
    NSString *url = [YUtils getUrl:api_course_findMyCourse];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [FindMyCourseModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
