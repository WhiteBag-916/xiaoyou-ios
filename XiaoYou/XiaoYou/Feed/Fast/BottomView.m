
//
//  BottomView.m
//  XiaoYou
//
//  Created by sheng on 15/9/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BottomView.h"

#define TOPVIEW_HEIGHT      SCALE_NUM(100)
#define MIDDLEVIEW_HEIGHT   SCALE_NUM(100)
#define BOTTOMVIEW_HEIGHT   SCALE_NUM(100)

@interface BottomView ()

@property (nonatomic, retain) UIView* topView;
@property (nonatomic, retain) UIView* bottomView;
@property (nonatomic, retain) UIView* middleView;

@end

@implementation BottomView

-(instancetype)init
{
    if (self = [super init]) {
        [self initTopView];
        [self initMiddleView];
        [self initBottomView];
    }
    return self;
}

-(void)initTopView {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(TOPVIEW_HEIGHT);
        
        make.leading.mas_equalTo(@0);
        make.trailing.mas_equalTo(@0);
    }];
}

-(void)initBottomView {
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(MIDDLEVIEW_HEIGHT);
        make.leading.mas_equalTo(@0);
        make.trailing.mas_equalTo(@0);
    }];
}

-(void)initMiddleView {
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BOTTOMVIEW_HEIGHT);
        make.leading.mas_equalTo(@0);
        make.trailing.mas_equalTo(@0);
    }];
}


//使用懒加载方式加载View
-(UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:_topView];
    }
    return _topView;
}

-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        [self addSubview:_bottomView];
    }
    return _bottomView;
}

-(UIView *)middleView {
    if (!_middleView) {
        _middleView.backgroundColor = [UIColor redColor];
        _middleView = [[UIView alloc]init];
        [self addSubview:_middleView];
    }
    return _middleView;
}

@end
