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
//隐藏头
- (void)hiddenHeader:(BOOL)isHidden;
//隐藏尾
- (void)hiddenFooter:(BOOL)isHidden;
//显示无更多数据
- (void)showNoticeNoMoreData;

- (BOOL)isHeaderRefresh;
@end
