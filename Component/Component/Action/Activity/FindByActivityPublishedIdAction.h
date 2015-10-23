//
//  FindByActivityPublishedIdAction.h
//  Component
//
//  Created by 熊宸 on 15/10/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface FindByActivityPublishedIdAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong) NSString *activityId;

@end
