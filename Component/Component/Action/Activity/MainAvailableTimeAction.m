//
//  MainAvailableTimeAction.m
//  Component
//
//  Created by sheng on 15/11/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MainAvailableTimeAction.h"
#import "YUtils+Component.h"
#import "AvailableTimeModel.h"

@implementation MainAvailableTimeAction

- (void)execute
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(_limitStart) forKey:@"limitStart"];
    [dic setObject:@(_limitEnd) forKey:@"limitEnd"];
    //[dic setObject:@(_isGetScheduling) forKey:@"isGetScheduling"];
    NSDictionary *parameter = [YUtils getParameter:dic needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_avalible_main_page_list];
    
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        
        YActionMessage *message = [AvailableTimeModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
