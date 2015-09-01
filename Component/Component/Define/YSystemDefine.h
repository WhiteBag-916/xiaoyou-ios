//
//  YSystemDefine.h
//  Component
//
//  Created by 熊宸 on 15/4/24.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#ifndef Component_YSystemDefine_h
#define Component_YSystemDefine_h

#define isScreen3_5Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) ||  CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) ||  CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size): NO)

#define isScreen4Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isScreen4_7Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define isScreen5_5Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define system_Version [[[UIDevice currentDevice] systemVersion] floatValue]
#define kBundle_Short_Version [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] floatValue]

static const NSInteger kLayoutPriorityDefaultVeryHigh = 999;



#define kApplicationKeyWindow [UIApplication sharedApplication].keyWindow
#define kAppDelegateAccessor ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define ADDIPHONE5HEIGHT  (isScreen4Inch?88:0)
#define KNavigationBarheight  64.0
#define KTabBarheight  50.0


typedef NS_ENUM(int, FeedCellType) {
    FeedListType            = 1,
    FeedDetailType          = 2,
    FeedCommentType         = 3,
    FeedOrganizationType    = 4,
};

typedef NS_ENUM(int, TagListType) {
    TagMenuType            = 1,
    TagSearchType          = 2,
};

#endif
