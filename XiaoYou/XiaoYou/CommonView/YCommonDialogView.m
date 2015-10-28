//
//  YCommonDialogView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YCommonDialogView.h"

@implementation YCommonDialogView

- (void)show {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    NSArray *windowViews = [window subviews];
    if(windowViews && [windowViews count] > 0){
        UIView *subView = [windowViews objectAtIndex:[windowViews count]-1];
        for(UIView *aSubView in subView.subviews)
        {
            [aSubView.layer removeAllAnimations];
        }
        [window addSubview:self];
        [self showBackground];
        [self showAlertAnimation];
    }
}

- (void)hide {
    [self hideAlertAnimation];
}

- (void)showBackground
{
    _backgroundView.alpha = 0.4;
}

-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 0.25;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    
    [_contentView.layer addAnimation:animation forKey:nil];
    
}

- (void)hideAlertAnimation {
    [self removeFromSuperview];
    _contentView.hidden = YES;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
