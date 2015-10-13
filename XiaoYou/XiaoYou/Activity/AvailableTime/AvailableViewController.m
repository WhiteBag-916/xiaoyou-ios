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

@interface AvailableViewController ()

@property (nonatomic,strong) AvailableListView *availableListView;

@end

@implementation AvailableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpCustomNavgationBar];
    [self availableListView];
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
    ActivityChoiceController *choiceVC = [[ActivityChoiceController alloc]init];
    [self.navigationController pushViewController:choiceVC animated:YES needHiddenBottomBar:YES];
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
    [self.navigationController pushViewController:remindVC animated:YES needHiddenBottomBar:YES];
}


#pragma mark 避免返回的时候TabBar消失
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

@end
