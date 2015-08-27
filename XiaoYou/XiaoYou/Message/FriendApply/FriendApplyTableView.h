//
//  FriendApplyTableView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@class YViewController;

@interface FriendApplyTableView : YTableView

@property (nonatomic, weak) YViewController *superVC;

- (void)loadData;

-(void)refreshTableView:(NSMutableArray *) dataSouceArr;

@end
