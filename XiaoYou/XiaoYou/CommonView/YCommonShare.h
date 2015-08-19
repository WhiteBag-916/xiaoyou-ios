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

@class UMSocialAccountEntity;
@class UMSocialResponseEntity;

typedef NS_ENUM(NSInteger, YCommonShareDetailType) {
    YCommonShareDetailTypeFeed,
    YCommonShareDetailTypePerson,
};

@interface YCommonShare : NSObject
+ (YCommonShare *)sharedInstance;

//注册
- (void)registUmengSDK;

//分享
- (void)shareForViewControllerWithType:(UIViewController *)viewController dataModel:(NSObject *)obj type:(YCommonShareDetailType)type shareType:(YShareType)shareType;

@end
