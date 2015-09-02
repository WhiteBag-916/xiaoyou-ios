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

- (void)setData:(id)info;
/**
 *  @author 李思良, 15-09-01
 *
 *  @brief  特别用于社团feed的显示需求（动态图标）
 *
 */
- (void)setHintHidden:(BOOL)isHidden;
@end
