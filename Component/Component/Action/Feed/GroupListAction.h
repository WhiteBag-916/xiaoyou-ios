//
//  GroupListAction.h
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface GroupListAction : YHTTPRequestAction<YAction>

@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, assign) NSInteger limitEnd;
@property (nonatomic, strong) NSString *queryCode;
@property (nonatomic, strong) NSString *name;

@end
