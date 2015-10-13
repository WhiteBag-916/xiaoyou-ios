//
//  ActivityBaseCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityBaseCollectionViewCell.h"

NSString *const kActivityBaseCollectionViewCell = @"ActivityBaseCollectionViewCellId";

@implementation ActivityBaseCollectionViewCell

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
    UIView * backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    UIImageView * topImageView = [[UIImageView alloc] init];
//    topImageView
}

@end
