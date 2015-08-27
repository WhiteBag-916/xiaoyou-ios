//
//  ProfileTagViewController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

typedef NS_ENUM(NSInteger, ProfileTagType) {
    ProfileTagTypePerson,           //人加tag
    ProfileTagTypeAssociations,     //社团筛选
};

typedef void(^ProfileTagSelectedBlock)(NSString *filterStr);

@interface ProfileTagViewController : YViewController

- (id)initWithMyTags:(NSArray *)myTags type:(ProfileTagType)type;

- (void)endSelected:(ProfileTagSelectedBlock)block;

@end
