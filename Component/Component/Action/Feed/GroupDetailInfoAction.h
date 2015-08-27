//
//  GroupDetailInfoAction.h
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface GroupDetailInfoAction : YHTTPRequestAction<YAction>

@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) NSString *groupId;

@end
