//
//  UIScrollView+UITouchEvent.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "UIScrollView+UITouchEvent.h"

@implementation UIScrollView (UITouchEvent)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}
@end
