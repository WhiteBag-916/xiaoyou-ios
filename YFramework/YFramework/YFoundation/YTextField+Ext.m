//
//  YTextField+Ext.m
//  YFramework
//
//  Created by 石岳 on 15/5/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTextField+Ext.h"

@implementation  UITextField(Ext)

+ (void)placeHolderColor:(UITextField *)textField normalString:(NSString *)string fontColor:(UIColor *)color
{
    textField.attributedPlaceholder= [[NSAttributedString alloc]initWithString:string
                                                                    attributes:@{NSForegroundColorAttributeName:color}];
}

@end