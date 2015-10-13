//
//  ActivityBaseCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityBaseCollectionViewCell.h"

@interface ActivityBaseCollectionViewCell ()

@end

@implementation ActivityBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    _backView = [[UIView alloc] init];
    _backView.layer.cornerRadius = 4;
    _backView.clipsToBounds = YES;
    _backView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    UIImageView * topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"img_top"];
    [_backView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(6);
    }];
    
    UIImageView * lineImageView = [[UIImageView alloc] init];
    lineImageView.image = [UIImage imageNamed:@"img_line"];
    [_backView addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(63);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    _numImageView = [[UIImageView alloc] init];
    _numImageView.image = [UIImage imageNamed:@"img_num1"];
    [_backView addSubview:_numImageView];
    [_numImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(22);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(34);
    }];
    
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.textColor = KCOLORGREEN_g1;
    _typeLabel.font = CONTENT_FONT(20);
    _typeLabel.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numImageView.mas_right);
        make.bottom.equalTo(_numImageView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
}

@end
