//
//  InterestListAction.h
//  Component
//
//  Created by 熊宸 on 15/11/6.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface InterestListAction : YHTTPRequestAction<YAction>

@property (nonatomic, assign) NSInteger publishDay;
@property (nonatomic, assign) NSInteger maxSize;

@end
