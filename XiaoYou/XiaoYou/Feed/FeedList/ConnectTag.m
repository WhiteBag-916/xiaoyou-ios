


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

@implementation ConnectTag

- (id)init {
    self = [super init];
    if (self) {
        for (int i = 0; i < 5; i++) {
            UILabel *label = [YUtils initLabel:CONTENT_FONT(10) color:KCOLORWHITE text:@"" frame:CGRectZero alignment:NSTextAlignmentCenter];
            [self addSubview:label];
            label.backgroundColor = KCOLORGREEN_009688;
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
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo([self.subviews[4] mas_left]);
        }];
    }
    return self;
}


- (void)updateTag:(NSArray *)tags {
    int index;
    for (index = 0; index < tags.count; index ++) {
        UILabel *label = (UILabel *)self.subviews[index];
        label.hidden = false;
        label.text = tags[index];
    }
    while (index <= 4) {
        [self.subviews[index] setHidden:true];
        index ++;
    }
}

@end
