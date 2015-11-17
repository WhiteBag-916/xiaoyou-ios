//
//  YCommonShare.h
//  YCPai
//
//  Created by ycpai on 15/7/7.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YCommonActionSheet.h"

typedef NS_ENUM(NSInteger, YCommonShareDetailType) {
    /**
     *  @author 李思良, 15-08-20
     *
     *  @brief  分享feed，需要提供tag键（feed一个标签），content键（分享内容），pic键（feed图，没有则校友logo）
     */
    YCommonShareDetailTypeFeed,
    /**
     *  @author 李思良, 15-08-20
     *
     *  @brief  分享人名片，需要提供name键（人名），pic键（人头像url string），school键（学校名称）
     */
    YCommonShareDetailTypePerson,
    /**
     *  @author 李思良, 15-08-20
     *
     *  @brief  分享社团，需要提供name键（社团名称），content键（社团简介），pic键（社团头像url string）
     */
    YCommonShareDetailTypeAssociation,
    /**
     *  @author 熊宸, 15-11-16
     *
     *  @brief  分享活动社团，需要提供name键（活动名称），content键（活动简介），pic键（活动头像url string）
     */
    YCommonShareDetailTypeActivity,
    /**
     *  @author 熊宸, 15-11-17
     *
     *  @brief  分享社团feed，需要提供name键（社团名称），content键（feed内容），pic键（feed图，没有则社团logo，没有则校友logo）
     */
    YCommonShareDetailTypeAssociationFeed,
};

@interface YCommonShare : NSObject
+ (YCommonShare *)sharedInstance;

//注册
- (void)registUmengSDK;

/**
 *  @author 李思良, 15-08-19
 *
 *  @brief  分享
 *
 *  @param obj            数据字典，要求参见YCommonShareDetailType具体说明
 *  @param type           YCommonShareDetailType
 *  @param shareType      YShareType
 */
- (void)shareForViewControllerWithType:(YCommonShareDetailType)type dataModel:(NSDictionary *)obj shareType:(NSInteger)shareType;

@end
