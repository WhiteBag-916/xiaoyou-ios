//
//  ListPraisePeoplesAction.h
//  Component
//
//  Created by 熊宸 on 15/8/27.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface ListPraisePeoplesAction : YHTTPRequestAction

@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, assign) NSInteger limitEnd;
@property (nonatomic, strong) NSString *feedId;

@end
