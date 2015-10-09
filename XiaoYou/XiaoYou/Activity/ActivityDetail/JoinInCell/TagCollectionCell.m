//
//  TagCollectionCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TagCollectionCell.h"
@interface TagCollectionCell ()

@end
@implementation TagCollectionCell

-(instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

-(void)initView {
    _tagLabel = [[UILabel alloc]init];
    [self addSubview:_tagLabel];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.font = CONTENT_FONT(10);
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


@end
