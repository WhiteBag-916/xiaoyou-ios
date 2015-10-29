//
//  MerchantListTableViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MerchantListTableViewCell.h"

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
    _headImageView = [[UIImageView alloc] init];
    _headImageView.backgroundColor = [UIColor orangeColor];
    _headImageView.layer.cornerRadius = 4;
    _headImageView.clipsToBounds = YES;
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(15));
        make.left.mas_equalTo(SCALE_NUM(15));
        make.width.height.mas_equalTo(SCALE_NUM(105));
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = CONTENT_FONT(15);
    _nameLabel.text = @"Zoo Coffee";
    _nameLabel.textColor = [UIColor hexChangeFloat:@"333333"];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(SCALE_NUM(15));
        make.top.equalTo(_headImageView);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(15));
    }];
    
    _characterLabel = [[UILabel alloc] init];
    _characterLabel.backgroundColor = [UIColor clearColor];
    _characterLabel.font = CONTENT_FONT(10);
    _characterLabel.text = @"咖啡  西点  空间大";
    _characterLabel.textColor = [UIColor hexChangeFloat:@"666666"];
    [self.contentView addSubview:_characterLabel];
    [_characterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(10));
    }];
    
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.backgroundColor = [UIColor clearColor];
    _placeLabel.font = CONTENT_FONT(10);
    _placeLabel.text = @"和平区西湖道风荷园1-4-20";
    _placeLabel.textColor = [UIColor hexChangeFloat:@"666666"];
    [self.contentView addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_characterLabel);
        make.top.equalTo(_characterLabel.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(10));
    }];
    
    _comboLabel = [[UILabel alloc] init];
    _comboLabel.backgroundColor = [UIColor clearColor];
    _comboLabel.font = CONTENT_FONT(10);
    _comboLabel.text = @"专属优惠套餐";
    _comboLabel.textColor = [UIColor hexChangeFloat:@"666666"];
    [self.contentView addSubview:_comboLabel];
    [_comboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_characterLabel);
        make.top.equalTo(_placeLabel.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(10));
    }];
    
    _scanfLabel = [[UILabel alloc] init];
    _scanfLabel.backgroundColor = [UIColor clearColor];
    _scanfLabel.font = CONTENT_FONT(10);
    _scanfLabel.text = @"扫码可享美式咖啡第二杯半价";
    _scanfLabel.textColor = [UIColor hexChangeFloat:@"666666"];
    [self.contentView addSubview:_scanfLabel];
    [_scanfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_characterLabel);
        make.top.equalTo(_comboLabel.mas_bottom).offset(12);
        make.right.equalTo(self.contentView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(SCALE_NUM(10));
    }];
    
}

- (BOOL)needLine
{
    return YES;
}

@end
