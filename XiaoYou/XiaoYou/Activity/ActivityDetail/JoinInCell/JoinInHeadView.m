//
//  JoinInHeadView.m
//  XiaoYou
//
//  Created by sheng on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#define POINT_LEADING   SCALE_NUM(12)
#define FONT_SIZE       SCALE_NUM(14)
#define DES_LEADING     SCALE_NUM(6)
#import "JoinInHeadView.h"

@interface JoinInHeadView ()

@property (nonatomic,strong) UIImageView    *pointImageView;    //提示点
@property (nonatomic,strong) UILabel        *desLabel;          //描述

@end

@implementation JoinInHeadView

-(instancetype)init
{
    if (self = [super init]) {
        [self initView];
    }
    return self;
}


-(void)initView
{
    _pointImageView = [[UIImageView alloc]init];
    [self addSubview:_pointImageView];
    _pointImageView.image = [UIImage imageNamed:@"funny_detail_circle"];
    [_pointImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(POINT_LEADING);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _desLabel = [[UILabel alloc]init];
    [self addSubview:_desLabel];
    _desLabel.text = @"来参加此次活动的朋友们:";
    _desLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_pointImageView.mas_right).offset(DES_LEADING);
        make.centerY.equalTo(_pointImageView.mas_centerY);
    }];
}

//清空内容;
-(void)clearContent
{
    _pointImageView.image = nil;
    _desLabel.text = @"";
}

@end
