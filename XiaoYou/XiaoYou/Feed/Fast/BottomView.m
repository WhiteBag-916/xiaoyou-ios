
//
//  BottomView.m
//  XiaoYou
//
//  Created by sheng on 15/9/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "BottomView.h"
#import "ConnectTag.h"

#define TOPVIEW_HEIGHT      SCALE_NUM(44)
#define MIDDLEVIEW_HEIGHT   SCALE_NUM(56)
#define BOTTOMVIEW_HEIGHT   SCALE_NUM(44)

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
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
    }];
}

-(void)initBottomView {
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(MIDDLEVIEW_HEIGHT);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
    }];
}

-(void)initMiddleView {
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BOTTOMVIEW_HEIGHT);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
    }];
}


//使用懒加载方式加载View
-(UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
        [self addSubview:_topView];
        _topView.backgroundColor = [UIColor lightGrayColor];
        

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



@interface InnerTopView ()
@property (nonatomic,strong) UILabel    *contactLabel;
//关系标签
@property (nonatomic,strong) ConnectTag *connectTagList;
@end
@implementation InnerTopView

-(instancetype)init
{
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    _contactLabel = [[UILabel alloc]init];
    [self addSubview:_contactLabel];
    _contactLabel.text = @"人脉标签";
    _contactLabel.font = [UIFont systemFontOfSize:12];
    [_contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(14);
        make.top.mas_equalTo(16);
    }];
    
    _connectTagList = [[ConnectTag alloc]init];
    [self addSubview:_connectTagList];
    [_connectTagList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(14);
    }];
    
    [_connectTagList updateWithTag:@[@"班",@"社",@"乡"]];
}

@end

@interface InnerMiddleView ()

@end
@implementation InnerMiddleView



@end


@interface InnerBottomView ()
@property (nonatomic,strong) UIImageView *toastImageView;   //敬酒图片
@property (nonatomic,strong) UILabel    *toastCountLabel;
@end

@implementation InnerBottomView

-(instancetype)init
{
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView
{
    _toastImageView = [[UIImageView alloc]init];
    [self addSubview:_toastImageView];
    _toastImageView.image = [UIImage imageNamed:@"cup"];
    [_toastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(13);
    }];
    
    _toastCountLabel = [[UILabel alloc]init];
    [self addSubview:_toastCountLabel];
    _toastCountLabel.text = @"1299";
    [_toastCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_toastImageView.mas_right).offset(15);
        make.centerY.mas_equalTo(_toastImageView.mas_centerY);
    }];
}

@end