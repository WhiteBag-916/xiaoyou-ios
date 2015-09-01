//
//  SuggestListAction.m
//  Component
//
//  Created by HuiYin on 15/9/1.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SuggestListAction.h"
#import "YUrlDefine.h"
#import "SuggestListModel.h"
#import "YUtils+Component.h"

@implementation SuggestListAction

- (void)execute
{
    [self GET:[YUtils getUrl:api_suggest_list] parameters:nil completion:^(YHttpRequest *request) {
        YActionMessage *message = [SuggestListModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
