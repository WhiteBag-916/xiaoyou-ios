//
//  ContactsInfoDetailTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsInfoDetailTableViewCell.h"

#define kFlagImageDistanceToLeft            22
#define kLabelDistanceToRight               22
#define kFlagImageWidthAndHeight            20
#define kFlagImageDistanceToLabel           25
#define kLabelHeight                        20

NSString *const kContactsInfoDetailTableViewCell = @"ContactsInfoDetailTableViewCellId";

@interface ContactsInfoDetailTableViewCell ()

@property (nonatomic,strong)UIImageView * flagImageView;
@property (nonatomic,strong)UILabel * contentLabel;

@end

@implementation ContactsInfoDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_flagImageView];
        [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kFlagImageDistanceToLeft);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(kFlagImageWidthAndHeight);
            
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_flagImageView.mas_right).offset(kFlagImageDistanceToLabel);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-kLabelDistanceToRight);
            make.height.mas_equalTo(kLabelHeight);
        }];
        
    }
    return self;
}

-(void)setCellInfo:(NSDictionary *) dic
{
    if ([dic[@"index"] integerValue] == 0)
    {
        _flagImageView.image = [UIImage imageNamed:@"toast_cup"];
    }
    if ([dic[@"index"] integerValue] == 1) {
        _flagImageView.image = [UIImage imageNamed:@"toast_cup"];
    }
    if ([dic[@"index"] integerValue] == 2) {
        _flagImageView.image = [UIImage imageNamed:@"toast_cup"];
    }
    _contentLabel.text = dic[@"content"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
