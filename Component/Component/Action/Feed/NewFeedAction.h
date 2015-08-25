//
//  NewFeedAction.h
//  Component
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@class Feed;

@interface NewFeedAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) Feed *feed;
@property (nonatomic, strong) NSString *tagIds;

@end
