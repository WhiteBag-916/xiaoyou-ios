//
//  ProfileChangePwdViewController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

typedef NS_ENUM(NSUInteger, ProfileChangePwdType) {
    ProfileChangePwdTypeMod,          //修改密码
    ProfileChangePwdTypeForget        //忘记密码
};

@interface ProfileChangePwdViewController : YViewController

- (id)initWithType:(ProfileChangePwdType)type;

@end
