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
    [self showOrignMode];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated navigationBarHidden:(BOOL)navigationBarHidden tabBarHidden:(BOOL)tabBarHidden
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
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
- (void)showOrignMode {
    self.navigationController.navigationBar.barTintColor = [UIColor hexChangeFloat:@"455964"];
    _lbTitle.textColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:true];
}
- (void)showEditMode {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    _lbTitle.textColor = [UIColor blackColor];
    [self showNomalNavigationLeftButton:@"" action:@selector(onNavigationLeftButtonClicked) imgName:@"mine-cancel" frame:CGRectMake(0, 0, 15, 15)];
    [self showNomalNavigationRightButtonWithImage:@"" action:@selector(onNavigationRightButtonClicked) imgName:@"mine-complete-grey" frame:CGRectMake(0, 0, 20, 15)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:true];
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
    [self showNomalNavigationRightButtonWithImage:@"" action:@selector(onNavigationRightButtonClicked) imgName:@"feed-find-someone-search" frame:CGRectMake(0, 0, 42, 64)];
}

//导航栏右侧，更多按钮
- (void)showCustomNavigationMoreButton {
    [self showNomalNavigationRightButtonWithImage:@"" action:@selector(onNavigationRightButtonClicked) imgName:@"more" frame:CGRectMake(0, 0, 18, 64)];
}

//导航栏右侧，确认按钮
- (void)showCustomNavigationSureButton {
    [self showNomalNavigationRightButtonWithImage:@"" action:@selector(onNavigationRightButtonClicked) imgName:@"complete" frame:CGRectMake(0, 0, 20, 15)];
}
//导航栏右侧，发布按钮
- (void)showCustomNavigationPublishButton {
    [self showNomalNavigationRightButtonWithImage:@"" action:@selector(onNavigationRightButtonClicked) imgName:@"mine-publisher" frame:CGRectMake(0, 0, 18, 64)];
}

//导航栏右侧，Fast按钮
- (void)showCustomNavigationFastButton {
    [self showNomalNavigationRightButtonWithImage:@"" action:@selector(onNavigationRightButtonClicked) imgName:@"fast_add_white" frame:CGRectMake(0, 0, 20, 20)];
}

//导航栏右侧下一步按钮
- (void)showCustomNavigationNextButton {
    [self showNomalNavigationRightButtonWithImage:@"下一步" action:@selector(onNavigationRightButtonClicked) imgName:nil frame:CGRectMake(0, 0, 20, 15)];
}

- (void)showCustomNavigationConfirmButton {
    [self showNomalNavigationRightButtonWithImage:@"确定" action:@selector(onNavigationRightButtonClicked) imgName:nil frame:CGRectMake(0, 0, 20, 15)];
}

//导航栏左侧提醒按钮
- (void)showCustomNavigationRemindButton {
    [self showNomalNavigationLeftButton:@"" action:@selector(onNavigationLeftButtonClicked) imgName:@"have_time_msg" frame:CGRectMake(0, 0, 16, 16)];
}

- (void)showNomalNavigationRightButtonWithImage:(NSString *)title action:(SEL)selector imgName:(NSString *)imgName frame:(CGRect)frame {
    //right barbutton view
    _navigationRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _navigationRightButton.frame = frame;
    if (nil != imgName)
    {
        [_navigationRightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [_navigationRightButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    }
    else
    {
        [_navigationRightButton setTitle:title forState:UIControlStateNormal];
        [_navigationRightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_navigationRightButton setTitleColor:[UIColor hexChangeFloat:@"c3c9c9"] forState:UIControlStateDisabled];
        _navigationRightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
        [_navigationRightButton sizeToFit];
    }

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
