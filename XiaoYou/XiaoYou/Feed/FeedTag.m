//
//  FeedTag.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedTag.h"

#define KLABELHEIGHT SCALE_NUM(10)

@interface FeedTag()

@property (nonatomic, strong, readwrite) UIImageView *tagIcon;                 //tag图标

@property (nonatomic, strong, readwrite) UIView *tagContent;                   //tag标签

@end

@implementation FeedTag

- (id)init {
    self = [super init];
    if (self) {
        _tagIcon = [[UIImageView alloc] init];
        [self addSubview:_tagIcon];
        [_tagIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_NUM(11));
            make.height.mas_equalTo(SCALE_NUM(14));
            make.left.top.equalTo(self);
        }];
        
        _tagContent = [[UIView alloc] init];
        [self addSubview:_tagContent];
        [_tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tagIcon.mas_centerY).offset(-KLABELHEIGHT/2);
            make.right.bottom.equalTo(self);
        }];
    }
    return self;
}


- (void)setData {
    for (int i = 0; i < _tagContent.subviews.count; i++) {
        [_tagContent.subviews[i] removeFromSuperview];
    }
    
    NSArray *labelName = @[@"金融", @"留学咨询", @"学校生活", @"工作", @"互联网信息"];
    
}
@end
