//
//  FunnyTopView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityTopView.h"

#define HEADIMAGEVIEW_WIDTH         SCALE_NUM(45)
#define LEADINGOFF_HEADIMAGEVIEW    SCALE_NUM(12)
@interface ActivityTopView ()



@end

@implementation ActivityTopView

-(instancetype)init {
    if (self = [super init]) {
        [self initViewWithType:SHORT_BRIEF];
    }
    return self;
}

-(instancetype)initWithType:(TOPVIEWTYPE)viewType {
    if (self = [super init]) {
        [self initViewWithType:viewType];
    }
    return self;
}

-(void)initViewWithType:(TOPVIEWTYPE)type {
    _headImageView = [[UIImageView alloc]init];
    [self addSubview:_headImageView];
    _headImageView.layer.cornerRadius = HEADIMAGEVIEW_WIDTH/2.0;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.image = [UIImage imageNamed:@"default_head"];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(12);
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(HEADIMAGEVIEW_WIDTH);
        make.height.mas_equalTo(HEADIMAGEVIEW_WIDTH);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"校级活动公告";
    [self addSubview:_titleLabel];
    _titleLabel.font = CONTENT_FONT(15);
    _titleLabel.textColor = KCOLORGREEN_B4;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.left.equalTo(_headImageView.mas_right).offset(12);
        make.centerY.equalTo(_headImageView.mas_centerY);
    }];
    
    
    _sepLineView = [[UIView alloc]init];
    _sepLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_sepLineView];
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom).offset(12);
        make.left.equalTo(_titleLabel);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _staticNameLabel = [[UILabel alloc]init];
    [self addSubview:_staticNameLabel];
    _staticNameLabel.font = CONTENT_FONT(13);
    _staticNameLabel.text = @"名称:";
    [_staticNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.height.mas_equalTo(SCALE_NUM(13));
        make.top.equalTo(_sepLineView.mas_bottom).offset(15);
        make.leading.mas_equalTo(22);
    }];
    
    _nameLabel = [[UILabel alloc]init];
    [self addSubview:_nameLabel];
    _nameLabel.font = CONTENT_FONT(13);
    _nameLabel.numberOfLines = 0;
    _nameLabel.text = @"大型历史音乐剧《和平使者——抗战中的宋庆龄》";
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_staticNameLabel);
        make.trailing.mas_equalTo(-12);
    }];
    
    _staticDesLabel = [[UILabel alloc]init];
    [self addSubview:_staticDesLabel];
    _staticDesLabel.font = CONTENT_FONT(13);
    _staticDesLabel.text = @"简介:";
    [_staticDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.height.mas_equalTo(SCALE_NUM(13));
        make.top.equalTo(_nameLabel.mas_bottom).offset(15);
        make.left.equalTo(_staticNameLabel);
    }];
    
    _descriptionLabel = [[UILabel alloc]init];
    _descriptionLabel.font = CONTENT_FONT(13);
    _descriptionLabel.textColor = KCOLORGREEN_B3;
    if (type == DETAIL_INFO) {
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    } else {
        _descriptionLabel.numberOfLines = 1;
        _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    [self addSubview:_descriptionLabel];
    NSString *textString = @"本剧讲述了在日寇荼毒神州大地的悲壮年代，宋庆龄从中华民族的大局利益出发，积极投身抗日救亡的运动中。 从1932年1月，侵华日军突袭上海，第一次“淞沪抗战“爆发，宋庆龄亲赴前线慰问十九路军官兵；到促使“西安事变”和平解决，全国上下团结抗日局面的形成；再到香港组建“保卫中国同盟”募集物资支援抗战，参加广州火炬大游行；最后为巩固抗日统一战线，宋氏三姐妹赴重庆视察，并向世界发表广播演讲为主线。充分展示了宋庆龄在国家动荡之时，在民族危难之际，所体现出伟大的爱国主义、民主主义精神！塑造了一个“柔肩担道义、正气盈天地”的伟大女性。";
    [_descriptionLabel setText:textString lineSpacing:10.f];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.trailing.mas_equalTo(-12);
        make.top.equalTo(_staticDesLabel);
    }];
}


@end
