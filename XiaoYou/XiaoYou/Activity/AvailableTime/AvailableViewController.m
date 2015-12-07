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
#import "ActivityIdentityViewController.h"
#import "AssociationsSearchViewController.h"
#import "ActivityManager.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"
#import "Tags.h"
#import "YNotificationDefine.h"
#import "YBaseService.h"
#import "NotifyInfoModel.h"

@interface AvailableViewController ()

@property (nonatomic,strong) AvailableListView *availableListView;

@property (nonatomic,strong) UIView         *promptView;        //提示透明背景
@property (nonatomic,strong) UIImageView    *guideImageView;    //提示图片
@property (nonatomic,assign) int            guideIndex;         //当前提示索引
@property (nonatomic,strong) UIButton       *leftNavBar;        //左边导航条

@end

@implementation AvailableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"有空";
    if([AppConfigData isUserFirstUseHaveTime]) {
        [self addGuideView];
    }
    
    [self setUpCustomNavgationBar];
    [self.availableListView loadData];
    
    [self setMyLeftNavBar];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)receiveNotificationOfReleaseSuccess
{
    [_availableListView loadData];
}


-(void)setMyLeftNavBar
{
    _leftNavBar = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftNavBar.frame = CGRectMake(0, 0, 30, 30);
    [_leftNavBar setImage:[[UIImage imageNamed:@"have_time_msg"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                 forState:UIControlStateNormal];
    [_leftNavBar setImage:[[UIImage imageNamed:@"have_time_msg"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                 forState:UIControlStateHighlighted];
    UIBarButtonItem *btnNavLeftItem = [[UIBarButtonItem alloc] initWithCustomView:_leftNavBar];
    [_leftNavBar addTarget:self action:@selector(onNavigationLeftButtonClicked)
          forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNavLeftItem;
}

- (void)addGuideView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSString *imageName = @"1havetime_box_calender";
    UIImage *image = [[UIImage imageNamed:imageName]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _guideImageView = [[UIImageView alloc] initWithImage:image];
    _guideImageView.alpha = 1;
    [window addSubview:_guideImageView];
    
    [_guideImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window);
    }];
    
    _guideImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self action:@selector(dismissGuideView)];
    [_guideImageView addGestureRecognizer:tap1];
    self.guideIndex = 1;
}


#pragma mark 蒙层引导
//显示下一个蒙层
- (void)nextPromptView {
    _guideImageView.image = [UIImage imageNamed:@"1havetime_box_classroom"];
    self.guideIndex = 2;
}
//显示第一次显示蒙层
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
    }
    return _availableListView;
}


-(void)setUpCustomNavgationBar {
    //right barbutton view
    UIButton *setupButton = [[UIButton alloc]
                             initWithFrame:CGRectMake(0, 0, 22, KNavigationBarheight)];
    [setupButton setImage:[UIImage imageNamed:@"have_time_search"] forState:UIControlStateNormal];
    [setupButton addTarget:self
                    action:@selector(searchAction)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *setupButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setupButton];
    
    UIButton * remindBtn = [[UIButton alloc]
                            initWithFrame:CGRectMake(22, 0, 22, KNavigationBarheight)];
    [remindBtn setImage:[UIImage imageNamed:@"have_time_select"] forState:UIControlStateNormal];
    [remindBtn addTarget:self
                  action:@selector(filterAction)
        forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *remindButtonItem = [[UIBarButtonItem alloc] initWithCustomView:remindBtn];
    
    UIButton * scheduleBtn = [[UIButton alloc]
                              initWithFrame:CGRectMake(44, 0, 22, KNavigationBarheight)];
    [scheduleBtn setImage:[UIImage imageNamed:@"have_time_publish"] forState:UIControlStateNormal];
    [scheduleBtn addTarget:self
                    action:@selector(publishAction)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *scheduleButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scheduleBtn];
    
    self.navigationItem.rightBarButtonItems = @[setupButtonItem, remindButtonItem, scheduleButtonItem];
    
    //[self showCustomNavigationRemindButton:[AppConfigData isHaveRemindMessage]];
    //[AppConfigData setHaveRemindMessage:NO];
    
}



//发布Action
-(void)publishAction {
    [YAnalysis trackEvent:@"发布活动" withPara:nil];
    NSArray * groupArr =[[ProvisionManager sharedInstance] getProfile].managerGroups;
    if (groupArr.count > 0)
    {
        ActivityIdentityViewController *activityVC = [[ActivityIdentityViewController alloc]init];
        activityVC.availableViewController = self;
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    else
    {
        ActivityReleaseController *releaseVC = [[ActivityReleaseController alloc]initWithIsIdentity:NO];
        [self.navigationController pushViewController:releaseVC animated:YES needHiddenBottomBar:YES];
    }
}

//筛选Action
-(void)filterAction {
    [YAnalysis trackEvent:@"筛选活动" withPara:nil];
    ActivityChoiceController *choiceVC = [[ActivityChoiceController alloc]
                                          initWithType:ACTIVITY_CHOICE_TYPE
                                          andDataSource:nil andStudyRoomDefautStr:nil];
    choiceVC.activityViewController = self;
    [self.view.window.rootViewController presentViewController:choiceVC animated:YES completion:nil];
}

//搜索🔍
-(void)searchAction {
    [YAnalysis trackEvent:@"查找活动" withPara:nil];
    AssociationsSearchViewController *searchVC = [[AssociationsSearchViewController alloc]init];
    searchVC.searchType = ACTIVITY_TYPE;
    [self.navigationController pushViewController:searchVC animated:YES needHiddenBottomBar:YES];
}


#pragma mark 协议方法,铃铛变灰
-(void)onNavigationLeftButtonClicked
{
    [YAnalysis trackEvent:@"铃铛提醒" withPara:nil];
    RemindViewController *remindVC = [[RemindViewController alloc]init];
    [self.navigationController pushViewController:remindVC animated:YES needHiddenBottomBar:YES];
    
    [_leftNavBar setImage:[[UIImage imageNamed:@"have_time_msg"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                 forState:UIControlStateNormal];
    [_leftNavBar setImage:[[UIImage imageNamed:@"have_time_msg"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                 forState:UIControlStateHighlighted];
}


#pragma mark 避免返回的时候TabBar消失
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotificationOfReleaseSuccess)
                                                 name:KNotification_Activity_Release_Success
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotificationOfRemindMessage)
                                                 name:KNotification_Remind_Message_Come
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotificationOfRemindPushNotify)
                                                 name:KNotification_Push_Notify_Message_Come
                                               object:nil];
}

//收到推送消息 铃铛变红 have_time_msg
-(void)receiveNotificationOfRemindMessage
{
    [_leftNavBar setImage:[[UIImage imageNamed:@"red_point_bell"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_leftNavBar setImage:[[UIImage imageNamed:@"red_point_bell"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                 forState:UIControlStateHighlighted];
}

//刷新第一个cell,只能在主线程更新UI
-(void)receiveNotificationOfRemindPushNotify
{
    [self.availableListView performSelectorOnMainThread:@selector(reloadNotifyMessageWithTableView)
                                             withObject:nil
                                          waitUntilDone:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
    [super viewWillDisappear:animated];
    
    
}
@end
