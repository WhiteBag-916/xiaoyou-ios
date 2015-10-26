//
//  AvailableAction.h
//  Component
//
//  Created by sheng on 15/10/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YAction.h"
#import "YHTTPRequestAction.h"

@interface AvailableAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, assign) NSInteger limitEnd;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic, strong) NSDictionary *condition;

@end
