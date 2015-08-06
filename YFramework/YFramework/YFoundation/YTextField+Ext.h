//
//  YTextField+Ext.h
//  YFramework
//
//  Created by 石岳 on 15/5/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField(Ext)

/**
 *  更改texField PlacHolder 颜色
 *  @author shiyue
 *  @param textField textField
 *  @param string    placeholder提示字
 *  @param color     想要改变的颜色
 */
+ (void)placeHolderColor:(UITextField *)textField normalString:(NSString *)string fontColor:(UIColor *)color;

@end