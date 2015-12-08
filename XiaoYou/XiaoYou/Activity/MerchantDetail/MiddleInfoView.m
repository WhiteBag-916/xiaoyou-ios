//
//  MiddleInfoView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MiddleInfoView.h"
#import "SupplierShopModel.h"

@interface MiddleInfoView ()
<UIAlertViewDelegate>

@property(nonatomic,strong)UIImageView * houseImageView;
@property(nonatomic,strong)UILabel * houseLabel;

@property(nonatomic,strong)UIImageView * phoneImageView;
@property(nonatomic,strong)UILabel * phoneLabel;

@property(nonatomic,strong)UIImageView * placeImageView;
@property(nonatomic,strong)UILabel * placeLabel;

@property(nonatomic,strong)ShopList * model;

@end

@implementation MiddleInfoView

- (instancetype)initWithModel:(ShopList *) model
{
    self = [super init];
    if (self) {
        
        _model = model;
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    //房子
    self.houseImageView = [YUtils initImageViewWithImageName:@"scanf_code_house"];
    [self addSubview:_houseImageView];
    [_houseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(24));
        make.left.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(11));
        make.height.mas_equalTo(SCALE_NUM(11));
    }];
    
    _houseLabel = [YUtils initLabelWithBackgroundColor:[UIColor clearColor]
                                                  font:CONTENT_FONT(SCALE_NUM(12))
                                         numberOfLines:1
                                         textAlignment:NSTextAlignmentLeft
                                             textColor:KCOLOR_B3
                                                  text:_model.supplierShopModel.name];
    [self addSubview:_houseLabel];
    [_houseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_houseImageView);
        make.left.equalTo(_houseImageView.mas_right).offset(SCALE_NUM(12));
        make.trailing.mas_equalTo(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    //电话
    _phoneImageView = [YUtils initImageViewWithImageName:@"scanf_code_phone"];
    _phoneImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_phoneImageView];
    [_phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_houseImageView);
        make.top.equalTo(_houseImageView.mas_bottom).offset(SCALE_NUM(24));
        make.width.mas_equalTo(SCALE_NUM(10));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    _phoneLabel = [YUtils initLabelWithBackgroundColor:[UIColor clearColor]
                                                  font:CONTENT_FONT(SCALE_NUM(12))
                                         numberOfLines:1
                                         textAlignment:NSTextAlignmentLeft
                                             textColor:KCOLOR_g1
                                                  text:_model.supplierShopModel.telephone];
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_phoneImageView);
        make.left.right.equalTo(_houseLabel);
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    UIButton * phoneButton = [YUtils initButtonWithBackgroundColor:[UIColor clearColor]
                                                            target:self
                                                            action:@selector(callPhoneNum)];
    [self addSubview:phoneButton];
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_phoneLabel);
        make.left.top.bottom.equalTo(_phoneImageView);
    }];
    //位置
    _placeImageView = [YUtils initImageViewWithImageName:@"scanf_code_place"];
    [self addSubview:_placeImageView];
    [_placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_houseImageView);
        make.top.equalTo(_phoneImageView.mas_bottom).offset(SCALE_NUM(24));
        make.width.mas_equalTo(SCALE_NUM(9));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    _placeLabel = [YUtils initLabelWithBackgroundColor:[UIColor clearColor]
                                                  font:CONTENT_FONT(SCALE_NUM(12))
                                         numberOfLines:0
                                         textAlignment:NSTextAlignmentLeft
                                             textColor:KCOLOR_B3
                                                  text:_model.supplierShopModel.address];
    [self addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_placeImageView);
        make.left.right.equalTo(_houseLabel);
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    //分割线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = KCOLOR_B5;
    [self addSubview:bottomLine];
    [bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(0.5));
    }];
    
}

-(void)callPhoneNum
{
    [YAnalysis trackEvent:@"商家电话" withPara:nil];
    UIAlertView * alertView = [[UIAlertView alloc]
                               initWithTitle:nil
                               message:_phoneLabel.text delegate:self
                               cancelButtonTitle:@"取消"
                               otherButtonTitles:@"拨打", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [YAnalysis trackEvent:@"确定_商家电话" withPara:@{@"商家":_model.supplierShopModel.name}];
        NSString * phoneStr = [NSString stringWithFormat:@"tel://%@",_phoneLabel.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
    }
    else
    {
        [YAnalysis trackEvent:@"取消_商家电话" withPara:nil];
        return;
    }
}

@end
