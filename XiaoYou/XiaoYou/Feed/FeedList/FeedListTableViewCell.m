//
//  FeedListTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedListTableViewCell.h"

@interface FeedListTableViewCell ()

@property (nonatomic, strong) UIImageView *contactHeadImageView;
@property (nonatomic, strong) UILabel *contactNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation FeedListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
