//
//  AppConfigData.h
//  Component
//
//  Created by sheng on 15/10/14.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfigData : NSObject

//是否第一次使用有空
+(BOOL)isUserFirstUseHaveTime;
//第一次使用人脉
+(BOOL)isUserFirstUseFeed;
//第一次使用扫码
+(BOOL)isUserFirstUseReadCode;
@end
