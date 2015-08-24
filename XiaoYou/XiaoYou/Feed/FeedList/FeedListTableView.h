//
//  FeedListTableView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/7.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"
@class FeedListViewController;
@interface FeedListTableView : YTableView

@property (nonatomic, weak) FeedListViewController *parent;

- (void)loadData;

@end
