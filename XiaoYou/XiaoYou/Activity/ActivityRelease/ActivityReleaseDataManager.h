//
//  ActivityReleaseDataManager.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/15.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityReleaseDataManager : NSObject

//活动名称
@property(nonatomic,strong)NSString * ActivityNameText;
//活动描述
@property(nonatomic,strong)NSString * ActivityDesciptionText;
@property(nonatomic,strong)UIImage * ActivityDesciptionImage;
//活动时间
@property(nonatomic,strong)NSString * ActivityDateApplyText;
@property(nonatomic,strong)NSString * ActivityDateBeginText;
@property(nonatomic,strong)NSString * ActivityDateEndText;
//活动地点
@property(nonatomic,strong)NSString * ActivityPlaceText;
//活动类型
@property(nonatomic,strong)NSString * ActivityTypeStr;

//报名审核
@property(nonatomic,strong)NSString * ActivityCheckStr;

+(instancetype)shareActivityReleaseDataManager;

//判断是否可以发布
-(void)isEnableToRelease;

@end
