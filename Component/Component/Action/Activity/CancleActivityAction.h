//
//  CancleActivityAction.h
//  Component
//
//  Created by sheng on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YAction.h"
#import "YHTTPRequestAction.h"

@interface CancleActivityAction : YHTTPRequestAction<YAction>

@property (nonatomic,copy) NSString *activityPublishedId;

@end
