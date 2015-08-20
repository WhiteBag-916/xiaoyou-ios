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
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

- (void)onNavigationLeftButtonClicked
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onNavigationRightButtonClicked {
    
}

#pragma mark - 左导航栏
- (void)showCustomNavigationBackButton
{
    [self showNomalNavigationLeftButton:@"" action:@selector(onNavigationLeftButtonClicked) imgName:@"common_back" frame:CGRectMake(0, 0, 9, 14)];
}

//导航栏左侧显示取消按钮
- (void)showCustomNavigationCancelButton {
    [self showNomalNavigationLeftButton:@"" action:@selector(onNavigationLeftButtonClicked) imgName:@"complete-cancel" frame:CGRectMake(0, 0, 16, 16)];
}

- (void)showNomalNavigationLeftButton:(NSString *)title action:(SEL)selector imgName:(NSString *)imgName frame:(CGRect)frame
{
    //right barbutton view
    _navigationLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _navigationLeftButton = [[UIButton alloc] initWithFrame:frame];
    if (nil != imgName)
    {
        [_navigationLeftButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [_navigationLeftButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    }
    else
    {
        [_navigationLeftButton setTitle:title forState:UIControlStateNormal];
        [_navigationLeftButton setTitleColor:[UIColor hexChangeFloat:@"F4453C"] forState:UIControlStateNormal];
        [_navigationLeftButton setTitleColor:[UIColor hexChangeFloat:@"494949"] forState:UIControlStateDisabled];
        _navigationLeftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
        [_navigationLeftButton sizeToFit];
    }
    [_navigationLeftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnNavLeftItem = [[UIBarButtonItem alloc] initWithCustomView:_navigationLeftButton];
    self.navigationItem.leftBarButtonItem = btnNavLeftItem;
}

#pragma mark - 右导航栏
//导航栏右侧，搜索按钮
- (void)showCustomNavigationSearchButton {
    [self showNomalNavigationRightButtonWithImage:@"feed-find-someone-search" action:@selector(onNavigationRightButtonClicked) frame:CGRectMake(0, 0, 42, 64)];
}

//导航栏右侧，更多按钮
- (void)showCustomNavigationMoreButton {
    [self showNomalNavigationRightButtonWithImage:@"more" action:@selector(onNavigationRightButtonClicked) frame:CGRectMake(0, 0, 30, 64)];
}

//导航栏右侧，确认按钮
- (void)showCustomNavigationSureButton {
    [self showNomalNavigationRightButtonWithImage:@"complete-grey" action:@selector(onNavigationRightButtonClicked) frame:CGRectMake(0, 0, 20, 64)];
}
//导航栏右侧，确认按钮
- (void)showCustomNavigationPublishButton {
    [self showNomalNavigationRightButtonWithImage:@"complete-grey" action:@selector(onNavigationRightButtonClicked) frame:CGRectMake(0, 0, 20, 64)];
}

- (void)showNomalNavigationRightButtonWithImage:(NSString *)image action:(SEL)selector frame:(CGRect)frame {
    //right barbutton view
    _navigationRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_navigationRightButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [_navigationRightButton setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    _navigationRightButton.frame = frame;
    [_navigationRightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
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
