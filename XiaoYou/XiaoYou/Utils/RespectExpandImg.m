//
//  RespectExpandImg.m
//  XiaoYou
//
//  Created by sheng on 15/10/15.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RespectExpandImg.h"

#define EXPAND_RANGE    70.0

@implementation RespectExpandImg

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    NSLog(@"this is a point = %@",NSStringFromCGPoint(point));
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(EXPAND_RANGE - bounds.size.width, 0);
    CGFloat heightDelta = MAX(EXPAND_RANGE - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    
    //bounds = CGRectMake(-30, -60, 200, 200);
    return CGRectContainsPoint(bounds, point);
}

@end
