//
//  StudyRoomTableViewCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
#import "FreeBuildingListModel.h"

extern NSString *const kStudyRoomTableViewCell;

@interface StudyRoomTableViewCell : YTableViewCell

- (void)initData:(FreeBuildingListModel *)model;

@end
