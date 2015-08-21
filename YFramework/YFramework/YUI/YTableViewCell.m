//
//  YTableViewCell.m
//  YFramework
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YTableViewCell.h"

@implementation YTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
