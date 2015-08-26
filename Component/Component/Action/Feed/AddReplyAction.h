//
//  AddReplyAction.h
//  Component
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface AddReplyAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *toUserId;

@end
