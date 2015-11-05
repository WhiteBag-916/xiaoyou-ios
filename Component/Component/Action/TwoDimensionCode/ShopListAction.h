//
//  ShopListAction.h
//  Component
//
//  Created by 尹先森 on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YHTTPRequestAction.h"

@interface ShopListAction : YHTTPRequestAction<YAction>

@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, assign) NSInteger limitEnd;

@end
