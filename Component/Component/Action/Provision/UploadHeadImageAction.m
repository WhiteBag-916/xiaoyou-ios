//
//  UploadHeadImageAction.m
//  Component
//
//  Created by 熊宸 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "UploadHeadImageAction.h"
#import "YUtils+Component.h"
#import "UploadImage.h"
#import "YShareDataDefine.h"

@implementation UploadHeadImageAction

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter];
    NSString *url = [YUtils getUrl:api_login_updateHeadPic];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?token=%@&schoolCode=%@&studentNo=%@", [YShareData defaultData][kShareData_Token], [YShareData defaultData][kShareData_SchoolCode] ,[YShareData defaultData][kShareData_StudentNo]]];
    [self Upload:url files:@[_imagePath] parameters:parameter sentProgress:nil completion:^(YHttpRequest *request) {
        YActionMessage *message = [UploadImage actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
