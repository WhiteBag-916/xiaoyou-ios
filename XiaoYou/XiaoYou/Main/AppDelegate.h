//
//  AppDelegate.h
//  XiaoYou
//
//  Created by 熊宸 on 15/7/9.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckLastVersionModel.h"

@class XYTabBarViewController;
@class DDMenuController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) XYTabBarViewController *tabBar;
@property (nonatomic, strong) DDMenuController *menuController;

@property (nonatomic,strong) CheckLastVersionModel * checkLastVersionModel;

@end

