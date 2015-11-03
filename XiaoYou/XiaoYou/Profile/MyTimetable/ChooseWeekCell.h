//
//  ChooseWeekCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

extern NSString *const kChooseWeekCell;

@interface ChooseWeekCell : YTableViewCell

- (void)initData:(NSInteger)num selected:(BOOL)selected isNowWeek:(BOOL)isNowWeek;

@end
