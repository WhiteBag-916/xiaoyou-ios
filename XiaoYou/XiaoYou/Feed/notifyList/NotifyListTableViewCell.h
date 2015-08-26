//
//  NotifyListTableViewCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

@class AlertList;

extern NSString *const kNotifyListTableViewCell;

@interface NotifyListTableViewCell : YTableViewCell

- (void)initData:(AlertList *)alertList;

@end
