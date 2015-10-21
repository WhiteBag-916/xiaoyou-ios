//
//  MiddleInfoView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MiddleInfoView.h"

@interface MiddleInfoView ()

@property(nonatomic,strong)UIImageView * houseImageView;
@property(nonatomic,strong)UILabel * houseLabel;

@property(nonatomic,strong)UIImageView * phoneImageView;
@property(nonatomic,strong)UILabel * phoneLabel;

@property(nonatomic,strong)UIImageView * placeImageView;
@property(nonatomic,strong)UILabel * placeLabel;

@end

@implementation MiddleInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    _houseImageView = [[UIImageView alloc] init];
    _houseImageView.backgroundColor = [UIColor orangeColor];
    
}

@end
