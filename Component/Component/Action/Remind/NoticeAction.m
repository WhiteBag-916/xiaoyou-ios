//
//  NoticeAction.m
//  Component
//
//  Created by sheng on 15/10/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NoticeAction.h"
#import "YUtils+Component.h"
#import "NoticeInfo.h"

@implementation NoticeAction

-(void)execute
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(_limiteStart) forKey:@"limitStart"];
    [dic setObject:@(_limiteEnd) forKey:@"limitEnd"];
    NSDictionary *parameter = [YUtils getParameter:dic needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_remind_list];
    
    
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        NSLog(@"this is parameter....==%@",parameter);
        
        YActionMessage *message = [NoticeInfo actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
