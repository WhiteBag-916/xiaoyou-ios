//
//  ScheduleDetailViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScheduleDetailViewController.h"
#import "YCommonActionSheet.h"
#import "EditScheduleViewController.h"

#define K_IMG_LWH           SCALE_NUM(12)   //图标左、宽、高
#define K_COURSEIMG_T       SCALE_NUM(22)   //课程图标上间距
#define K_LECTURERIMG_T     SCALE_NUM(15)   //授课人图标上间距
#define K_DEPARTMENTSIMG_T  SCALE_NUM(14)   //院系图标上间距
#define K_LEFTLAB_L         SCALE_NUM(10)   //描述左
#define K_LEFTLAB_W         SCALE_NUM(70)   //描述宽
#define K_NAMELAB_L         SCALE_NUM(0)   //名字左
#define K_NAMELAB_R         SCALE_NUM(-12)   //名字右
#define K_ADD_T             SCALE_NUM(19)   //加日程上
#define K_ADD_R             SCALE_NUM(9)   //加日程上
#define K_ADD_H             SCALE_NUM(26)   //加日程高
#define K_ADD_W             SCALE_NUM(70)   //加日程宽
#define K_LOCATION_IMG_W    SCALE_NUM(9)   //地点图宽

@interface ScheduleDetailViewController ()

@property (nonatomic, strong) UILabel *courseName;          //课程名称
@property (nonatomic, strong) UILabel *lecturerName;        //授课人
@property (nonatomic, strong) UILabel *timeLabel;           //上课时间
@property (nonatomic, strong) UILabel *locationLabel;       //上课地点
@property (nonatomic, strong) UILabel *departmentsName;     //院系

@end

@implementation ScheduleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"日程详情";
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    
    [self initView];
}

- (void)initView {
    //课程
    UIImageView *courseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_classname"]];
    [self.view addSubview:courseImageView];
    
    [courseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(K_IMG_LWH);
        make.top.mas_equalTo(K_COURSEIMG_T);
    }];
    
    UILabel *courseLabel = [YUtils initLabel:CONTENT_FONT(12)
                                       color:KCOLORGREEN_B5
                                        text:@"课程名称："
                                   alignment:NSTextAlignmentLeft];
    [self.view addSubview:courseLabel];
    
    [courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(courseImageView);
        make.left.equalTo(courseImageView.mas_right).offset(K_LEFTLAB_L);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _courseName = [YUtils initLabel:CONTENT_FONT(12)
                              color:KCOLORGREEN_B3
                               text:@"大学汉语"
                          alignment:NSTextAlignmentLeft];
    [self.view addSubview:_courseName];
    
    //授课人
    UIImageView *lecturerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_teacher"]];
    [self.view addSubview:lecturerImageView];
    
    [lecturerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(courseImageView.mas_bottom).offset(K_LECTURERIMG_T);
    }];
    
    UILabel *lecturerLabel = [YUtils initLabel:CONTENT_FONT(12)
                                         color:KCOLORGREEN_B5
                                          text:@"授课人："
                                     alignment:NSTextAlignmentLeft];
    [self.view addSubview:lecturerLabel];
    
    [lecturerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(lecturerImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _lecturerName = [YUtils initLabel:CONTENT_FONT(12)
                                color:KCOLORGREEN_B3
                                 text:@"王中磊"
                            alignment:NSTextAlignmentLeft];
    [self.view addSubview:_lecturerName];
    
    [_lecturerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(lecturerImageView);
        make.left.equalTo(lecturerLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //上课时间
    UIImageView *timeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_time"]];
    [self.view addSubview:timeImageView];
    
    [timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(lecturerImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *timeLeftLabel = [YUtils initLabel:CONTENT_FONT(12)
                                         color:KCOLORGREEN_B5
                                          text:@"上课时间："
                                     alignment:NSTextAlignmentLeft];
    [self.view addSubview:timeLeftLabel];
    
    [timeLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(timeImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _timeLabel = [YUtils initLabel:CONTENT_FONT(12)
                             color:KCOLORGREEN_B3
                              text:@"今天 09:00-10:30"
                         alignment:NSTextAlignmentLeft];
    [self.view addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(timeLeftLabel);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //上课地点
    UIImageView *locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"build_icon_location"]];
    [self.view addSubview:locationImageView];
    
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(courseImageView);
        make.centerX.equalTo(courseImageView.mas_centerX);
        make.width.mas_equalTo(K_LOCATION_IMG_W);
        make.top.equalTo(timeImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *locationLeftLabel = [YUtils initLabel:CONTENT_FONT(12)
                                             color:KCOLORGREEN_B5
                                              text:@"上课地点："
                                         alignment:NSTextAlignmentLeft];
    [self.view addSubview:locationLeftLabel];
    
    [locationLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(locationImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _locationLabel = [YUtils initLabel:CONTENT_FONT(12)
                                 color:KCOLORGREEN_B3
                                  text:@"5号教学楼 5132室"
                             alignment:NSTextAlignmentLeft];
    [self.view addSubview:_locationLabel];
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(locationLeftLabel);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //院系
    UIImageView *departmentsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_academy"]];
    [self.view addSubview:departmentsImageView];
    
    [departmentsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(locationImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *departmentsLabel = [YUtils initLabel:CONTENT_FONT(12)
                                            color:KCOLORGREEN_B5
                                             text:@"院系："
                                        alignment:NSTextAlignmentLeft];
    [self.view addSubview:departmentsLabel];
    
    [departmentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(departmentsImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _departmentsName = [YUtils initLabel:CONTENT_FONT(12)
                                   color:KCOLORGREEN_B3
                                    text:@"汉语言文学系"
                               alignment:NSTextAlignmentLeft];
    [self.view addSubview:_departmentsName];
    
    [_departmentsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(departmentsImageView);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    [_courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(courseImageView);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
}


- (void)onNavigationRightButtonClicked {
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"编辑活动"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self toEdit];
                                                        }];
    
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"删除活动"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] title:nil];
    [sheet show];
}

//删除活动
- (void)delSchedule {
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil message:@"确定删除此日程吗？" buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        [alert hide];
        if (index == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alert show];
}

//跳转至编辑活动
- (void)toEdit {
    EditScheduleViewController *vc = [[EditScheduleViewController alloc] init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
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
