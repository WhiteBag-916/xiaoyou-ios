//
//  AvailableController.m
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AvailableViewController.h"
#import "AvailableListView.h"
#import "ActivityReleaseController.h"
#import "RemindViewController.h"
#import "ActivityChoiceController.h"
#import "AppConfigData.h"
#import "ActivityChoiceController.h"
@interface AvailableViewController ()

@property (nonatomic,strong) AvailableListView *availableListView;

@property (nonatomic,strong) UIView         *promptView;        //提示透明背景
@property (nonatomic,strong) UIImageView    *guideImageView;    //提示图片
@property (nonatomic,assign) int            guideIndex;        //当前提示索引

@end

@implementation AvailableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"有空";
    if([AppConfigData isUserFirstUseHaveTime])
        [self addGuideView];
    [self setUpCustomNavgationBar];
    [self availableListView];
}


- (void)addGuideView {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSString *imageName = @"1havetime_box_calender";
    UIImage *image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _guideImageView = [[UIImageView alloc] initWithImage:image];
    _guideImageView.alpha = 1;
    [window addSubview:_guideImageView];
    
    
    [_guideImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    _guideImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissGuideView)];
    [_guideImageView addGestureRecognizer:tap1];
    self.guideIndex = 1;
}

- (void)nextPromptView {
    _guideImageView.image = [UIImage imageNamed:@"1havetime_box_classroom"];
    self.guideIndex = 2;
}

-(void)dismissGuideView {
    if (self.guideIndex == 1) {
        [self nextPromptView];
    }
    else if (self.guideIndex == 2) {
        [_guideImageView removeFromSuperview];
        [_promptView removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AvailableListView *)availableListView
{
    if (!_availableListView) {
        _availableListView = [[AvailableListView alloc]init];
        [self.view addSubview:_availableListView];
        [_availableListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [_availableListView loadData];
    }
    
    return _availableListView;
}

-(void)setUpCustomNavgationBar {
    //right barbutton view
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 95, KNavigationBarheight)];
    
    UIButton *setupButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, KNavigationBarheight)];
    [setupButton setImage:[UIImage imageNamed:@"have_time_publish"] forState:UIControlStateNormal];
    [setupButton addTarget:self
                    action:@selector(publishAction)
          forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:setupButton];
    
    UIButton * remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, 0, 25, KNavigationBarheight)];
    [remindBtn setImage:[UIImage imageNamed:@"have_time_select"] forState:UIControlStateNormal];
    [remindBtn addTarget:self
                  action:@selector(filterAction)
        forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:remindBtn];
    
    UIButton * scheduleBtn = [[UIButton alloc] initWithFrame:CGRectMake(70, 0, 25, KNavigationBarheight)];
    [scheduleBtn setImage:[UIImage imageNamed:@"have_time_search"] forState:UIControlStateNormal];
    [scheduleBtn addTarget:self
                    action:@selector(scheduleAction)
          forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:scheduleBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    [self showCustomNavigationRemindButton];
}

//发布Action
-(void)publishAction {
    ActivityReleaseController *activityVC = [[ActivityReleaseController alloc]init];
    [self.navigationController pushViewController:activityVC animated:YES needHiddenBottomBar:YES];
}

//筛选Action
-(void)filterAction {
    ActivityChoiceController *choiceVC = [[ActivityChoiceController alloc]initWithType:ACTIVITY_CHOICE_TYPE];
    choiceVC.superViewController = self;
    [self.navigationController presentViewController:choiceVC animated:YES completion:nil];
}

//日程
-(void)scheduleAction {
    //ActivityChoiceController *choiceVC = [[ActivityChoiceController alloc]init];
    //[self.navigationController pushViewController:choiceVC animated:YES needHiddenBottomBar:YES];
    //ScheduleViewController *scheduleVC = [[ScheduleViewController alloc]init];
    //[self.navigationController pushViewController:scheduleVC animated:YES needHiddenBottomBar:YES];
}


#pragma mark 协议方法
-(void)onNavigationLeftButtonClicked
{
    RemindViewController *remindVC = [[RemindViewController alloc]init];
    //[self.navigationController presentViewController:remindVC animated:YES completion:nil];
    [self.navigationController pushViewController:remindVC animated:YES needHiddenBottomBar:YES];
}


#pragma mark 避免返回的时候TabBar消失
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

@end
