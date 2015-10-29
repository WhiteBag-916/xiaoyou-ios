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

- (instancetype)initWithImageCount:(NSInteger) num
{
    self = [super init];
    if (self) {
        [self setUpUI:num];
    }
    return self;
}

-(void)setUpUI:(NSInteger) num
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_NUM(150))];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*num, SCALE_NUM(150));
    [self addSubview:_scrollView];
    
    for (int i = 0; i < num; i++)
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCALE_NUM(150))];
        imageView.image = [UIImage imageNamed:@"common_picture_loading_c"];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
    }
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.userInteractionEnabled = YES;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = num;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = KCOLOR_W1;
    _pageControl.currentPageIndicatorTintColor = KCOLOR_g1;
    [self addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(_scrollView.mas_bottom);
        make.width.mas_equalTo(SCALE_NUM(15*num));
        make.height.mas_equalTo(36);
    }];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
}

- (void)changePage:(UIPageControl *)sender
{
    CGSize viewSize = _scrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [_scrollView scrollRectToVisible:rect animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / SCREEN_WIDTH;
    _pageControl.currentPage = currentPage;
   
}

@end
