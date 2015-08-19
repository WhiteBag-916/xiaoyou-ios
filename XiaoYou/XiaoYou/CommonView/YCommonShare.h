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
    YCommonShareDetailTypeFeed,
    YCommonShareDetailTypePerson,
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
 *  @param obj            字典，img键（可以为UIImage或NSData），url键（图片url），content键（分享内容）,title键（分享标题）
 *  @param type           feed或人的名片
 *  @param shareType      微信或朋友圈
 */
- (void)shareForViewControllerWithType:(YCommonShareDetailType)type dataModel:(NSDictionary *)obj shareType:(NSInteger)shareType;

@end
