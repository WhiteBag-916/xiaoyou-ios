//
//  SearchFilterTableViewCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSearchFilterTableViewCell;

@interface SearchFilterTableViewCell : UITableViewCell

- (void)initData:(NSString *)name select:(BOOL)isSelect;

@end
