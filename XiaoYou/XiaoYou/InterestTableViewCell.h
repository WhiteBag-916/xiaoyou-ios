//
//  InterestTableViewCell.h
//  XiaoYou
//
//  Created by 李思良 on 15/10/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
@class NewsList;
#define KInterestCell @"KInterestCell"


@interface InterestTableViewCell : YTableViewCell

- (void)setData:(NewsList *)model;

@end
