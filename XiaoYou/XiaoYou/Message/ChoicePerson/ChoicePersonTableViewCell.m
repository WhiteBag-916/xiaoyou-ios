//
//  ChoicePersonTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ChoicePersonTableViewCell.h"

#define kHeadCornerRadius              22.5
#define kPaddingDistance               12
#define kHeadImageWidthAndHeight       45
#define kNameWidth                     90
#define kNameHeight                    20

NSString *const kChoicePersonTableViewCell = @"ChoicePersonTableViewCellId";

@interface ChoicePersonTableViewCell ()

@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * nameLabel;

@end

@implementation ChoicePersonTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_backView];
        
        //头像
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = [UIColor clearColor];
        _headImageView.layer.cornerRadius = kHeadCornerRadius;
        _headImageView.clipsToBounds = YES;
        _headImageView.image = [UIImage imageNamed:@"default_head"];
        [_backView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(kPaddingDistance);
            make.width.height.mas_equalTo(kHeadImageWidthAndHeight);
        }];
        
        //昵称
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.text = @"斯提尔伯格";
        [_backView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_backView.mas_centerY);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
            make.width.mas_equalTo(kNameWidth);
            make.height.mas_equalTo(kNameHeight);
        }];
    }
    return self;
}

-(void)setCellInfo:(NSDictionary *) dic
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
