//
//  FeedListAction.h
//  Component
//
//  Created by 熊宸 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface FeedListAction : YHTTPRequestAction<YAction>

@property (nonatomic, assign) NSString *lastId;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) NSString *queryCode;

@end
