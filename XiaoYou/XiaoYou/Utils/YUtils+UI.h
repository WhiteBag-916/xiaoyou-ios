//
//  YUtils+UI.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YUtils.h"
#import "YFoundation.h"

extern NSInteger const kLoginCommonTextFieldTag;

@interface YUtils(UI)

/*********************************************************************
 函数名称 : initLoginCommonView
 函数描述 : 你懂的
 参数 : 你懂的
 返回值 : 你懂的
 作者 : XiongChen
 *********************************************************************/
+ (UIView *)initLoginCommonView:(NSString *)leftImage;

/*********************************************************************
 函数名称 : initLabel
 函数描述 : 构造label
 参数 : 你懂的
 返回值 : 你懂的
 作者 : XiongChen
 *********************************************************************/
+ (UILabel *)initLabel:(UIFont *)font color:(UIColor *)color text:(NSString *)text frame:(CGRect)frame alignment:(NSTextAlignment)alignment;

/*********************************************************************
 函数名称 : initLabel
 函数描述 : 构造label
 参数 : 你懂的
 返回值 : 你懂的
 作者 : XiongChen
 *********************************************************************/
+ (UILabel *)initLabel:(UIFont *)font color:(UIColor *)color text:(NSString *)text alignment:(NSTextAlignment)alignment;

/*********************************************************************
 函数名称 : initImageView
 函数描述 : 构造imageView
 参数 : 你懂的
 返回值 : 你懂的
 作者 : XiongChen
 *********************************************************************/
+ (UIImageView *)initImageView:(UIImage *)image frame:(CGRect)frame;


+ (UILabel *)initLabel:(UIFont *)font color:(UIColor *)color text:(NSString *)text;

+ (UIView *)initWrapContentViewWithBackGroundColor:(UIColor*)color
                                       borderWidth:(CGFloat)boardWidth
                                       borderColor:(UIColor*)borderColor
                                      cornerRadius:(CGFloat)cornerRadius;

+ (UIImageView *)initImageViewWithImageName:(NSString*)imagName;

+ (UIImageView *)initImageViewWithImageName:(NSString *)imagName cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)initButtonWithBackgroundColor:(UIColor*)backgroudColor
                                    target:(id)target action:(SEL)selector;

+ (UIScrollView *)initScrollViewWithFrame:(CGRect)frame
                          backgroundColor:(UIColor *)color
                   userInteractionEnabled:(BOOL)enabel
                                 delegate:(id)delegate
                                  bounces:(BOOL)bounces
           showsHorizontalScrollIndicator:(BOOL)showH
             showsVerticalScrollIndicator:(BOOL)showV
                              contentSize:(CGSize)size
                            pagingEnabled:(BOOL)pagingEnabled;

+ (UITextView *)initDisplayTextViewWithFont:(UIFont*)font
                                  textColor:(UIColor*)color;
@end
