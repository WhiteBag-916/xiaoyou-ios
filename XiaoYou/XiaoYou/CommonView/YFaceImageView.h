//
//  YFaceImageView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author 李思良, 15-08-18
 *
 *  @brief  公用头像view，会自动处理点击事件，发送打开个人页面的notification
 */
@interface YFaceImageView : UIImageView

@property (nonatomic, copy, readonly) NSString *userId;

@property (nonatomic, copy, readonly) NSString *imgUrl;

@end
