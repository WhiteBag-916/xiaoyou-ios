//
//  ProfileAction.h
//  Component
//
//  Created by 熊宸 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface ProfileAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *hxId;

@end
