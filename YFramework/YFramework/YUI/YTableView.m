//
//  YTableView.m
//  YFramework
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "MJRefresh.h"
#import "YVIew+Ext.h"

@interface YTableView ()

@property (nonatomic,strong) UIImageView    *noDataImageView;

@end

@implementation YTableView

//-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
//    if (self = [super initWithFrame:frame style:style]) {
//        self.delegate = self;
//        self.dataSource = self;
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        self.tableHeaderView.height = HEADCELL_HEIGHT;
//        [self registerClass:[PassRemindCell class] forCellReuseIdentifier:REMINDVIEWCELL];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        if ([self showHeaderRefresh])
        {
            self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (![self.footer isRefreshing]) {
                    [self.footer resetNoMoreData];
                    [self loadNewData];
                } else {
                    [self.header endRefreshing];
                }
            }];
        }
        
        if ([self showFooterRefresh])
        {
            self.footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
                if (![self.header isRefreshing]) {
                    [self loadMoreData];
                } else {
                    [self.footer endRefreshing];
                }
            }];
            self.footer.automaticallyHidden = NO;
            [(MJRefreshAutoNormalFooter *)self.footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
            
            [self hiddenFooter:YES];
        }
        
        //日志
        self.fd_debugLogEnabled = NO;
        
    }
    
    return self;
}

//无图图片
-(UIImageView *)noDataImageView
{
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc]init];
        [self addSubview:_noDataImageView];
        _noDataImageView.hidden = YES;
        NSString *imageName;
        if ((imageName = [self noDataImageViewAttribute]))
        {
            UIImage *image = [UIImage imageNamed:imageName];
            CGSize imageSize = image.size;
            CGFloat imageWidth = imageSize.width;
            CGFloat imageHeight = imageSize.height;
            self.noDataImageView.image = image;
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            CGFloat screenHeight= [UIScreen mainScreen].bounds.size.height - 64;
            self.noDataImageView.frame = CGRectMake(screenWidth/2 - imageWidth/2, screenHeight/2 - imageHeight/2, imageWidth, imageHeight);
        }

    }
    return _noDataImageView;
}

-(void)showNoDataImageView:(BOOL)isShow
{
    //没有数据,展示无图图片
    if (isShow) {
        self.noDataImageView.hidden = NO;
        self.scrollEnabled = NO;
        [self hiddenHeader:YES];
        [self hiddenFooter:YES];
    } else //有数据，不展示无图图片
    {
        self.noDataImageView.hidden = YES;
        self.scrollEnabled = YES;
        [self hiddenHeader:NO];
        [self hiddenFooter:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIViewController *vc;
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            vc = (UIViewController *)nextResponder;
            break;
        }
    }
    if (nil != vc) {
        [vc.view endEditing:YES];
    }
    
    [self endEditing:YES];
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

//停止拉取新数据
- (void)stopLoadNewData
{
    [self.header endRefreshing];
}

//停止拉取更多数据
- (void)stopLoadMoreData
{
    if ([self.footer isRefreshing]) {
        [self.footer endRefreshing];
    }
}

//停止刷新，哪个正在刷新，停止哪个
- (void)stopLoad {
    if ([self.header isRefreshing]) {
        [self.header endRefreshing];
    }
    if ([self.footer isRefreshing]) {
        [self.footer endRefreshing];
    }
}

//隐藏头
- (void)hiddenHeader:(BOOL)isHidden
{
    self.header.hidden = isHidden;
}

//隐藏尾
- (void)hiddenFooter:(BOOL)isHidden
{
    self.footer.hidden = isHidden;
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
- (BOOL)isHeaderRefresh {
    return self.header.isRefreshing;
}
- (BOOL)isFooterRefresh {
    return self.footer.isRefreshing;
}

//tableView没有数据的时候展示空图片
- (NSArray*)noDataImageViewAttribute
{
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
