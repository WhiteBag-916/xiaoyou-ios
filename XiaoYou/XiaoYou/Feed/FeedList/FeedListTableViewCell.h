//
//  FeedListTableViewCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

extern NSString *const kFeedListTableViewCell;
extern NSString *const kFeedDetailTableViewCell;
extern NSString *const KCommentTableViewCell;
extern NSString *const kOrganizationFeedListTableViewCell;

@class FeedInfo;
@interface FeedListTableViewCell : YTableViewCell

- (void)setData:(FeedInfo *)info;
@end
