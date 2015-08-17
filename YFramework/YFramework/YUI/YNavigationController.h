//
//  YNavigationController.h
//  YFramework
//
//  Created by abc on 15/6/13.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MethodSwizzling)<UIGestureRecognizerDelegate>

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated from:(UIViewController *)fromViewController;

@end
