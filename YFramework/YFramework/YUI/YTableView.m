//
//  YTableView.m
//  YFramework
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "MJRefresh.h"

@implementation YTableView

- (instancetype)init
{
    if (self = [super init])
    {
        if ([self showHeaderRefresh])
        {
            self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [self loadNewData];
            }];
        }
        
        if ([self showFooterRefresh])
        {
            self.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
                [self loadMoreData];
            }];
        }
    }
    
    return self;
}

//拉取新数据
- (void)beginLoadNewData
{
    [self.header beginRefreshing];
}

//拉取更多数据
- (void)beginLoadMoreData
{
    [self.footer beginRefreshing];
}

//隐藏头
- (void)hiddenHeader
{
    self.header.hidden = YES;
}

//隐藏尾
- (void)hiddenFooter
{
    self.footer.hidden = YES;
}

//显示无更多数据
- (void)showNoticeNoMoreData
{
    [self.footer noticeNoMoreData];
}

#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return NO;
}

- (BOOL)showFooterRefresh
{
    return NO;
}

- (void)loadNewData
{
    
}

- (void)loadMoreData
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
