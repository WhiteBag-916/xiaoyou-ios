
//
//  YFlatSwitchView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YFlatSwitchView.h"
#import "YColor+Ext.h"
#define KLABELTAG 10000

@interface YFlatSwitchView()
@property (nonatomic, copy  )   ChangeSwitchState changeStateBlock;
@property (nonatomic, strong)   UIView *line;
@property (nonatomic, assign)   int index;
@end
@implementation YFlatSwitchView

- (instancetype)initWithText:(NSArray *)textArray {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor hexChangeFloat:@"e5ebea"];
        UIView *tmp = nil;
        for (int i = 0; i < textArray.count; i++) {
            UILabel *label = [YUtils initLabel:CONTENT_FONT(14) color:KCOLORWHITE_696969 text:textArray[i] frame:CGRectZero alignment:NSTextAlignmentCenter];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                if (tmp == nil) {
                    make.left.equalTo(self);
                } else {
                    make.left.equalTo(tmp.mas_right);
                }
                make.top.bottom.equalTo(self);
                make.width.equalTo(self).multipliedBy(1.f/textArray.count);
            }];
            label.tag = KLABELTAG + i;
            
            label.userInteractionEnabled = true;
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)]];
            
            tmp = label;
        }
        _index = 0;
        [self.subviews[0] setTextColor:KCOLORGREEN_009688];
        _line = [[UIView alloc] init];
        _line.backgroundColor = KCOLORGREEN_009688;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.subviews[0]);
            make.height.mas_equalTo(2);
        }];
        
    }
    return self;
}
- (void)changedState:(ChangeSwitchState)state {
    _changeStateBlock = state;
}
- (void)onClick:(UITapGestureRecognizer *)tap {
    int newIndex = (int)tap.view.tag - KLABELTAG;
    if (newIndex != _index) {
        [self.subviews[_index] setTextColor:KCOLORWHITE_696969];
        [self.subviews[newIndex] setTextColor:KCOLORGREEN_009688];
        [UIView animateWithDuration:0.3 animations:^{
            [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self.subviews[newIndex]);
                make.height.mas_equalTo(2);
            }];
            [_line layoutIfNeeded];
        }];
        _index = newIndex;
        if (_changeStateBlock) {
            _changeStateBlock(_index);
        }
    }
}
@end
