//
//  FindActivityDetailInfoAction.h
//  Component
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface FindActivityDetailInfoAction : YHTTPRequestAction

@property (nonatomic, strong) NSString *activityPublishedId;
@property (nonatomic, assign) BOOL getDetail;
@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, assign) NSInteger limitEnd;

@end
