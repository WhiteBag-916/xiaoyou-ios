//
//  YViewController.h
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFoundation.h"
#import "YNavigationController.h"
#import "Masonry.h"

/**
 *  @author Abc
 *
 *  UIViewController 框架基类,自定义控制器请继承此类
 */

@interface UIViewController (MethodSwizzling)
@end

@protocol YViewControllerDelegate <NSObject>
@optional
- (BOOL)shouldBeginInteractivePopGesture;
@end

@interface YViewController : UIViewController<YViewControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIButton *navigationLeftButton;
@property (strong, nonatomic) UIButton *navigationRightButton;

- (void)viewWillAppear:(BOOL)animated navigationBarHidden:(BOOL)navigationBarHidden tabBarHidden:(BOOL)tabBarHidden;

//导航栏左侧显示返回按钮
- (void)showCustomNavigationBackButton;

//导航栏左侧显示取消按钮
- (void)showCustomNavigationCancelButton;

//导航栏右侧，搜索按钮
- (void)showCustomNavigationSearchButton;

//导航栏右侧，更多按钮
- (void)showCustomNavigationMoreButton;

//导航栏右侧，确认按钮
- (void)showCustomNavigationSureButton;

- (void)showCustomNavigationPublishButton;

//导航栏右侧下一步按钮
- (void)showCustomNavigationNextButton;


@end
