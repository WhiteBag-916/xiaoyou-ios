//
//  UploadFeedImageAction.m
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "UploadFeedImageAction.h"
#import "YUtils+Component.h"
#import "UploadImage.h"
#import "YShareDataDefine.h"

@implementation UploadFeedImageAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter];
    NSString *url = [YUtils getUrl:api_feed_UpdateImg needUserToken:YES];
    [self Upload:url files:@[_imagePath] parameters:parameter sentProgress:nil completion:^(YHttpRequest *request) {
        YActionMessage *message = [UploadImage actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
