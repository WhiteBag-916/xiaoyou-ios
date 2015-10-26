//
//  NoticeAction.h
//  Component
//
//  Created by sheng on 15/10/26.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YAction.h"
#import "YHTTPRequestAction.h"

@interface NoticeAction : YHTTPRequestAction<YAction>

@property (nonatomic,assign) NSInteger limiteStart;
@property (nonatomic,assign) NSInteger limiteEnd;

@end
