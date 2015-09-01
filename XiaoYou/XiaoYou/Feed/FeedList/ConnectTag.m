


//
//  ConnectTag.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ConnectTag.h"
#import "YUtils+Component.h"
#import "Masonry.h"

#define KMARGIN 6
#define KTAGSIZE 14

#define KTAG 10000
@implementation ConnectTag

- (id)init {
    self = [super init];
    if (self) {
        [self updateSize:0];
    }
    return self;
}


- (void)updateWithTag:(NSArray *)tags {
    [self removeAllSubviews];
    int count = tags.count>5?5:(int)tags.count;
    for (int i = 0; i < count; i++) {
        UILabel *label = [YUtils initLabel:CONTENT_FONT(10) color:KCOLORWHITE text:@"" frame:CGRectZero alignment:NSTextAlignmentCenter];
        [self addSubview:label];
        label.backgroundColor = KCOLORGREEN_009688;
        label.text = [tags[i] name];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.height.mas_equalTo(KTAGSIZE);
            if (i == 0) {
                make.right.equalTo(self);
            } else {
                make.right.equalTo([self.subviews[i-1] mas_left]).offset(-KMARGIN);
            }
        }];
    }
    
    [self updateSize:count];
}
- (void)updateSize:(int)count {
    float width = 0;
    if (count != 0) {
        self.hidden = false;
        width = (count-1)*(KTAGSIZE+KMARGIN)+KTAGSIZE;
    } else {
        self.hidden = true;
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
}

@end
