//
//  ListCommentAction.m
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ListCommentAction.h"
#import "CommentListItems.h"
#import "YUtils+Component.h"

@implementation ListCommentAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter:@{@"lastId":SStr(_lastId), @"size":@(_size), @"feedId":_feedId} needUserToken:YES];
    NSString *url = [YUtils getUrl:api_feed_listComment];
    [self POST:url parameters:parameter completion:^(YHttpRequest *request) {
        YActionMessage *message = [CommentListItems actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
