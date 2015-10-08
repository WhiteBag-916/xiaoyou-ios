//
//  TopView.m
//  XiaoYou
//
//  Created by sheng on 15/9/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TopView.h"
@interface TopView ()

@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *genderLabel;
@property (nonatomic,retain) UIView  *photoView;

@end

@implementation TopView

-(instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}


+(TopView *)topView
{
    TopView *topView = [[TopView alloc]init];
    return topView;
}
@end
