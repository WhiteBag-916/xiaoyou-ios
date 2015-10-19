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
    //背景View
    _backView = [[UIView alloc] init];
    _backView.layer.cornerRadius = 4;
    _backView.clipsToBounds = YES;
    _backView.backgroundColor = KCOLORGREEN_B1;
    _backView.layer.borderWidth = 1;
    _backView.layer.borderColor = KCOLORGREEN_B2.CGColor;
    _backView.alpha = 0.8;
    [self.contentView addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(SCALE_NUM(5));
        make.right.mas_equalTo(SCALE_NUM(-5));
    }];
    //顶部绿色长条
    UIImageView * topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"img_top"];
    [_backView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(6));
    }];
    //中部虚线
    UIImageView * lineImageView = [[UIImageView alloc] init];
    lineImageView.image = [UIImage imageNamed:@"img_line"];
    [_backView addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(SCALE_NUM(63));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(10));
    }];
    //数字
    _numImageView = [[UIImageView alloc] init];
    [_backView addSubview:_numImageView];
    [_numImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(12));
        make.top.mas_equalTo(SCALE_NUM(22));
        make.height.width.mas_equalTo(SCALE_NUM(34));
    }];
    //类型名称
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.textColor = KCOLORGREEN_g1;
    _typeLabel.font = CONTENT_FONT(17);
    _typeLabel.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numImageView.mas_right);
        make.bottom.equalTo(_numImageView);
        make.height.mas_equalTo(SCALE_NUM(20));
        make.width.mas_equalTo(SCALE_NUM(200));
    }];
}

@end
