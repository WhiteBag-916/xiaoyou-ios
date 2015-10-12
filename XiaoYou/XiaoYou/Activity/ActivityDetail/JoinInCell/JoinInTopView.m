//
//  JoinInTopView.m
//  XiaoYou
//
//  Created by sheng on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#define HEADIMAGE_LEADING   SCALE_NUM(12)
#define HEAD_IMAGE_SIZE     SCALE_NUM(45)
#define NAME_LEADING        SCALE_NUM(14)
#import "JoinInTopView.h"

@interface JoinInTopView ()

@property (nonatomic,strong) UIImageView    *headImageView;
@property (nonatomic,strong) UILabel        *nameLabel;
@property (nonatomic,strong) UIImageView    *genderImageView;
@property (nonatomic,strong) UIImageView    *addFriendImageView;

@end

@implementation JoinInTopView


-(instancetype)init
{
    if (self = [super init]) {
        [self initView];
    }
    return self;
}


-(void)initView
{
    _headImageView = [[UIImageView alloc]init];
    [self addSubview:_headImageView];
    _headImageView.image = [UIImage imageNamed:@"chatBar_face"];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(HEADIMAGE_LEADING);
        make.top.mas_equalTo(HEADIMAGE_LEADING);
        make.width.mas_equalTo(HEAD_IMAGE_SIZE);
        make.height.mas_equalTo(HEAD_IMAGE_SIZE);
    }];
    
    _nameLabel = [[UILabel alloc]init];
    [self addSubview:_nameLabel];
    _nameLabel.text = @"刘雨欣";
    _nameLabel.font = [UIFont systemFontOfSize:SCALE_NUM(14)];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headImageView.centerY);
        make.left.equalTo(_headImageView.mas_right).offset(NAME_LEADING);
    }];
    
    _genderImageView = [[UIImageView alloc]init];
    [self addSubview:_genderImageView];
    _genderImageView.image = [UIImage imageNamed:@"funny_detail_boy"];
    [_genderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(SCALE_NUM(10));
        make.centerY.equalTo(_nameLabel.mas_centerY);
    }];
    
    _addFriendImageView = [[UIImageView alloc]init];
    [self addSubview:_addFriendImageView];
    _addFriendImageView.image = [UIImage imageNamed:@"mine-add-friend"];
    [_addFriendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.top.equalTo(_headImageView.mas_top).offset(SCALE_NUM(2));
    }];
}


@end
