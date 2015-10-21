//
//  TopScrollView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TopScrollView.h"

@interface TopScrollView ()

@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UIImageView * imageView1;
@property(nonatomic,strong)UIImageView * imageView2;
@property(nonatomic,strong)UIImageView * imageView3;

@end

@implementation TopScrollView

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
    
}

@end
