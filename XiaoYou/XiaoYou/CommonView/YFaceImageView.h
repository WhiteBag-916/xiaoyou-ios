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
/**
 *  @author 李思良, 15-08-19
 *
 *  @brief  用户id
 */
@property (nonatomic, copy, readonly) NSString *userId;
/**
 *  @author 李思良, 15-08-19
 *
 *  @brief  用户头像url
 */
@property (nonatomic, copy, readonly) NSString *imgUrl;


- (void)setData:(NSString *)userId imageUrl:(NSString *)imageUrl;

@end
