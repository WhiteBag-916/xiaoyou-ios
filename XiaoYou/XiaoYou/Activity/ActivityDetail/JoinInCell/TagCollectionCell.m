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
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.textColor = [UIColor whiteColor];
    _tagLabel.backgroundColor = [UIColor hexChangeFloat:@"009f92"];
    _tagLabel.layer.cornerRadius = 2;
    _tagLabel.clipsToBounds = YES;
    _tagLabel.font = CONTENT_FONT(10);
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

-(void)setCellInfo:(Tags *) tag
{
    _tagLabel.text = tag.name;
    if (tag.equal)
    {
         _tagLabel.backgroundColor = [UIColor hexChangeFloat:@"009f92"];
    }
    else
    {
        _tagLabel.backgroundColor = [UIColor hexChangeFloat:@"95d5d0"];
    }
}

@end
