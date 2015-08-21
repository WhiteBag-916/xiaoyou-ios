//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTagButton.h"
#import "SKTag.h"
#import "YVIew+Ext.h"

@interface SKTagButton()
@property (nonatomic) CGSize preferSize;

@end

@implementation SKTagButton

+ (instancetype)buttonWithTag:(SKTag *)tag
{
	SKTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
	
    [btn updateWithTag:tag];
    
    return btn;
}
- (void)updateWithTag:(SKTag *)tag {
    if (tag.attributedText) {
        [self setAttributedTitle:tag.attributedText forState:UIControlStateNormal];
    } else {
        [self setTitle:tag.text forState:UIControlStateNormal];
        [self setTitleColor:tag.textColor forState:UIControlStateNormal];
        self.titleLabel.font = tag.font ?: [UIFont systemFontOfSize:tag.fontSize];
    }
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.backgroundColor = tag.bgColor;
    self.contentEdgeInsets = tag.padding;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    if (tag.bgImg)
    {
        [self setBackgroundImage:tag.bgImg forState:UIControlStateNormal];
    }
    
    if (tag.borderColor)
    {
        self.layer.borderColor = tag.borderColor.CGColor;
    }
    
    if (tag.borderWidth)
    {
        self.layer.borderWidth = tag.borderWidth;
    }
    
    self.userInteractionEnabled = tag.enable;
    
    self.layer.cornerRadius = tag.cornerRadius;
    self.layer.masksToBounds = YES;
    
    if (tag.preferSize.width > 0) {
        _preferSize = tag.preferSize;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (CGSize)intrinsicContentSize {
    if (_preferSize.width > 0) {
        return _preferSize;
    }
    return [super intrinsicContentSize];
}

@end
