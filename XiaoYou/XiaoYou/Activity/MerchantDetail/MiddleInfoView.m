//
//  MiddleInfoView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MiddleInfoView.h"
#import "SupplierShopModel.h"

@interface MiddleInfoView ()<UIAlertViewDelegate>

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
    _houseImageView = [[UIImageView alloc] init];
    _houseImageView.backgroundColor = [UIColor clearColor];
    _houseImageView.image = [UIImage imageNamed:@"scanf_code_house"];
    [self addSubview:_houseImageView];
    [_houseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(SCALE_NUM(20));
        make.width.mas_equalTo(SCALE_NUM(25));
        make.height.mas_equalTo(SCALE_NUM(23));
    }];
    
    _houseLabel = [[UILabel alloc] init];
    _houseLabel.text = _model.supplierShopModel.name;
    _houseLabel.font = CONTENT_FONT(SCALE_NUM(12));
    _houseLabel.textColor = KCOLOR_B3;
    _houseLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_houseLabel];
    [_houseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_houseImageView);
        make.left.equalTo(_houseImageView.mas_right).offset(SCALE_NUM(15));
        make.trailing.mas_equalTo(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    //电话
    _phoneImageView = [[UIImageView alloc] init];
    _phoneImageView.backgroundColor = [UIColor clearColor];
    _phoneImageView.image = [UIImage imageNamed:@"scanf_code_phone"];
    [self addSubview:_phoneImageView];
    [_phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_houseImageView);
        make.top.equalTo(_houseImageView.mas_bottom).offset(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(20));
        make.height.mas_equalTo(SCALE_NUM(21));
    }];
    
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.text = _model.supplierShopModel.telephone;
    _phoneLabel.font = CONTENT_FONT(SCALE_NUM(12));
    _phoneLabel.textColor = KCOLOR_g1;
    _phoneLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_phoneImageView);
        make.left.right.equalTo(_houseLabel);
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    UIButton * phoneButton = [[UIButton alloc] init];
    phoneButton.backgroundColor = [UIColor clearColor];
    [self addSubview:phoneButton];
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_phoneLabel);
        make.left.top.bottom.equalTo(_phoneImageView);
    }];
    [phoneButton addTarget:self action:@selector(callPhoneNum) forControlEvents:UIControlEventTouchUpInside];
    
    //位置
    _placeImageView = [[UIImageView alloc] init];
    _placeImageView.backgroundColor = [UIColor clearColor];
    _placeImageView.image = [UIImage imageNamed:@"scanf_code_place"];
    [self addSubview:_placeImageView];
    [_placeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_houseImageView);
        make.top.equalTo(_phoneImageView.mas_bottom).offset(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(18));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.text = _model.supplierShopModel.address;
    _placeLabel.font = CONTENT_FONT(SCALE_NUM(12));
    _placeLabel.textColor = KCOLOR_B3;
    _placeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_placeImageView);
        make.left.right.equalTo(_houseLabel);
        make.height.mas_equalTo(SCALE_NUM(12));
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
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:_phoneLabel.text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString * phoneStr = [NSString stringWithFormat:@"tel://%@",_phoneLabel.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
    }
    else
    {
        return;
    }
}

@end
