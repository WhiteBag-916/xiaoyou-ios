//
//  CancleActivityAction.m
//  Component
//
//  Created by sheng on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CancleActivityAction.h"
#import "YUtils+Component.h"
@implementation CancleActivityAction

- (void)execute
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_activityPublishedId forKey:@"activityPublishedId"];
    NSDictionary *parameter = [YUtils getParameter:dic needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_activity_cancleAvtivity];
    
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [YModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
