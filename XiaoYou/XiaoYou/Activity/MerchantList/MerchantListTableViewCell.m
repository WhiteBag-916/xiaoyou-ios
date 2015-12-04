//
//  MerchantListTableViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MerchantListTableViewCell.h"
#import "SupplierShopModel.h"
#import "SupplierShopDiscounts.h"

NSString *const kMerchantListTableViewCell = @"MerchantListTableViewCellId";

@interface MerchantListTableViewCell ()

@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * characterLabel;//特点
@property(nonatomic,strong)UILabel * placeLabel;
@property(nonatomic,strong)UILabel * comboLabel;//专属优惠套餐
@property(nonatomic,strong)UILabel * scanfLabel;//第二杯半价

@end

@implementation MerchantListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.headImageView = [YUtils initImageViewWithBackgroundColor:[UIColor clearColor]
                                                     cornerRadius:4
                                                    clipsToBounds:YES
                                                            image:nil];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(15));
        make.left.mas_equalTo(SCALE_NUM(15));
        make.width.height.mas_equalTo(SCALE_NUM(50));
    }];
    
    self.nameLabel = [YUtils initLabel:CONTENT_FONT(SCALE_NUM(14))
                                 color:[UIColor hexChangeFloat:@"333333"]
                                  text:@""];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(SCALE_NUM(15));
        make.top.equalTo(_headImageView);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(14));
    }];
    
    self.characterLabel = [YUtils initLabel:CONTENT_FONT(SCALE_NUM(10))
                                      color:KCOLOR_B5
                                       text:@""];
    [self.contentView addSubview:_characterLabel];
    [_characterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(11));
    }];
    
    self.placeLabel = [YUtils initLabel:CONTENT_FONT(SCALE_NUM(11))
                                  color:[UIColor hexChangeFloat:@"666666"]
                                   text:@""];
    [self.contentView addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_characterLabel);
        make.top.equalTo(_characterLabel.mas_bottom).offset(15);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(11));
    }];
    
    self.comboLabel = [YUtils initLabel:CONTENT_FONT(SCALE_NUM(11))
                                  color:[UIColor hexChangeFloat:@"666666"]
                                   text:@""];
    [self.contentView addSubview:_comboLabel];
    [_comboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_characterLabel);
        make.top.equalTo(_placeLabel.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(11));
    }];
    
    self.scanfLabel = [YUtils initLabel:CONTENT_FONT(SCALE_NUM(11))
                                  color:[UIColor hexChangeFloat:@"666666"]
                                   text:@""];
    [self.contentView addSubview:_scanfLabel];
    [_scanfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_characterLabel);
        make.top.equalTo(_comboLabel.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(11));
    }];
    
}

-(void)setCellData:(ShopList *) model
{
    SupplierShopModel * shopModel = model.supplierShopModel;
    
    _nameLabel.text = shopModel.name;
    [_headImageView setNormalImageWithUrl:shopModel.shopLogoUrl];
    _characterLabel.text = shopModel.tags;
    _placeLabel.text = shopModel.address;
    
    if (model.supplierShopDiscounts.count > 1)
    {
        SupplierShopDiscounts * shopDiscount1 = model.supplierShopDiscounts[0];
        _comboLabel.text = shopDiscount1.discountDetail;
        SupplierShopDiscounts * shopDiscount2 = model.supplierShopDiscounts[1];
        _scanfLabel.text = shopDiscount2.discountDetail;
    }
    else if(model.supplierShopDiscounts.count > 0)
    {
        SupplierShopDiscounts * shopDiscount1 = model.supplierShopDiscounts[0];
        _comboLabel.text = shopDiscount1.discountDetail;
    }
    else
    {
        return;
    }
   
}

- (BOOL)needLine
{
    return YES;
}

@end
