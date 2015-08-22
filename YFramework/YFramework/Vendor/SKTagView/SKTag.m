//
// Created by Shaokang Zhao on 15/1/12.
// Copyright (c) 2015 Shaokang Zhao. All rights reserved.
//

#import "SKTag.h"
#import "YColor+Ext.h"
@implementation SKTag

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self)
    {
        _text = text;
        _fontSize = 15;
        _textColor = [UIColor blackColor];
        _bgColor = [UIColor whiteColor];
        _enable = YES;
    }
    
    return self;
}

+ (instancetype)tagWithText:(NSString *)text
{
    return [[self alloc] initWithText:text];
}
- (void)updateWithPublishSelectType:(BOOL)select {
    if (select) {
        [self updateWithPublishSelectedType];
    } else {
        [self updateWithPublishUnselectType];
    }
}
- (void)updateWithPublishSelectedType {
    _fontSize = 12;
    _textColor = [UIColor whiteColor];
    _borderWidth = 1;
    _borderColor = [UIColor hexChangeFloat:@"455A64"];
    _bgColor = [UIColor hexChangeFloat:@"455A64"];
    _cornerRadius = 2;
    
    _preferSize = CGSizeMake((_text.length < 5?5:_text.length) * _fontSize + 30, 32);
}

- (void)updateWithPublishUnselectType {
    _fontSize = 12;
    _textColor = [UIColor hexChangeFloat:@"455A64"];
    _borderWidth = 1;
    _borderColor = [UIColor hexChangeFloat:@"455A64"];
    _bgColor = [UIColor clearColor];
    _cornerRadius = 2;
    _preferSize = CGSizeMake((_text.length < 5?5:_text.length) * _fontSize + 30, 32);
}

@end