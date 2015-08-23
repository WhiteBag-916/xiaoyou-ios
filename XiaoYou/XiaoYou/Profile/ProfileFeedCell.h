//
//  ProfileFeedCell.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

extern NSString *const KProfileFeedCell;
@class FeedInfo;
@interface ProfileFeedCell : YTableViewCell

- (void)setData:(FeedInfo *)info;

@end
