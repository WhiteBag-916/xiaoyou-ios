//
//  YCommonShare.h
//  YCPai
//
//  Created by ycpai on 15/7/7.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UMSocialAccountEntity;
@class UMSocialResponseEntity;

typedef NS_ENUM(NSInteger, YCommonShareDetailType) {
    YCommonShareDetailTypeFeed,
    YCommonShareDetailTypeProject,
    YCommonShareDetailTypePerson,
};

typedef NS_ENUM(NSInteger, YCommonShareLoginType) {
    YCommonShareLoginTypeNone,
    YCommonShareLoginTypeSina,
    YCommonShareLoginTypeQQ,
    YCommonShareLoginTypeWeixin,
};

@interface YCommonShare : NSObject
+ (YCommonShare*) sharedInstance;

- (void)registUmengSDK;

- (void)showShareForViewController:(UIViewController *)viewController dataModel:(NSObject *)obj type:(YCommonShareDetailType)type;

- (void)loginShareForViewController:(UIViewController *)viewController LoginType:(YCommonShareLoginType)LoginType handler:(void(^)(UMSocialAccountEntity *snsAccount, UMSocialResponseEntity *response, BOOL success))handler;

@end
