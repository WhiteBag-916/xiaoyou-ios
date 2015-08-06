//
//  YImage+Ext.h
//  YFramework
//
//  Created by 熊宸 on 15/4/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Ext)

//按rect尺寸重绘
- (UIImage *)imageAtRect:(CGRect)rect;
//按比例缩放最小尺寸
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToMaximumSize:(CGSize)targetSize;
//按比例缩放
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
//图像缩放大小
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
//图像旋转弧度
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
//图像旋转度
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
//图片重合
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
//改变属性
- (UIImage *) imageWithBackgroundColor:(UIColor *)bgColor
                           shadeAlpha1:(CGFloat)alpha1
                           shadeAlpha2:(CGFloat)alpha2
                           shadeAlpha3:(CGFloat)alpha3
                           shadowColor:(UIColor *)shadowColor
                          shadowOffset:(CGSize)shadowOffset
                            shadowBlur:(CGFloat)shadowBlur;
//图像阴影颜色
- (UIImage *)imageWithShadowColor:(UIColor *)shadowColor
                     shadowOffset:(CGSize)shadowOffset
                       shadowBlur:(CGFloat)shadowBlur;
//图像透明度
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;
+ (UIImage*)imageWithRandomColorOfSize:(CGSize)size;
+ (UIImage *)imageWithLocalPathOfUrl:(NSString *)imageURL;

@end
