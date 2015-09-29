//
//  FunnyBottomView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FunnyBottomView.h"

@interface FunnyBottomView ()

@property (nonatomic,strong) UILabel        *seeMoreLable;
@property (nonatomic,strong) UIImageView    *seeMoreImageView;

@end

@implementation FunnyBottomView


-(instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView {
    _seeMoreLable = [[UILabel alloc]init];
    [self addSubview:_seeMoreLable];
    _seeMoreLable.text = @"see more";
    [_seeMoreLable setTextColor:[UIColor greenColor]];
    [_seeMoreLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.leading.mas_equalTo(SCALE_NUM(70));
    }];
    
    _seeMoreImageView = [[UIImageView alloc]init];
    [self addSubview:_seeMoreImageView];
    _seeMoreImageView.image = [UIImage imageNamed:@"too_see_more_arrow"];
    [_seeMoreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_seeMoreLable.mas_centerY);
        make.trailing.mas_equalTo(-20);
    }];
}

@end
