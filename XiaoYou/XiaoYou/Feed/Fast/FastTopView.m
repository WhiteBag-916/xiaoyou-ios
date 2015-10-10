//
//  TopView.m
//  XiaoYou
//
//  Created by sheng on 15/9/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FastTopView.h"
@interface FastTopView ()

@property (nonatomic,retain) UILabel        *nameLabel;
@property (nonatomic,retain) UIImageView    *genderImageView;
@property (nonatomic,retain) UIImageView    *photoImageView;

@end

@implementation FastTopView

-(instancetype)init
{
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    _photoImageView = [[UIImageView alloc]init];
    [self addSubview:_photoImageView];
    _photoImageView.image = [UIImage imageNamed:@"background-start-6"];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _genderImageView = [[UIImageView alloc]init];
    [self addSubview:_genderImageView];
    [_genderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(20);
        make.top.mas_equalTo(22);
    }];
    _nameLabel = [[UILabel alloc]init];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_genderImageView);
        make.left.equalTo(_genderImageView.mas_right).offset(5);
    }];
}

+(FastTopView *)topView
{
    FastTopView *topView = [[FastTopView alloc]init];
    return topView;
}
@end
