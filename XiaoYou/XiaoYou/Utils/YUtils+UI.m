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

+ (UIImageView *)initImageView:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

@end
