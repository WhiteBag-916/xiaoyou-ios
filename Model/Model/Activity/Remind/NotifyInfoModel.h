//
//  NotifyInfoModel.h
//  Model
//
//  Created by sheng on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YModel.h"

typedef enum : NSUInteger {
    BEFORE_ACTIVITY_REMIND,     //活动前提醒
    ACTIVITY_RECOMMEND_REMIND   //活动推送
} MODEL_TYPE;


@interface NotifyInfoModel : YModel <NSCoding, NSCopying>

@property (nonatomic,assign) MODEL_TYPE type;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) double beginTime;
@property (nonatomic,copy) NSString *headPic;

@end
