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
} MODEL_TYPE_T;


@interface NotifyInfoModel : YModel <NSCoding, NSCopying>

@property (nonatomic,assign) MODEL_TYPE_T modelType;
@property (nonatomic,copy) NSString *title;


@property (nonatomic,copy) NSString *headIcon;

//用户自建日程提醒信息
@property (nonatomic,assign) NSString   *uid;
@property (nonatomic,assign) NSInteger  type;
@property (nonatomic,assign) double startTime;
@property (nonatomic,assign) double timestamp;
@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *em_push_title;
@property (nonatomic,copy) NSString *organizer;

@property (nonatomic,copy) NSString *isRead;
//@property (nonatomic,strong) NSArray *propetiesCommon;

-(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
