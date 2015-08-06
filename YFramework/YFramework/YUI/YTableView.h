//
//  YTableView.h
//  YFramework
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTableView : UITableView

//拉取新数据
- (void)beginLoadNewData;
//拉取更多数据
- (void)beginLoadMoreData;
//隐藏头
- (void)hiddenHeader;
//隐藏尾
- (void)hiddenFooter;
//显示无更多数据
- (void)showNoticeNoMoreData;

@end
