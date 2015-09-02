//
//  FeedImageGroup.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/15.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedImageGroup : UIView
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  含有拍照功能的使用这个
 *
 */
- (id)initWithCamera;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  根据图片url添加到组
 *
 */
- (void)updateWithImgs:(NSArray *)smallPics bigPics:(NSArray *)bigPics;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  添加一个照片image
 *
 */
- (void)addPhoto:(UIImage *)image;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  获取图片总数
 *
 */
- (int)getImgCount;
@end
