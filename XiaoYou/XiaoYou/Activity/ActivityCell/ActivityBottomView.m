//
//  FunnyBottomView.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityBottomView.h"

@interface ActivityBottomView ()

@property (nonatomic,strong) UILabel        *seeMoreLable;
@property (nonatomic,strong) UIImageView    *seeMoreImageView;

@end

@implementation ActivityBottomView


-(instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView {
    _seeMoreLable = [[UILabel alloc]init];
    [self addSubview:_seeMoreLable];
    _seeMoreLable.font = CONTENT_FONT(14);
    _seeMoreLable.text = @"see more";
    [_seeMoreLable setTextColor:[UIColor colorWithRed:16/255.0 green:86/255.0 blue:136/255.0 alpha:1]];
    [_seeMoreLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
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
