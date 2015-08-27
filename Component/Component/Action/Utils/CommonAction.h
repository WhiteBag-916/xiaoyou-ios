//
//  CommonAction.h
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface CommonAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSDictionary *parameter;
@property (nonatomic, strong) NSString *url;

@end
