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
    
}

@end
