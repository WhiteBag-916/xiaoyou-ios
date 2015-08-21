//
//  YTakePhoto.m
//  YFramework
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YTakePhoto.h"
#import "YCommonActionSheet.h"

@interface YTakePhoto()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation YTakePhoto

- (id)initWithDelegate:(id<YTakePhotoDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (void)openPhoto {
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"拍照" type:YCommonActionSheetItemTypeCommon block:^(NSInteger checkNum) {
        [self openType:true];
    }];
    
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"从相册中选择"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self openType:false];
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] title:nil];
    [sheet show];
}
- (void)openType:(BOOL)isCamera {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    if (isCamera) {
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window.rootViewController presentViewController:controller animated:true completion:^{
        
    }];
}
@end
