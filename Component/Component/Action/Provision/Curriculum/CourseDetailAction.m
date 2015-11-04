//
//  CourseDetailAction.m
//  Component
//
//  Created by 熊宸 on 15/11/4.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CourseDetailAction.h"
#import "YUtils+Component.h"
#import "CourseDetail.h"

@implementation CourseDetailAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"id":_uid} needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_course_detail];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [CourseDetail actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
