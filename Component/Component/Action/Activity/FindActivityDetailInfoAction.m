//
//  FindActivityDetailInfoAction.m
//  Component
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FindActivityDetailInfoAction.h"
#import "ActivityDetailModel.h"
#import "YUtils+Component.h"

@implementation FindActivityDetailInfoAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"activityPublishedId":_activityPublishedId} needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_activity_findActivityDetailInfo];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ActivityDetailModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}


@end
