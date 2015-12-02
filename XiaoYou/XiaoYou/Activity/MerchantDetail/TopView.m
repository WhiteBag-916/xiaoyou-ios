//
//  TopScrollView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TopView.h"
#import "SupplierShopImages.h"
#import "UIImageView+Ext.h"
#import "YUtils+UI.h"

@interface TopView ()<UIScrollViewDelegate>

@property(nonatomic,strong)ShopList * model;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UIImageView * imageView1;
@property(nonatomic,strong)UIImageView * imageView2;
@property(nonatomic,strong)UIImageView * imageView3;

@end

@implementation TopView

- (instancetype)initWithModel:(ShopList *) model;
{
    self = [super init];
    if (self) {
        _model = model;
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    NSInteger imageCount = _model.supplierShopImages.count;
    self.scrollView = [YUtils
                       initScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*3/4)
                       backgroundColor:[UIColor clearColor]
                       userInteractionEnabled:YES
                       delegate:self
                       bounces:NO
                       showsHorizontalScrollIndicator:NO
                       showsVerticalScrollIndicator:NO
                       contentSize:CGSizeMake(SCREEN_WIDTH*imageCount, SCALE_NUM(150))
                       pagingEnabled:YES];
    [self addSubview:_scrollView];
    
    if (imageCount > 0)
    {
        for (int i = 0; i < imageCount; i++)
        {
            UIImageView * imageView = [[UIImageView alloc]
                                       initWithFrame:CGRectMake(SCREEN_WIDTH*i,
                                                                0,
                                                                SCREEN_WIDTH,
                                                                SCREEN_WIDTH*3/4)];
            SupplierShopImages * imageModel = _model.supplierShopImages[i];
            [imageView setFaceImageWithUrl:imageModel.imageUrl];
            imageView.userInteractionEnabled = YES;
            [_scrollView addSubview:imageView];
        }
    }
    else
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                0,
                                                                                SCREEN_WIDTH,
                                                                                SCREEN_WIDTH*3/4)];
        imageView.image = [UIImage imageNamed:@"common_picture_loading_b"];
        imageView.userInteractionEnabled = YES;
        [_scrollView addSubview:imageView];
    }
    self.pageControl = [YUtils initPageControlWithBackgroundColor:[UIColor clearColor]
                                           userInteractionEnabled:YES
                                                    numberOfPages:imageCount
                                                      currentPage:0
                                           pageIndicatorTintColor:KCOLOR_W1
                                    currentPageIndicatorTintColor:KCOLOR_g1];
    [self addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(_scrollView.mas_bottom);
        make.width.mas_equalTo(SCALE_NUM(15*imageCount));
        make.height.mas_equalTo(36);
    }];
    [_pageControl addTarget:self action:@selector(changePage:)
           forControlEvents:UIControlEventValueChanged];
}

- (void)changePage:(UIPageControl *)sender
{
    CGSize viewSize = _scrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [_scrollView scrollRectToVisible:rect animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = (scrollView.contentOffset.x + SCREEN_WIDTH/2)/ SCREEN_WIDTH;
    _pageControl.currentPage = currentPage;
  
}

@end
