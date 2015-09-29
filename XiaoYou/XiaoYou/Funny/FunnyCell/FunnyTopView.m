//
//  FunnyTopView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FunnyTopView.h"

#define HEADIMAGEVIEW_WIDTH         SCALE_NUM(50)
#define LEADINGOFF_HEADIMAGEVIEW    SCALE_NUM(10)
@interface FunnyTopView ()
@property (nonatomic,strong) UIImageView    *headImageView; //公告图
@property (nonatomic,strong) UIView         *sepLineView;   //分割线
@property (nonatomic,strong) UILabel        *nameLabel;     //名称
@property (nonatomic,strong) UILabel        *descriptionLabel;//描述,只显示一行；

@property (nonatomic,strong) UILabel        *staticNameLabel;//静态name
@property (nonatomic,strong) UILabel        *staticDesLabel;
@end

@implementation FunnyTopView

-(instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView {
    _headImageView = [[UIImageView alloc]init];
    [self addSubview:_headImageView];
    _headImageView.image = [UIImage imageNamed:@"default_head"];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(HEADIMAGEVIEW_WIDTH);
        make.height.mas_equalTo(HEADIMAGEVIEW_WIDTH);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"校级活动公告";
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(LEADINGOFF_HEADIMAGEVIEW);
        make.centerY.equalTo(_headImageView.mas_centerY);
    }];
    
    
    _sepLineView = [[UIView alloc]init];
    _sepLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_sepLineView];
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom).offset(10);
        make.left.equalTo(_titleLabel);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _staticNameLabel = [[UILabel alloc]init];
    [self addSubview:_staticNameLabel];
    _staticNameLabel.text = @"名称:";
    [_staticNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sepLineView.mas_bottom).offset(10);
        make.leading.mas_equalTo(30);
    }];
    
    _nameLabel = [[UILabel alloc]init];
    [self addSubview:_nameLabel];
    _nameLabel.text = @"校级舞蹈大赛";
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_staticNameLabel);
    }];
    
    _staticDesLabel = [[UILabel alloc]init];
    [self addSubview:_staticDesLabel];
    _staticDesLabel.text = @"描述:";
    [_staticDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.equalTo(_staticNameLabel);
    }];
    
    _descriptionLabel = [[UILabel alloc]init];
    _descriptionLabel.numberOfLines = 1;
    _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:_descriptionLabel];
    _descriptionLabel.text = @"清华大学舞蹈大赛于清华大学舞蹈大赛于清华大学舞蹈大赛于清华大学舞蹈大赛于清华大学舞蹈大赛于";
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.trailing.mas_equalTo(5);
        make.top.equalTo(_staticDesLabel);
    }];
}


@end
