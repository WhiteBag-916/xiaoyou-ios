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
#import "ActivityModel.h"
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
        [_availableListView loadMyData];
    }
    _availableListView.myDataSource = [self getDataSource];
    return _availableListView;
}


-(NSArray*)getDataSource
{
    ActivityModel *m1 = [[ActivityModel alloc]init];
    m1.acTitle = @"立艺为民 严以用权：仇立权廉政艺术绘画展";
    m1.acBrief = @"活动简介：在习近平总书记延安文艺工作座谈会讲话一周年之时，在举国上下全力推进从严治党、反腐倡廉的进程中，我校党委宣传部、纪检/监察处于10月23日至30日在宁远楼一层大厅，联合举办“立艺为民 严以用权——仇立权廉政艺术绘画展”。仇立权，毕业于中央工艺美术学院，现为中国国家画院刘大为工作室画家、刘大为工作室学术委员会委员、中国民主同盟盟员、通哲斋艺术馆馆长。擅长画人物、大写意动物，风格独树一帜，画作形神兼备，出版有《仇立权•感受与激情•人物动物速写》、《仇立权藏獒画册》、《仇立权人物画册》等多部绘画作品集，多次在国家博物馆、国家画院美术馆等举办画展。";
    m1.acPhotos = @"/dev/activity/52dfcb472d12c53dce33d6c85fbc152dc361b15310ba0-ApYcri_fw658.jpeg";
    m1.acLocation = @"北院礼堂";
    m1.acOgnazier = @"校团委";
    
    
    ActivityModel *m2 = [[ActivityModel alloc]init];
    m2.acTitle = @"西班牙风情文化介绍：西班牙建筑风格";
    m2.acBrief = @"活动简介：西班牙建筑风格，一般人认为是有庭院和纯白墙面，但这两个特点并不仅仅是西班牙建筑的特点，差不多地中海沿岸国家、中近东地区以至整个阿拉伯世界的建筑似乎都有着类似特征。那么，到底什么才是“西班牙建筑风格”，或许我们并不能用一句话或者是一个定义来作为衡量标准，建筑是文化的符号，建筑是凝固的艺术。米拉之家又叫米拉公寓，建于1906年-1912年间，是高迪设计的最后一个私人住宅。当时是富豪米拉先生因为非常欣赏高迪设计的巴特罗之家，所以也请高迪为自己的住宅做了设计。建筑是凝固的艺术，所以谈西班牙建筑离不开西班牙历史、文化及西班牙艺术。艺术来源于文化，独特的文化背景孕育了多元、神秘、奇异为特征的西班牙艺术，也孕育了别具一格的西班牙建筑风格。";
    m2.acPhotos = @"/dev/activity/bb0752f7564031bdd07b6a7a2d7390c34794710af4fa-uZz3ll_fw658.jpeg";
    m2.acLocation = @"大学生活动中心";
    m2.acOgnazier = @"外语学院组织部";
    
    
    ActivityModel *m3 = [[ActivityModel alloc]init];
    m3.acTitle = @"2015级新生心理健康教育讲座";
    m3.acBrief = @"活动简介：题为《过好大学每一天》的讲座。讲座围绕“和过去说再见”、“和现在说你好”、“学会拥有自信”、“学会珍爱自己”和“学会珍爱生命”五个方面展开。此次讲座是我校新生心理健康教育系列活动之一，配合此次讲座，我校还为新生提供了一系列心理健康宣传材料以帮助新生了解心理咨询服务、关注自身心理健康，为新同学在心理上尽快适应大学生活奠定了良好的基础。";
    m3.acPhotos = @"/dev/activity/7dbe607ed7062433d79039c33c50db38d9f7d5ef75f2d-JPP1Do_fw658.jpeg";
    m3.acLocation = @"中央教学楼1007教室";
    m3.acOgnazier = @"心理健康协会";
    
    return [NSArray arrayWithObjects:m1,m2,m3,nil];
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
    ActivityIdentityViewController *activityVC = [[ActivityIdentityViewController alloc]init];
    //[self.navigationController pushViewController:activityVC animated:YES needHiddenBottomBar:YES];
    activityVC.availableViewController = self;
    [self presentViewController:activityVC animated:YES completion:nil];
}

//筛选Action
-(void)filterAction {
    ActivityChoiceController *choiceVC = [[ActivityChoiceController alloc]initWithType:ACTIVITY_CHOICE_TYPE];
    choiceVC.activityViewController = self;
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
