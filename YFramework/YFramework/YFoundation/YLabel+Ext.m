//
//  YLabel+Ext.m
//  YFramework
//
//  Created by 熊宸 on 15/10/20.
//  Copyright © 2015年 YCPai. All rights reserved.
//

#import "YLabel+Ext.h"

@implementation UILabel(Ext)

- (void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:text];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:lineSpacing];
    //根据给定长度与style设置attStr式样
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    //Label获取attStr式样
    self.attributedText = attStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
