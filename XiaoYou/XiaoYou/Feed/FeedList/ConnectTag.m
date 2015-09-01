


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
#import "Tags.h"

#define KMARGIN 6
#define KTAGSIZE 14

#define KTAG 10000
@implementation ConnectTag

- (id)init {
    self = [super init];
    if (self) {
        for (int i = 0; i < 5; i++) {
            UILabel *label = [YUtils initLabel:CONTENT_FONT(10) color:KCOLORWHITE text:@"" frame:CGRectZero alignment:NSTextAlignmentCenter];
            [self addSubview:label];
            label.tag = KTAG + i;
            label.backgroundColor = KCOLORGREEN_009688;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.width.height.mas_equalTo(KTAGSIZE);
                if (i == 0) {
                    make.right.equalTo(self);
                } else {
                    make.right.equalTo([[self viewWithTag:KTAG+i-1] mas_left]).offset(-KMARGIN);
                }
            }];
        }
        [self updateSize:5];
    }
    return self;
}


- (void)updateWithTag:(NSArray *)tags {
    int index;
    int count = tags.count>5?5:(int)tags.count;
    for (index = 0; index < count; index ++) {
        UILabel *label = (UILabel *)[self viewWithTag:KTAG+index];
        label.hidden = false;
        label.text = [tags[index] name];
    }
//    while (index <= 4) {
//        [[self viewWithTag:KTAG+index] setHidden:true];
//        index ++;
//    }
    
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
    self.backgroundColor = [UIColor redColor];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.right.equalTo([self viewWithTag:KTAG]);
    }];
}

@end
