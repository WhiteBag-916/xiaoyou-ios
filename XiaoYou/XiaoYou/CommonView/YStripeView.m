//
//  YStripeView.m
//  XiaoYou
//
//  Created by 李思良 on 15/10/4.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YStripeView.h"

@implementation YStripeView

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor hexChangeFloat:@"179D92"];
        self.clipsToBounds = true;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    float offset = rect.size.width / 3;
    float y = offset;
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor hexChangeFloat:@"32ADA3"].CGColor);
    
    while (y <= rect.size.height + rect.size.width / 2) {
        CGContextMoveToPoint(ctx, 0, y);
        CGContextAddLineToPoint(ctx, rect.size.width, y - rect.size.width);
        CGContextAddLineToPoint(ctx, rect.size.width, y - rect.size.width + offset);
        CGContextAddLineToPoint(ctx, 0, y + offset);
        CGContextClosePath(ctx);
        CGContextDrawPath(ctx, kCGPathFill);
        y += 2 * offset;
    }
    
}


@end
