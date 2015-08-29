//
//  ForbiddenLinkManAction.h
//  Component
//
//  Created by 熊宸 on 15/8/29.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface ForbiddenLinkManAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *forbiddenId;

@end
