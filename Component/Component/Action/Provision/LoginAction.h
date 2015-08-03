//
//  LoginAction.h
//  Component
//
//  Created by 熊宸 on 15/7/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface LoginAction : YHTTPRequestAction<YAction>

@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *schoolCode;
@property (strong, nonatomic) NSString *deviceId;
@property (strong, nonatomic) NSString *studentNo;
@property (strong, nonatomic) NSString *platform;

@end
