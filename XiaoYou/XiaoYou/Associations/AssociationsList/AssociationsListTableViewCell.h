//
//  AssociationsListTableViewCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

@class GroupModel;

extern NSString *const kAssociationsListTableViewCell;

@interface AssociationsListTableViewCell : YTableViewCell

- (void)resetData:(GroupModel *)model isDetail:(BOOL)isDetail;

@end
