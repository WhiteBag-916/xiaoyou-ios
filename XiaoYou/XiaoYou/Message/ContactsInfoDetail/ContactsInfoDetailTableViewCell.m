//
//  ContactsInfoDetailTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsInfoDetailTableViewCell.h"
#import "SDPhotoBrowser.h"

#define kFlagImageDistanceToLeft            22
#define kLabelDistanceToRight               22
#define kFlagImageWidthAndHeight            20
#define kFlagImageDistanceToLabel           25
#define kLabelHeight                        20

NSString *const kContactsInfoDetailTableViewCell = @"ContactsInfoDetailTableViewCellId";

@interface ContactsInfoDetailTableViewCell ()<SDPhotoBrowserDelegate>

@property (nonatomic,strong)UIImageView * flagImageView;
@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation ContactsInfoDetailTableViewCell

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
    _flagImageView = [[UIImageView alloc] init];
    _flagImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_flagImageView];
    [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kFlagImageDistanceToLeft);
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(kFlagImageWidthAndHeight);
        
    }];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = CONTENT_FONT(12);
    _contentLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_flagImageView.mas_right).offset(kFlagImageDistanceToLabel);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-kLabelDistanceToRight);
        make.height.mas_equalTo(kLabelHeight);
    }];
    
    _line = [[UIView alloc] init];
    [self.contentView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    _line.backgroundColor = KCOLORGREEN_e6ebea;
}

-(void)setCellInfo:(NSDictionary *) dic hiddenLine:(BOOL)hiddenLine
{
    if ([dic[@"index"] integerValue] == 0)
    {
        _flagImageView.image = [UIImage imageNamed:@"toast_cup"];
    }
    if ([dic[@"index"] integerValue] == 1) {
        if ([dic[@"isCool"] boolValue]) {
            _flagImageView.image = [UIImage imageNamed:@"mine-heart-red"];
        } else {
            _flagImageView.image = [UIImage imageNamed:@"mine-heart"];
        }
    }
    if ([dic[@"index"] integerValue] == 2) {
        _flagImageView.image = [UIImage imageNamed:@"tag-grey"];
    }
    if ([dic[@"index"] integerValue] > 2) {
        _flagImageView.image = nil;
    }
    if ([dic[@"equal"] boolValue])
    {
        _contentLabel.textColor = KCOLORGREEN_009688;
    }
    else
    {
        _contentLabel.textColor = [UIColor blackColor];
    }
    _contentLabel.text = dic[@"content"];
    _line.hidden = hiddenLine;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
