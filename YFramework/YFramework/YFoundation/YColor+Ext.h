//
//  YColor+Ext.h
//  YFramework
//
//  Created by 熊宸 on 15/4/22.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Ext)

///< 根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;

///< 根据颜色、图片大小 生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// 将十六进制颜色的字符串转化为复合iphone/ipad的颜色
// 字符串为"FFFFFF"
+ (UIColor *)hexChangeFloat:(NSString *) hexColor;

@end
