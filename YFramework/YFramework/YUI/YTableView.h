//
//  YTableView.h
//  YFramework
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+FDTemplateLayoutCell.h"

@interface YTableView : UITableView

//拉取新数据
- (void)beginLoadNewData;
//拉取更多数据
- (void)beginLoadMoreData;
//停止拉取新数据
- (void)stopLoadNewData;
//停止拉取更多数据
- (void)stopLoadMoreData;
//停止刷新，哪个正在刷新，停止哪个
- (void)stopLoad;
//隐藏头
- (void)hiddenHeader:(BOOL)isHidden;
//隐藏尾
- (void)hiddenFooter:(BOOL)isHidden;
//显示无更多数据
- (void)showNoticeNoMoreData;

- (BOOL)isHeaderRefresh;
- (BOOL)isFooterRefresh;

//图片的属性
- (NSString*)noDataImageViewAttribute;
//是否展示无数据图片
- (void)showNoDataImageView:(BOOL)isShow;
@end
