//
//  StudyRoomDetailTableViewCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
#import "FreeBuildingDetailModel.h"

extern NSString *const kStudyRoomDetailTableViewCell;

@interface StudyRoomDetailTableViewCell : YTableViewCell

- (void)initData:(FreeBuildingDetailModel *)model;

@end
