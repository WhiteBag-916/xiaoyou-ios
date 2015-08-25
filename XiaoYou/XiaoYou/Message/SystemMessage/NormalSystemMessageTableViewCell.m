//
//  NormalSystemMessageTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "NormalSystemMessageTableViewCell.h"

#define kHeadImageViewHeightAndWidth        40
#define kPaddingDistance                    5
#define kHeadCornerRadius                   20
#define kBackTopAndBottom                   10
#define kBackLeft                           20
#define kBackRight                          16

NSString *const kNormalSystemMessageTableViewCell = @"NormalSystemMessageTableViewCellId";

@interface NormalSystemMessageTableViewCell ()

@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UILabel * contentLabel;

@end

@implementation NormalSystemMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = kHeadCornerRadius;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(kPaddingDistance);
            make.width.height.mas_equalTo(kHeadImageViewHeightAndWidth);
        }];
        
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [[UIImage imageNamed:@"chat_receiver_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 24, 30, 24) resizingMode:UIImageResizingModeStretch];;
        [self.contentView addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kPaddingDistance);
            make.right.bottom.mas_equalTo(-kPaddingDistance);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        }];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = CONTENT_FONT(12);
        _contentLabel.backgroundColor = [UIColor orangeColor];
        [_backImageView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kBackTopAndBottom);
            make.left.mas_equalTo(kBackLeft);
            make.bottom.mas_equalTo(-kBackTopAndBottom);
            make.right.mas_equalTo(-kBackRight);
        }];
    }
    return self;
}

-(void)setCellInfo:(id) dic
{
    _contentLabel.text = dic;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
