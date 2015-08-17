//
//  YViewController.m
//  YFramework
//
//  Created by abc on 15/4/17.
//  Copyright (c) 2015年 Abc. All rights reserved.
//

#import "YViewController.h"
#import "YFoundation.h"
#import "MobClick.h"

#import <objc/runtime.h>

@implementation UIViewController (MethodSwizzling)

//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        {
//            Method originMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
//            Method swizzledMethod = class_getInstanceMethod([self class], @selector(swizzling_viewDidAppear:));
//            method_exchangeImplementations(originMethod, swizzledMethod);
//        }
//    });
//}
//
//- (void)swizzling_viewDidAppear:(BOOL)animated
//{
//    [self swizzling_viewDidAppear:animated];
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//}

@end


@interface YViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *lbTitle;

@end

@implementation YViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
    //title
    self.navigationController.navigationBar.barTintColor = [UIColor hexChangeFloat:@"455a64"];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated navigationBarHidden:(BOOL)navigationBarHidden tabBarHidden:(BOOL)tabBarHidden
{
    [super viewWillAppear:animated];
//    if (self.navigationController.navigationBarHidden != navigationBarHidden) {
//        [self.navigationController setNavigationBarHidden:navigationBarHidden animated:animated];
//    }
    self.navigationController.navigationBarHidden = navigationBarHidden;
    self.tabBarController.tabBar.hidden = tabBarHidden;
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (self.navigationController.navigationBarHidden) {
//        [self.navigationController setNavigationBarHidden:NO animated:animated];
//    }
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)initTitle
{
    _lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _lbTitle.font = [UIFont fontWithName:@"Helvetica" size:16.0f];
    _lbTitle.textColor = [UIColor whiteColor];
    _lbTitle.textAlignment = NSTextAlignmentCenter;
    _lbTitle.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.titleView = _lbTitle;
}


- (void)setTitle:(NSString *)title
{
    //[super setTitle:title];
    
    if (nil == _lbTitle)
    {
        [self initTitle];
    }
    
    _lbTitle.text = title;
}

- (void)onNavigationLeftButtonClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popViewController
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveControllerData
{
    
}

- (void)backControllerButton
{
    
}

- (void)nextController
{
    
}

- (void)showCustomNavigationBackButton
{
    //导航栏的左边按钮
    _navigationLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 9, 14)];
    [_navigationLeftButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [_navigationLeftButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateHighlighted];
    [_navigationLeftButton addTarget:self action:@selector(onNavigationLeftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navigationLeftButton];
}

- (void)showCustomNavigationBackButtonNoPop
{
    //导航栏的左边按钮
    _navigationLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 26)];
    [_navigationLeftButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [_navigationLeftButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateHighlighted];
    [_navigationLeftButton addTarget:self action:@selector(backControllerButton) forControlEvents:UIControlEventTouchUpInside];
    _navigationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navigationLeftButton];
}

- (void)showCustomNavigationCancelButton
{
    //导航栏的左边按钮
    _navigationLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 12)];
    [_navigationLeftButton setTitle:@"取消" forState:UIControlStateNormal];
    [_navigationLeftButton setTitleColor:[UIColor hexChangeFloat:@"F4453C"] forState:UIControlStateNormal];
    _navigationLeftButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_navigationLeftButton addTarget:self action:@selector(backControllerButton) forControlEvents:UIControlEventTouchUpInside];
    _navigationLeftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navigationLeftButton];
}

- (void)showCustomNavigationSaveButton
{
    [self showNomalNavigationRightButtonWithTitle:@"保存" action:@selector(saveControllerData)];
}

- (void)showCustomNavigationSendButton
{
    [self showNomalNavigationRightButtonWithTitle:@"发布" action:@selector(saveControllerData)];
}

- (void)showNomalNavigationRightButtonWithTitle:(NSString *)title action:(SEL)selector
{
    //right barbutton view
    _navigationRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_navigationRightButton setTitle:title forState:UIControlStateNormal];
    [_navigationRightButton setTitleColor:[UIColor hexChangeFloat:@"F4453C"] forState:UIControlStateNormal];
    [_navigationRightButton setTitleColor:[UIColor hexChangeFloat:@"494949"] forState:UIControlStateDisabled];
    _navigationRightButton.frame = CGRectMake(0, 0, 30, 60);
    _navigationRightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    [_navigationRightButton sizeToFit];
    [_navigationRightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnNavRightItem = [[UIBarButtonItem alloc] initWithCustomView:_navigationRightButton];
    self.navigationItem.rightBarButtonItem = btnNavRightItem;
}


- (void)showCustomNavigationNextButton
{
    //right barbutton view
    _navigationRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_navigationRightButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_navigationRightButton setTitleColor:[UIColor hexChangeFloat:@"F4453C"] forState:UIControlStateNormal];
    [_navigationRightButton setTitleColor:[UIColor hexChangeFloat:@"494949"] forState:UIControlStateDisabled];
    _navigationRightButton.frame = CGRectMake(0, 0, 50, 60);
    _navigationRightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    [_navigationRightButton addTarget:self action:@selector(nextController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnNavRightItem = [[UIBarButtonItem alloc] initWithCustomView:_navigationRightButton];
    self.navigationItem.rightBarButtonItem = btnNavRightItem;
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    [self.view endEditing:YES];
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer
//{
//    if ([gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class])
//    {
//        if ([self respondsToSelector:@selector(shouldBeginInteractivePopGesture)])
//        {
//            if(![self shouldBeginInteractivePopGesture])
//            {
//                return NO;
//            }
//        }
//        else if (self.navigationController.viewControllers.count == 1)
//        {
//            return NO;
//        }
//    }
//    [self.view endEditing:YES];
//    return YES;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    if ([gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class])
//    {
//       return YES;
//    }
//    return NO;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

@end
