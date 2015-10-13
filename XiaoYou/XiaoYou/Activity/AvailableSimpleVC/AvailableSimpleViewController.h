//
//  AvailableSimpleViewController.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YViewController.h"

typedef NS_ENUM(NSInteger, AvailableSimpleType) {
    AvailableSimpleTypeRubLesson,       //你可以蹭的课
    AvailableSimpleTypeStudyRoom,       //自习室
    AvailableSimpleTypeStudyRoomDetail, //自习室详情
};

@interface AvailableSimpleViewController : YViewController

- (id)initWithType:(AvailableSimpleType)type;

@end
