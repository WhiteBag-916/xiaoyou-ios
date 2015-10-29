//
//  ActivityIdentityTableViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityIdentityTableViewCell.h"

NSString *const kActivityIdentityTableViewCell = @"ActivityIdentityTableViewCellId";

@interface ActivityIdentityTableViewCell ()

@property(nonatomic,strong)UILabel * contentLabel;

@end

@implementation ActivityIdentityTableViewCell

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
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.font = CONTENT_FONT(SCALE_NUM(12));
    _contentLabel.textColor = KCOLOR_B4;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.layer.borderColor = [UIColor hexChangeFloat:@"465a65"].CGColor;
    _contentLabel.layer.borderWidth = 1;
    _contentLabel.layer.cornerRadius = 2;
    _contentLabel.clipsToBounds = YES;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(40));
        make.right.mas_equalTo(SCALE_NUM(-40));
        make.top.mas_equalTo(SCALE_NUM(5));
        make.bottom.mas_equalTo(SCALE_NUM(-5));
    }];
}

-(void)setCellInfo:(NSMutableDictionary *) dic
{
    _contentLabel.text = dic[@"name"];
    if ([dic[@"isChoice"] boolValue])
    {
        _contentLabel.backgroundColor = KCOLOR_g1;
        _contentLabel.textColor = KCOLOR_W1;
        _contentLabel.layer.borderColor = [UIColor clearColor].CGColor;
        
    }
    else
    {
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = KCOLOR_B4;
        _contentLabel.layer.borderColor = [UIColor hexChangeFloat:@"465a65"].CGColor;
    }
}

//-(BOOL)needLine
//{
//    return YES;
//}

@end
