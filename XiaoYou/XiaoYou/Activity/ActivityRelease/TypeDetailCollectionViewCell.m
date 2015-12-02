//
//  TypeDetailCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/14.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TypeDetailCollectionViewCell.h"

NSString *const kTypeDetailCollectionViewCell = @"TypeDetailCollectionViewCellId";

@interface TypeDetailCollectionViewCell ()

@property (nonatomic,strong)UILabel * typeLabel;

@end

@implementation TypeDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    self.typeLabel = [[UILabel alloc] init];
    _typeLabel.layer.borderColor = KCOLOR_B2.CGColor;
    _typeLabel.layer.borderWidth = 1;
    _typeLabel.layer.cornerRadius = 4;
    _typeLabel.clipsToBounds = YES;
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    _typeLabel.backgroundColor = [UIColor clearColor];
    _typeLabel.font = CONTENT_FONT(12);
    [self.contentView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
}

-(void)setCellInfo:(NSDictionary *)dic
{
    _typeLabel.text = dic[@"name"];
    if ([dic[@"isChoice"] boolValue])
    {
        _typeLabel.backgroundColor = KCOLOR_g1;
        _typeLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        _typeLabel.backgroundColor = [UIColor clearColor];
        _typeLabel.textColor = KCOLOR_B3;
    }
}


@end
