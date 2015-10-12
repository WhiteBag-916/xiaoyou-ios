//
//  FunnyViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityListView.h"
#import "YNavigationController.h"
#import "SetupTableViewController.h"
#import "RemindViewController.h"
#import "ScheduleViewController.h"
#import "ActivityChoiceController.h"

@interface ActivityViewController ()
@property (nonatomic,strong) ActivityListView *funnyList;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpCustomNavgationBar];
    [self funnyList];
}


-(ActivityListView *)funnyList
{
    if (!_funnyList) {
        _funnyList = [[ActivityListView alloc]init];
        [self.view addSubview:_funnyList];
        [_funnyList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _funnyList;
}

-(void)setUpCustomNavgationBar {
    //right barbutton view
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 95, KNavigationBarheight)];
    
    UIButton *setupButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, KNavigationBarheight)];
    [setupButton setImage:[UIImage imageNamed:@"bar_setup"] forState:UIControlStateNormal];
    [setupButton addTarget:self
                     action:@selector(setupBtnAction)
           forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:setupButton];
    
    UIButton * remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, 0, 25, KNavigationBarheight)];
    [remindBtn setImage:[UIImage imageNamed:@"bar_bell"] forState:UIControlStateNormal];
    [remindBtn addTarget:self
                  action:@selector(filterAction)
        forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:remindBtn];
    
    UIButton * scheduleBtn = [[UIButton alloc] initWithFrame:CGRectMake(70, 0, 25, KNavigationBarheight)];
    [scheduleBtn setImage:[UIImage imageNamed:@"bar_time"] forState:UIControlStateNormal];
    [scheduleBtn addTarget:self
                  action:@selector(scheduleAction)
        forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:scheduleBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

//发布Action
-(void)setupBtnAction {
    SetupTableViewController *setupVC = [[SetupTableViewController alloc] init];
    [self.navigationController pushViewController:setupVC animated:YES needHiddenBottomBar:YES];
}

//筛选Action
-(void)filterAction {
    RemindViewController *vc = [[RemindViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
   
}

//日程
-(void)scheduleAction {
    
    ActivityChoiceController *choiceVC = [[ActivityChoiceController alloc]init];
    [self.navigationController pushViewController:choiceVC animated:YES needHiddenBottomBar:YES];
    //ScheduleViewController *scheduleVC = [[ScheduleViewController alloc]init];
    //[self.navigationController pushViewController:scheduleVC animated:YES needHiddenBottomBar:YES];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
