//
//  SearchFilterTableViewCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

extern NSString *const kSearchFilterTableViewCell;

@interface SearchFilterTableViewCell : YTableViewCell

- (void)initData:(NSString *)name select:(BOOL)isSelect;

@end
