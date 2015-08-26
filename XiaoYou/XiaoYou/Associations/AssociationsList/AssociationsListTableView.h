//
//  AssociationsListTableView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@class YViewController;

@interface AssociationsListTableView : YTableView

@property (nonatomic, weak) YViewController *superVC;

- (void)loadData;
- (void)resetArray:(NSArray *)array;
- (NSArray *)tableViewData;
//筛选
- (void)resetArrayByFilter:(NSString *)filterStr;
//搜索
- (void)resetArrayBySearch:(NSString *)searchStr;

@end
