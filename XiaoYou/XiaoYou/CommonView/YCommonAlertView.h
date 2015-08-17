//
//  YCommonAlertView.h
//  YCPai
//
//  Created by ycpai on 15/7/6.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCommonAlertView : UIView

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;

//初始化
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

//按钮点击事件
- (void)clickedButtonHandler:(void (^)(NSInteger index))handler;

//显示
- (void)show;

//隐藏
- (void)hide;

// 设置标题字体颜色和大小
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

//设置内容字体颜色和大小
- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size;

//设置某一个按钮颜色和大小
- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index;


@end

