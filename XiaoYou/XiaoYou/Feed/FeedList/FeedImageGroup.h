//
//  FeedImageGroup.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/15.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedImageGroupDelegate <NSObject>

@optional
/**
 *  @author 李思良, 15-12-05
 *
 *  @brief 通知查看照片的事件
 */
- (void)didOpenPhoto;

@end

@interface FeedImageGroup : UIView

@property   (assign,    nonatomic)  BOOL hasSaveBtn;

@property   (assign,    nonatomic)  BOOL hasDeleteBtn;

@property   (weak,      nonatomic)  id<FeedImageGroupDelegate> delegate;
/**
 *  @author desheng, 15-11-22
 *
 *  @brief 需要定制图片大小使用这个
 *
 */

-(id)initWithImageSize:(CGFloat)size;

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

//打开相机
- (void)openPhoto;

- (void)addPhotoPath:(NSString*)path;

- (NSMutableArray *)smallImgs;

@end
