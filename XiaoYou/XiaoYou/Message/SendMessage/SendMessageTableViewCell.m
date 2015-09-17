//
//  SendMessageTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SendMessageTableViewCell.h"

#define kCellLineHeight             1

NSString *const kSendMessageTableViewCell = @"SendMessageTableViewCellId";

@interface SendMessageTableViewCell ()

@property(nonatomic,strong)UIView * backView;

@end

@implementation SendMessageTableViewCell


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
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor hexChangeFloat:@"465a65"];
    [self.contentView addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kCellLineHeight);
        make.bottom.mas_equalTo(-kCellLineHeight);
    }];
    
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.font = CONTENT_FONT(13);
    _infoLabel.textColor = [UIColor hexChangeFloat:@"465a65"];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:_infoLabel];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kCellLineHeight);
        make.bottom.mas_equalTo(-kCellLineHeight);
        make.left.right.mas_equalTo(0);
    }];
}

-(void)setCellInfo:(NSString *) text
{
    _infoLabel.text = text;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
