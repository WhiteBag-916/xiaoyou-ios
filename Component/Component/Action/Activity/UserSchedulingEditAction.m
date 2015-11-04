//
//  UserSchedulingEditAction.m
//  Component
//
//  Created by 熊宸 on 15/11/4.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "UserSchedulingEditAction.h"
#import "YUtils+Component.h"
#import "UserSchedulingInfo.h"

@implementation UserSchedulingEditAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:_contentDic needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_userScheduling_edit];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [UserSchedulingInfo actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
