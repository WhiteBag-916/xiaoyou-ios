//
//  YTableViewCell.m
//  YFramework
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YTableViewCell.h"
#import "YColor+Ext.h"

@implementation YTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ([self needLine]) {
            //线
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
            line.backgroundColor = [UIColor hexChangeFloat:@"e9e9e9"];
            [self.contentView addSubview:line];
        }
    }
    return self;
}

- (BOOL)needLine
{
    return NO;
}

@end
