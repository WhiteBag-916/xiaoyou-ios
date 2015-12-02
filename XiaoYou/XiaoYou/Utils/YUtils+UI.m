//
//  YUtils+UI.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YUtils+UI.h"
#import "YTextField.h"

NSInteger const kLoginCommonTextFieldTag = 1999;

@implementation YUtils(UI)

+ (UIView *)initLoginCommonView:(NSString *)leftImage {
    //schoolview
    UIView *schoolView = [UIView new];
    schoolView.backgroundColor = KCOLORWHITE;
    
    //logo
    UIImageView *schoolLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftImage]];
    [schoolView addSubview:schoolLogoImageView];
    [schoolLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(25));
        make.height.mas_equalTo(SCALE_NUM(23));
        make.centerY.equalTo(schoolView);
    }];
    
    //line
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor hexChangeFloat:@"4e5659"];
    [schoolView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(schoolLogoImageView.mas_right).offset(SCALE_NUM(12));
        make.width.mas_equalTo(0.5);
        make.height.equalTo(schoolView).offset(SCALE_NUM(-13));
        make.centerY.equalTo(schoolView);
    }];
    
    //textField
    YTextField *inTextField = [[YTextField alloc] init];
    inTextField.tag = kLoginCommonTextFieldTag;
    inTextField.font = CONTENT_FONT(12);
    inTextField.textColor = KCOLOR_455A64;
    [schoolView addSubview:inTextField];
    [inTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(SCALE_NUM(14));
        make.right.mas_equalTo(SCALE_NUM(-14));
        make.top.height.equalTo(schoolView);
    }];
    
    return schoolView;
}

+ (UILabel *)initLabel:(UIFont *)font color:(UIColor *)color text:(NSString *)text frame:(CGRect)frame alignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = color;
    label.text = text;
    label.textAlignment = alignment;
    
    return label;
}

+ (UILabel *)initLabel:(UIFont *)font color:(UIColor *)color text:(NSString *)text alignment:(NSTextAlignment)alignment {
    return [self initLabel:font color:color text:text frame:CGRectZero alignment:alignment];
}

+ (UIImageView *)initImageView:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}


//
+(UILabel *)initLabel:(UIFont *)font color:(UIColor *)color text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    label.text = text;
    return label;
}

+(UIView *)initWrapContentViewWithBackGroundColor:(UIColor *)backGroudColor
                                      borderWidth:(CGFloat)boardWidth
                                      borderColor:(UIColor *)borderColor
                                      cornerRadius:(CGFloat)cornerRadius
{
    UIView *wrapContentView = [[UIView alloc]init];
    wrapContentView.backgroundColor = backGroudColor;
    wrapContentView.layer.borderWidth = boardWidth;
    wrapContentView.layer.borderColor = borderColor.CGColor;
    wrapContentView.layer.cornerRadius = cornerRadius;
    wrapContentView.clipsToBounds = YES;
    return wrapContentView;
}


////////////////////////////////////////////////////////////////////////////////////////////////
//UIImageView的创建方法
+(UIImageView *)initImageViewWithImageName:(NSString *)imagName
{
    UIImageView *imageView = [[UIImageView alloc]init];
    if (imagName != nil && imagName.length != 0)
        imageView.image = [UIImage imageNamed:imagName];
    return imageView;
}

+(UIImageView *)initImageViewWithImageName:(NSString *)imagName cornerRadius:(CGFloat)cornerRadius
{
    UIImageView *imageView = [[UIImageView alloc]init];
    if (imagName != nil && imagName.length != 0)
        imageView.image = [UIImage imageNamed:imagName];
    imageView.layer.cornerRadius = cornerRadius;
    imageView.clipsToBounds = YES;
    return imageView;
}
/////////////////////////////////////////////////////////////////////////////////////////////////

+(UIButton *)initButtonWithBackgroundColor:(UIColor*)backgroudColor
                         target:(id)target action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = backgroudColor;
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
/////////////////////////////////////////////////////////////////////////////////////////////////

+ (UIScrollView *)initScrollViewWithFrame:(CGRect)frame
                          backgroundColor:(UIColor *)color
                   userInteractionEnabled:(BOOL)enabel
                                 delegate:(id)delegate
                                  bounces:(BOOL)bounces
           showsHorizontalScrollIndicator:(BOOL)showH
             showsVerticalScrollIndicator:(BOOL)showV
                              contentSize:(CGSize)size
                            pagingEnabled:(BOOL)pagingEnabled
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame                            = frame;
    scrollView.backgroundColor                  = color;
    scrollView.userInteractionEnabled           = enabel;
    scrollView.pagingEnabled                    = YES;
    scrollView.delegate                         = delegate;
    scrollView.bounces                          = bounces;
    scrollView.showsHorizontalScrollIndicator   = showH;
    scrollView.showsVerticalScrollIndicator     = showV;
    scrollView.contentSize                      = size;
    scrollView.pagingEnabled                    = pagingEnabled;
    
    return scrollView;
}
/////////////////////////////////////////////////////////////////////////////////////////////////

+ (UIPageControl *)initPageControlWithBackgroundColor:(UIColor *)color
                               userInteractionEnabled:(BOOL)enabel
                                        numberOfPages:(NSInteger)numberOfPages
                                          currentPage:(NSInteger)currentPage
                               pageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
                        currentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    pageControl.userInteractionEnabled = enabel;
    pageControl.backgroundColor = color;
    pageControl.numberOfPages = numberOfPages;
    pageControl.currentPage = currentPage;
    pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
    pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    
    return pageControl;
}

@end
