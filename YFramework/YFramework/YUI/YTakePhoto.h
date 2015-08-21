//
//  YTakePhoto.h
//  YFramework
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YTakePhotoDelegate <NSObject>

- (void)didUploadPhoto:(UIImage *)image url:(NSString *)url;

@end

@interface YTakePhoto : NSObject

@property (nonatomic, weak) id<YTakePhotoDelegate> delegate;

- (id)initWithDelegate:(id<YTakePhotoDelegate>)delegate;

- (void)openPhoto;
@end
