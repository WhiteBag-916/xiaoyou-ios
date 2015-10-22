//
//  FunnyMiddleView.h
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@interface ActivityMiddleView : UIView


#pragma mark 暂时移动这里
@property (nonatomic,strong) UIImageView    *timeImageView; //报名截止时间
@property (nonatomic,strong) UILabel        *staticDeadLineDes;//截止时间
@property (nonatomic,strong) UILabel        *deadLineTimeLabel;
@property (nonatomic,strong) UILabel        *staticActivityTimeDes;//活动时间
@property (nonatomic,strong) UILabel        *activityTimeLabel;//活动时间
@property (nonatomic,strong) UIImageView    *locationImageView;
@property (nonatomic,strong) UILabel        *locationLabel;
@property (nonatomic,strong) UIImageView    *categotyImageView;
@property (nonatomic,strong) UILabel        *categoryLabel;

@property (nonatomic,strong) UILabel        *staticActivityEndTimeDes;//活动结束时间
@property (nonatomic,strong) UILabel        *activityEndTimeLabel;

@end
