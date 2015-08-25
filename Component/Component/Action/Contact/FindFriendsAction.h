//
//  FindFriendsAction.h
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface FindFriendsAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSDictionary *condition;
@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, assign) NSInteger limitEnd;

@end
