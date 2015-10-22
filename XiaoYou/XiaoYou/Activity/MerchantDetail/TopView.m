//
//  TopScrollView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TopView.h"

@interface TopView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UIImageView * imageView1;
@property(nonatomic,strong)UIImageView * imageView2;
@property(nonatomic,strong)UIImageView * imageView3;

@end

@implementation TopView

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
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_NUM(150))];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCALE_NUM(150));
    [self addSubview:_scrollView];
    
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_NUM(150))];
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCALE_NUM(150))];
    _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCALE_NUM(150))];
    
    _imageView1.image = [UIImage imageNamed:@"common_picture_loading_c"];
    _imageView2.image = [UIImage imageNamed:@"common_picture_loading_c"];
    _imageView3.image = [UIImage imageNamed:@"common_picture_loading_c"];
    
    [_scrollView addSubview:_imageView1];
    [_scrollView addSubview:_imageView2];
    [_scrollView addSubview:_imageView3];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = KCOLORGREEN_W1;
    _pageControl.currentPageIndicatorTintColor = KCOLORGREEN_g1;
    [self addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(_scrollView.mas_bottom).offset(SCALE_NUM(-10));
        make.width.mas_equalTo(SCALE_NUM(100));
        make.height.mas_equalTo(SCALE_NUM(10));
    }];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
}

- (void)changePage:(UIPageControl *)sender
{
    _pageControl.currentPage = sender.currentPage;
    switch (sender.currentPage)
    {
        case 0:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _scrollView.contentOffset = CGPointMake(0, 0);
            }];
            break;
        }
        case 1:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _scrollView.contentOffset = CGPointMake(SCALE_NUM(SCREEN_WIDTH), 0);
            }];
            
            break;
        }
        case 2:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _scrollView.contentOffset = CGPointMake(SCALE_NUM(SCREEN_WIDTH*2), 0);
            }];
            
            break;
        }
        default:
            break;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x <= 0)
    {
        _pageControl.currentPage = 0;
    }
    else if (scrollView.contentOffset.x <= SCALE_NUM(SCREEN_WIDTH))
    {
        _pageControl.currentPage = 1;
    }
    else
    {
        _pageControl.currentPage = 2;
    }
}

@end
