//
//  AvailableAction.m
//  Component
//
//  Created by sheng on 15/10/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AvailableAction.h"
#import "YUtils+Component.h"
#import "ActivityInfoModel.h"

@implementation AvailableAction

- (void)execute
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_condition];
    [dic setObject:@(_limitStart) forKey:@"limitStart"];
    [dic setObject:@(_limitEnd) forKey:@"limitEnd"];
    [dic setObject:SStr(_searchText) forKey:@"name"];
    NSDictionary *parameter = [YUtils getParameter:dic needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_available_list];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [ActivityInfoModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
