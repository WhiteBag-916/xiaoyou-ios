//
//  InterestListAction.m
//  Component
//
//  Created by 熊宸 on 15/11/6.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "InterestListAction.h"
#import "InterestModel.h"
#import "YUtils+Component.h"

@implementation InterestListAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"publishDay": @(_publishDay), @"maxSize": @(_maxSize)} needUserToken:YES needContent:YES];
    NSString *url = [YUtils getUrl:api_news_list];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [InterestModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
