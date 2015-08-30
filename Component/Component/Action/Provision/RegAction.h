//
//  RegAction.h
//  Component
//
//  Created by 熊宸 on 15/8/30.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface RegAction : YHTTPRequestAction<YAction>

@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *schoolCode;
@property (strong, nonatomic) NSString *studentNo;
@property (strong, nonatomic) NSString *platform;
@property (nonatomic, strong) NSString *mobilePhone;

@end
