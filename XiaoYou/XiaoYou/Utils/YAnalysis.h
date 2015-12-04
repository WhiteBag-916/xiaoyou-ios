//
//  YAnalysis.h
//  XiaoYou
//
//  Created by 李思良 on 15/12/4.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProfileInfo;

/**
 *  @author 李思良, 15-12-04
 *
 *  @brief 利用诸葛io的数据统计
 */
@interface YAnalysis : NSObject

/**
 *  @author 李思良, 15-12-04
 *
 *  @brief 对统计进行初始化
 *
 *  @param launchOptions     传入didFinishLaunchingWithOptions中的launchOptions参数
 */
+ (void)configAnalysis:(NSDictionary*)launchOptions;

/**
 *  @author 李思良, 15-12-04
 *
 *  @brief 跟踪事件
 *
 *  @param eventName 事件的名称，以布点文档中事件的名称为准
 *  @param param     统计携带的参数
 */
+ (void)trackEvent:(NSString *)eventName withPara:(NSDictionary *)param;

/**
 *  @author 李思良, 15-12-04
 *
 *  @brief 记录用户的信息到诸葛
 *
 *  @param data 用户信息
 */
+ (void)collectUserInfo:(ProfileInfo *)data;
@end
