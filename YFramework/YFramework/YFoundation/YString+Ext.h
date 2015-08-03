//
//  YString+Ext.h
//  YFramework
//
//  Created by 熊宸 on 15/4/23.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString(Ext)

//! 是否是合法邮箱
- (BOOL)isValidEmail;
//! 是否是合法号码
- (BOOL)isValidPhoneNumber;
//! 是否是合法的18位身份证号码
- (BOOL)isValidPersonID;
//! 是否是合法的6-16位由数字字母组成的密码
- (BOOL)isValidPassword;
//! 是否是合法url
- (BOOL)isValidUrl;
/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code;

//判断是否为空
- (BOOL)isEmpty;

//自定义文本大小
- (CGSize)customTextSize:(UIFont *)font size:(CGSize)inputSize;

//自定义内容文字大小
- (CGSize)customContentTextSize:(UIFont *)font size:(CGSize)inputSize;
//字符串MD5 Mode
- (NSString *)md5;
@end
