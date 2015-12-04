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
@class YTextView;
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

+ (UIView *)initLineViewWithbackgroundColor:(UIColor *)color;
/*********************************************************************
 函数名称 : initScrollView
 函数描述 : 构造ScrollView
 参数 : 你懂的
 返回值 : 你懂的
 作者 : 尹先森
 *********************************************************************/
+ (UIScrollView *)initScrollViewWithFrame:(CGRect)frame
                          backgroundColor:(UIColor *)color
                   userInteractionEnabled:(BOOL)enabel
                                 delegate:(id)delegate
                                  bounces:(BOOL)bounces
           showsHorizontalScrollIndicator:(BOOL)showH
             showsVerticalScrollIndicator:(BOOL)showV
                              contentSize:(CGSize)size
                            pagingEnabled:(BOOL)pagingEnabled;
/*********************************************************************
 函数名称 : initPageControl
 函数描述 : 构造PageControl
 参数 : 你懂的
 返回值 : 你懂的
 作者 : 尹先森
 *********************************************************************/
+ (UIPageControl *)initPageControlWithBackgroundColor:(UIColor *)color
                   userInteractionEnabled:(BOOL)enabel
                            numberOfPages:(NSInteger)numberOfPages
                              currentPage:(NSInteger)currentPage
                   pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
            currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor;
/*********************************************************************
 函数名称 : initLabel
 函数描述 : 构造Label
 参数 : 你懂的
 返回值 : 你懂的
 作者 : 尹先森
 *********************************************************************/
+ (UILabel *)initLabelWithBackgroundColor:(UIColor *)color
                                     font:(UIFont *)font
                            numberOfLines:(NSInteger)numberOfLines
                            textAlignment:(NSTextAlignment)textAlignment
                                textColor:(UIColor *)textColor
                                     text:(NSString *)text;
/*********************************************************************
 函数名称 : initLabel
 函数描述 : 构造Label
 参数 : 你懂的
 返回值 : 你懂的
 作者 : 尹先森
 *********************************************************************/
+ (UIImageView *)initImageViewWithBackgroundColor:(UIColor *)color
                                     cornerRadius:(NSInteger)cornerRadius
                            clipsToBounds:(BOOL)clipsToBounds
                            image:(UIImage *)image;

/*********************************************************************
 函数名称 : initView
 函数描述 : 构造View
 参数 : 你懂的
 返回值 : 你懂的
 作者 : 尹先森
 *********************************************************************/
+ (UIView *)initViewWithBackgroundColor:(UIColor *)color
                                     cornerRadius:(NSInteger)cornerRadius
                                    clipsToBounds:(BOOL)clipsToBounds
                                  alpha:(double)alpha;


+ (UITextView *)initDisplayTextViewWithFont:(UIFont*)font
                                  textColor:(UIColor*)color;

+ (YTextView *)initLinkDisplayTextViewWithFont:(UIFont*)font
                                     textColor:(UIColor*)color;

+ (void)setTextViewDataWithTextView:(UITextView*)textView text:(NSString*)text Font:(UIFont*)font
                          textColor:(UIColor*)textColor linespaing:(CGFloat)lineSpace;
@end
