//
//  AgreeApplyAction.h
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface AgreeApplyAction : YHTTPRequestAction

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *applyId;

@end
