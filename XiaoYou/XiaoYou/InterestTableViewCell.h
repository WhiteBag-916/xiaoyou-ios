//
//  InterestTableViewCell.h
//  XiaoYou
//
//  Created by 李思良 on 15/10/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

#define KInterestCell @"KInterestCell"

@interface InterestModel : NSObject
@property (strong ,nonatomic) NSString *picture;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *source;
@property (strong, nonatomic) NSDate *time;
@property (strong, nonatomic) NSString *url;
@end


@interface InterestTableViewCell : YTableViewCell

- (void)setData:(InterestModel *)model;

@end
