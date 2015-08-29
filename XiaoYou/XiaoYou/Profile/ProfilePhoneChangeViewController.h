//
//  ProfilePhoneChangeViewController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

typedef NS_ENUM(NSUInteger, ProfilePhoneChangeType) {
    ProfilePhoneChangeTypeMod,          //修改密码
    ProfilePhoneChangeTypeRegister      //注册
};

@interface ProfilePhoneChangeViewController : YViewController

- (id)initWithType:(ProfilePhoneChangeType)type hasPhone:(BOOL)hasPhone;

@end
