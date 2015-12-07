//
//  YFaceImageView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YFaceImageViewDelegate <NSObject>

@optional
/**
 *  @author 李思良, 15-12-05
 *
 *  @brief 点击事件的回调
 */
- (void)didClick;

@end

/**
 *  @author 李思良, 15-08-18
 *
 *  @brief  公用头像view，会自动处理点击事件，调用setData来传参数，该view所在的controller需要覆写- (void)dealProfileOpen:(NSString *)userId方法
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

@property (nonatomic, weak) id<YFaceImageViewDelegate> delegate;


- (void)setData:(NSString *)userId imageUrl:(NSString *)imageUrl;

@end
