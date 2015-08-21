//
//  SchoolListAction.h
//  Component
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface SchoolListAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *schoolName;

@end
