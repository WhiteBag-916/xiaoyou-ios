//
//  CommonImgUpload.h
//  Component
//
//  Created by 熊宸 on 15/10/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface CommonImgUpload : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *uploadType; //上传类型
@property (nonatomic, strong) NSString *needSnap;   //需要缩略图
@property (nonatomic, strong) NSString *imagePath;

@end
