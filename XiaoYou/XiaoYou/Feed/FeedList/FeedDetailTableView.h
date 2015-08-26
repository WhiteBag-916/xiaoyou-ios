//
//  FeedDetailTableView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"
@class FeedDetailViewController;
@interface FeedDetailTableView : YTableView

@property (nonatomic, weak) FeedDetailViewController *parent;

- (id)initWithFeedId:(NSString *)feedId;

- (void)loadData;

- (void)openTool;
@end
