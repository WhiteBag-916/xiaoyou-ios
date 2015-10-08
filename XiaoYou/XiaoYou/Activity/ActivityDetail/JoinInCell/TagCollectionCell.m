//
//  TagCollectionCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TagCollectionCell.h"
@interface TagCollectionCell ()
@property (nonatomic,strong) UILabel *tagLabel;
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
    _tagLabel.text = @"互联网公司";
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


@end
