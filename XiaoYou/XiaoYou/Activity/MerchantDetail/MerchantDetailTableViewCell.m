//
//  MerchantDetailTableViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MerchantDetailTableViewCell.h"

NSString *const kMerchantDetailTableViewCell = @"MerchantDetailTableViewCellId";

@interface MerchantDetailTableViewCell ()

@property(nonatomic,strong)UILabel * contentLabel;

@end

@implementation MerchantDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.backgroundColor = [UIColor orangeColor];
    _contentLabel.font = CONTENT_FONT(SCALE_NUM(12));
    _contentLabel.numberOfLines = 0;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.textColor = KCOLOR_B4;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(SCALE_NUM(5));
        make.bottom.mas_equalTo(SCALE_NUM(-5));
    }];
}

-(void)setCellInfo:(NSString *) showStr isHeader:(BOOL) isHeader
{
    if (isHeader)
    {
        _contentLabel.font = CONTENT_FONT(SCALE_NUM(14));
        _contentLabel.textColor = KCOLOR_g1;
        _contentLabel.text = showStr;
    }
    else
    {
        _contentLabel.font = CONTENT_FONT(SCALE_NUM(12));
        _contentLabel.textColor = KCOLOR_B4;
        _contentLabel.text = showStr;
    }
}

@end
