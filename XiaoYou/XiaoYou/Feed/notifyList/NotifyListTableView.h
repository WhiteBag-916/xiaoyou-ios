//
//  NotifyListTableView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@class YViewController;

@interface NotifyListTableView : YTableView

@property (nonatomic, weak) YViewController *superVC;

- (void)loadData;

//清除所有数据
- (void)readAll;

@end
