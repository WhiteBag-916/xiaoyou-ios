//
//  FastBottomView.m
//  XiaoYou
//
//  Created by sheng on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FastBottomView.h"

@interface FastBottomView ()

@property (nonatomic,strong) UIImageView *nextImageView;
@property (nonatomic,strong) UIImageView *addFriendImageView;

@end

@implementation FastBottomView

-(instancetype)init
{
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    _nextImageView = [[UIImageView alloc]init];
    [self addSubview:_nextImageView];
    [_nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    _addFriendImageView = [[UIImageView alloc]init];
    [self addSubview:_addFriendImageView];
    [_addFriendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nextImageView.mas_right).offset(10);
        make.top.equalTo(_nextImageView.mas_top);
    }];
}

@end
