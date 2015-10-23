//
//  SearchActivityListView.h
//  XiaoYou
//
//  Created by sheng on 15/10/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@interface SearchActivityListView : YTableView

- (void)loadData;
- (void)resetArray:(NSArray *)array;
- (NSArray *)tableViewData;
//筛选
- (void)resetArrayByFilter:(NSString *)filterStr;
//搜索
- (void)resetArrayBySearch:(NSString *)searchStr;

@end
