//
//  YLabel+Ext.h
//  YFramework
//
//  Created by 熊宸 on 15/10/20.
//  Copyright © 2015年 YCPai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(Ext)

/*********************************************************************
 函数名称 : setText
 函数描述 : 文字 行高
 参数 : 高度
 返回值 : N/A
 作者 : XiongChen
 *********************************************************************/
- (void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;

@end
