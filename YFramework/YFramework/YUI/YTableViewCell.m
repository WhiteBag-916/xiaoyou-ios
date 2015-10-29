//
//  YTableViewCell.m
//  YFramework
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YTableViewCell.h"
#import "YColor+Ext.h"

#define KLINE_TAG       1999221

@implementation YTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    if ([self needLine]) {
        UIView *oldLine = [self.contentView viewWithTag:KLINE_TAG];
        if (nil != oldLine) {
            [oldLine removeFromSuperview];
        }
        //线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake([self lineX], self.frame.size.height-1, self.frame.size.width, 1)];
        line.tag = KLINE_TAG;
        line.backgroundColor = [self lineColor];
        [self.contentView addSubview:line];
    }
}

- (BOOL)needLine
{
    return NO;
}

- (UIColor *)lineColor {
    return [UIColor hexChangeFloat:@"e9e9e9"];
}

- (CGFloat)lineX
{
    return 0;
}

@end
