//
//  ListCommentAction.h
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface ListCommentAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *lastId;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) NSString *feedId;

@end
