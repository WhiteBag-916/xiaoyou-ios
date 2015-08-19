//
//  YNavigationController.m
//  YFramework
//
//  Created by abc on 15/6/13.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YNavigationController.h"
#import <objc/runtime.h>

@implementation UINavigationController (MethodSwizzling)

//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        {
//            Method originMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
//            Method swizzledMethod = class_getInstanceMethod([self class], @selector(swizzling_pushViewController:animated:));
//            method_exchangeImplementations(originMethod, swizzledMethod);
//        }
//    });
//}
//
//- (void)swizzling_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [self swizzling_pushViewController:viewController animated:animated];
//    self.interactivePopGestureRecognizer.enabled = NO;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needHiddenBottomBar:(BOOL)needHiddenBottomBar
{
    self.visibleViewController.hidesBottomBarWhenPushed = needHiddenBottomBar;
    
    [self pushViewController:viewController animated:animated];
}

@end