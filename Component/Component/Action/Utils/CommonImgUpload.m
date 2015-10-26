//
//  CommonImgUpload.m
//  Component
//
//  Created by 熊宸 on 15/10/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CommonImgUpload.h"
#import "YUtils+Component.h"
#import "ImageUploadModel.h"
#import "YShareDataDefine.h"

@implementation CommonImgUpload

- (void)execute
{
    NSDictionary *parameter = [YUtils getParameter];
    NSString *url = [YUtils getUrl:api_img_uploadFiles];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?uploadType=%@&needSnap=%@&token=%@&schoolCode=%@&studentNo=%@", _uploadType, SStr(_needSnap), [YShareData defaultData][kShareData_Token], [YShareData defaultData][kShareData_SchoolCode] ,[YShareData defaultData][kShareData_StudentNo]]];
    [self Upload:url files:[_imagePath componentsSeparatedByString:@","] parameters:parameter sentProgress:nil completion:^(YHttpRequest *request) {
        YActionMessage *message = [ImageUploadModel actionMessageWithHttpRequest:request];
        self.completionBlock(message);
    }];
}

@end
