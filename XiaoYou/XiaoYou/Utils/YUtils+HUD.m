//
//  YProgressHUD.m
//  YFramework
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YUtils+HUD.h"
#import "MBProgressHUD+BWMExtension.h"
@implementation YUtils(HUD)

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view title:(NSString *)title animated:(BOOL)animated {
    return [MBProgressHUD bwm_showHUDAddedTo:view title:title animated:animated];
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view title:(NSString *)title {
    return [YUtils showHUDAddedTo:view title:title animated:true];
}

+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title animated:(BOOL)animated {
    return [YUtils showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] title:title animated:animated];
}

+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title {
    return [YUtils showHUDWithTitle:title animated:true];
}

+ (MBProgressHUD *)showTitleOn:(UIView *)view title:(NSString *)title hideAfter:(NSTimeInterval)afterSecond {
    return [MBProgressHUD bwm_showTitle:title toView:view hideAfter:afterSecond];
}

+ (MBProgressHUD *)showTitleOn:(UIView *)view title:(NSString *)title {
    return [YUtils showTitleOn:view title:title hideAfter:1];
}
+ (MBProgressHUD *)showTitle:(NSString *)title hideAfter:(NSTimeInterval)afterSecond {
    return [YUtils showTitleOn:[[[UIApplication sharedApplication] delegate] window] title:title hideAfter:afterSecond];
}
+ (MBProgressHUD *)showTitle:(NSString *)title {
    return [YUtils showTitleOn:[[[UIApplication sharedApplication] delegate] window] title:title hideAfter:1];
}
@end
