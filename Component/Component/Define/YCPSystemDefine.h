//
//  YCPSystemDefine.h
//  Component
//
//  Created by 熊宸 on 15/4/24.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#ifndef Component_YCPSystemDefine_h
#define Component_YCPSystemDefine_h

//#define 

#define isScreen3_5Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isScreen4Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isScreen4_7Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define isScreen5_5Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define system_Version [[[UIDevice currentDevice] systemVersion] floatValue]
#define kBundle_Short_Version [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] floatValue]

static const NSInteger kLayoutPriorityDefaultVeryHigh = 999;

#define ADDIPHONE5HEIGHT  (isScreen4Inch?88:0)
#define KNavigationBarheight  64.0
#define KTabBarheight  50.0

#define kProjectPageNum         10
#define kFeedPageNum            10
#define kPartnerFateNum         10
#define kPartnerNum             15//一页15条
#define kMessageListNum         10
#define kNotificationListNum    10
#define kConversationListNum    5
#define kPersonPageNum           9

#endif
