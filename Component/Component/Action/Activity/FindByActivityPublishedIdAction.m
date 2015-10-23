//
//  FindByActivityPublishedIdAction.m
//  Component
//
//  Created by 熊宸 on 15/10/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FindByActivityPublishedIdAction.h"
#import "ActivityInfoModel.h"
#import "YUtils+Component.h"

@implementation FindByActivityPublishedIdAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"id":_activityId} needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_available_findByActivityPublishedId];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ActivityInfoModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
