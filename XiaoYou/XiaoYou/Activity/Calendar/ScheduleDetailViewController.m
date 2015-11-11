//
//  ScheduleDetailViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScheduleDetailViewController.h"
#import "YCommonActionSheet.h"
#import "NewScheduleViewController.h"
#import "UserSchedulingInfo.h"
#import "ActivityManager.h"
#import "CurriculumManager.h"
#import "CourseDetail.h"

#define K_IMG_LWH           SCALE_NUM(12)   //图标左、宽、高
#define K_COURSEIMG_T       SCALE_NUM(22)   //课程图标上间距
#define K_LECTURERIMG_T     SCALE_NUM(15)   //授课人图标上间距
#define K_DEPARTMENTSIMG_T  SCALE_NUM(14)   //开课单位图标上间距
#define K_LEFTLAB_L         SCALE_NUM(10)   //描述左
#define K_LEFTLAB_W         SCALE_NUM(70)   //描述宽
#define K_NAMELAB_L         SCALE_NUM(0)   //名字左
#define K_NAMELAB_W         SCALE_NUM(80)   //名字左
#define K_NAMELAB_R         SCALE_NUM(-15)   //名字右
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
@property (nonatomic, strong) UILabel *departmentsName;     //开课单位

@property (nonatomic, strong) UIImageView *departmentsImageView;
@property (nonatomic, strong) UILabel *locationLeftLabel;

@property (nonatomic, strong) CourseDetail *courseDetail;//课程
@property (nonatomic, strong) UserSchedulingInfo *userSchedulingInfo;

@end

@implementation ScheduleDetailViewController

- (id)initWithInfo:(UserSchedulingInfo *)info {
    if (self = [super init]) {
        self.userSchedulingInfo = info;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    
    [self initData];
    [self initView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScheduleDetail:) name:KNotification_Change_Schedule object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initSchedulingView {
    [self showCustomNavigationMoreButton];
    
    //课程
    UILabel *courseLabel = [YUtils initLabel:CONTENT_FONT(14)
                                       color:KCOLOR_B3
                                        text:@"日程名称："
                                   alignment:NSTextAlignmentLeft];
    [self.view addSubview:courseLabel];
    
    [courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(K_IMG_LWH);
        make.top.mas_equalTo(K_COURSEIMG_T);
        make.width.mas_equalTo(K_NAMELAB_W);
    }];
    
    _courseName = [YUtils initLabel:CONTENT_FONT(14)
                              color:KCOLOR_B4
                               text:_userSchedulingInfo.content
                          alignment:NSTextAlignmentLeft];
    _courseName.numberOfLines = 0;
    [self.view addSubview:_courseName];
    
    [_courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(courseLabel);
        make.left.equalTo(courseLabel.mas_right);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //line
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = KCOLOR_B2;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_courseName.mas_bottom).offset(K_LECTURERIMG_T);
        make.left.equalTo(courseLabel);
        make.right.equalTo(_courseName);
        make.height.mas_equalTo(SCALE_NUM(1));
    }];
    
    //授课人
    UIImageView *lecturerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_time"]];
    [self.view addSubview:lecturerImageView];
    
    [lecturerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(K_IMG_LWH);
        make.top.equalTo(lineView.mas_bottom).offset(K_LECTURERIMG_T);
    }];
    
    UILabel *lecturerLabel = [YUtils initLabel:CONTENT_FONT(12)
                                         color:KCOLOR_B5
                                          text:@"开始时间："
                                     alignment:NSTextAlignmentLeft];
    [self.view addSubview:lecturerLabel];
    
    [lecturerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lecturerImageView);
        make.left.equalTo(lecturerImageView.mas_right).offset(K_LEFTLAB_L);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _lecturerName = [YUtils initLabel:CONTENT_FONT(12)
                                color:KCOLOR_B3
                                 text:@""
                            alignment:NSTextAlignmentLeft];
    [self.view addSubview:_lecturerName];
    
    [_lecturerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lecturerImageView);
        make.left.equalTo(lecturerLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //上课时间
    UILabel *timeLeftLabel = [YUtils initLabel:CONTENT_FONT(12)
                                         color:KCOLOR_B5
                                          text:@"结束时间："
                                     alignment:NSTextAlignmentLeft];
    [self.view addSubview:timeLeftLabel];
    
    [timeLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lecturerImageView.mas_bottom).offset(K_LECTURERIMG_T);
        make.left.height.equalTo(lecturerLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _timeLabel = [YUtils initLabel:CONTENT_FONT(12)
                             color:KCOLOR_B3
                              text:@""
                         alignment:NSTextAlignmentLeft];
    [self.view addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLeftLabel);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //上课地点
    UIImageView *locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"build_icon_location"]];
    locationImageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:locationImageView];
    
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(lecturerImageView);
        make.top.equalTo(timeLeftLabel.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    _locationLeftLabel = [YUtils initLabel:CONTENT_FONT(12)
                                             color:KCOLOR_B5
                                              text:@"日程地点："
                                         alignment:NSTextAlignmentLeft];
    [self.view addSubview:_locationLeftLabel];
    
    [_locationLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(locationImageView);
        make.left.equalTo(lecturerLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _locationLabel = [YUtils initLabel:CONTENT_FONT(12)
                                 color:KCOLOR_B3
                                  text:_userSchedulingInfo.address
                             alignment:NSTextAlignmentLeft];
    _locationLabel.numberOfLines = 0;
    [self.view addSubview:_locationLabel];
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(locationImageView);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //开课单位
    _departmentsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_remind"]];
    [self.view addSubview:_departmentsImageView];
    
    [_departmentsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(locationImageView);
        make.top.equalTo(_locationLabel.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *departmentsLabel = [YUtils initLabel:CONTENT_FONT(12)
                                            color:KCOLOR_B5
                                             text:@"提醒时间："
                                        alignment:NSTextAlignmentLeft];
    [self.view addSubview:departmentsLabel];
    
    [departmentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_departmentsImageView);
        make.left.equalTo(lecturerLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _departmentsName = [YUtils initLabel:CONTENT_FONT(12)
                                   color:KCOLOR_B3
                                    text:[[ActivityManager sharedInstance] remindTextByTime:_userSchedulingInfo.noticeTimePeriod]
                               alignment:NSTextAlignmentLeft];
    [self.view addSubview:_departmentsName];
    
    [_departmentsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_departmentsImageView);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
}

- (void)resetSchedulingView {
    _courseName.text = _userSchedulingInfo.content;
    NSDate *beginTime = [NSDate dateWithTimeIntervalSince1970:_userSchedulingInfo.startTime/1000];
    _lecturerName.text = [NSDate stringFromDate:beginTime withFormat:@"yy/MM/dd HH:mm"];
    NSDate *endTime = [NSDate dateWithTimeIntervalSince1970:_userSchedulingInfo.endTime/1000];
    _timeLabel.text = [NSDate stringFromDate:endTime withFormat:@"yy/MM/dd HH:mm"];
    if (_userSchedulingInfo.address.length <= 0) {
        [_departmentsImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_locationLeftLabel.mas_bottom).offset(K_DEPARTMENTSIMG_T);;
        }];
    }
    _locationLabel.text = _userSchedulingInfo.address;
    _departmentsName.text = [[ActivityManager sharedInstance] remindTextByTime:_userSchedulingInfo.noticeTimePeriod];
}

- (void)initCourseView {
    //课程
    UIImageView *courseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_classname"]];
    [self.view addSubview:courseImageView];
    
    [courseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(K_IMG_LWH);
        make.top.mas_equalTo(K_COURSEIMG_T);
    }];
    
    UILabel *courseLabel = [YUtils initLabel:CONTENT_FONT(12)
                                       color:KCOLOR_B5
                                        text:@"课程名称："
                                   alignment:NSTextAlignmentLeft];
    [self.view addSubview:courseLabel];
    
    [courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(courseImageView);
        make.left.equalTo(courseImageView.mas_right).offset(K_LEFTLAB_L);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _courseName = [YUtils initLabel:CONTENT_FONT(12)
                              color:KCOLOR_B3
                               text:_courseDetail.courseName
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
                                         color:KCOLOR_B5
                                          text:@"授课教师："
                                     alignment:NSTextAlignmentLeft];
    [self.view addSubview:lecturerLabel];
    
    [lecturerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lecturerImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _lecturerName = [YUtils initLabel:CONTENT_FONT(12)
                                color:KCOLOR_B3
                                 text:_courseDetail.teacherName
                            alignment:NSTextAlignmentLeft];
    [self.view addSubview:_lecturerName];
    
    [_lecturerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lecturerImageView);
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
                                         color:KCOLOR_B5
                                          text:@"上课时间："
                                     alignment:NSTextAlignmentLeft];
    [self.view addSubview:timeLeftLabel];
    
    [timeLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    
    _timeLabel = [YUtils initLabel:CONTENT_FONT(12)
                             color:KCOLOR_B3
                              text:@""
                         alignment:NSTextAlignmentLeft];
    [self.view addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLeftLabel);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //上课地点
    UIImageView *locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"build_icon_location"]];
    locationImageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:locationImageView];
    
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(timeImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    _locationLeftLabel = [YUtils initLabel:CONTENT_FONT(12)
                                             color:KCOLOR_B5
                                              text:@"上课地点："
                                         alignment:NSTextAlignmentLeft];
    [self.view addSubview:_locationLeftLabel];
    
    [_locationLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(locationImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _locationLabel = [YUtils initLabel:CONTENT_FONT(12)
                                 color:KCOLOR_B3
                                  text:_courseDetail.roomName
                             alignment:NSTextAlignmentLeft];
    [self.view addSubview:_locationLabel];
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_locationLeftLabel);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //开课单位
    _departmentsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_academy"]];
    [self.view addSubview:_departmentsImageView];
    
    [_departmentsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(locationImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *departmentsLabel = [YUtils initLabel:CONTENT_FONT(12)
                                            color:KCOLOR_B5
                                             text:@"开课单位："
                                        alignment:NSTextAlignmentLeft];
    [self.view addSubview:departmentsLabel];
    
    [departmentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_departmentsImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _departmentsName = [YUtils initLabel:CONTENT_FONT(12)
                                   color:KCOLOR_B3
                                    text:_courseDetail.departmentName
                               alignment:NSTextAlignmentLeft];
    [self.view addSubview:_departmentsName];
    
    [_departmentsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_departmentsImageView);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    [_courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(courseImageView);
        make.left.equalTo(_lecturerName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
}

- (void)resetCourseView {
    _courseName.text = _courseDetail.courseName;
    _lecturerName.text = _courseDetail.teacherName;
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:_courseDetail.startTime/1000];
    NSString *startStr = [startDate stringWithFormat:@"HH:mm"];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:_courseDetail.endTime/1000];
    NSString *endStr = [endDate stringWithFormat:@"HH:mm"];
    NSString *dateStr = [[NSDate dateWithTimeIntervalSince1970:_userSchedulingInfo.startTime/1000] stringWithFormat:@"MM月dd日"];
    _timeLabel.text = [NSString stringWithFormat:@"%@ %@-%@", dateStr, startStr, endStr];
    _locationLabel.text = _courseDetail.roomName;
    _departmentsName.text = _courseDetail.departmentName;
}

- (void)initView {
    if ([_userSchedulingInfo.type isEqualToString:@"user_scheduling"]) {
        self.title = @"日程详情";
        [self initSchedulingView];
    } else if ([_userSchedulingInfo.type isEqualToString:@"course"]) {
        self.title = @"课程详情";
        [self initCourseView];
    }
}

- (void)initData {
    [YUtils showHUDWithTitle];
    
    if ([_userSchedulingInfo.type isEqualToString:@"user_scheduling"]) {
        [[ActivityManager sharedInstance] userSchedulingDetail:_userSchedulingInfo.internalBaseClassIdentifier block:^(YActionMessage *message) {
            [YUtils hiddenProgressHUD];
            
            if (message.isSuccess) {
                self.userSchedulingInfo = message.object;
                
                [self resetSchedulingView];
                
            } else {
                [YUtils showTitle:message.desc];
            }
        }];
    } else if ([_userSchedulingInfo.type isEqualToString:@"course"]) {
        [[CurriculumManager sharedInstance] courseDetail:[NSString stringWithFormat:@"%g", _userSchedulingInfo.internalBaseClassIdentifier] blok:^(YActionMessage *message) {
            [YUtils hiddenProgressHUD];
            
            if (message.isSuccess) {
                self.courseDetail = message.object;
                
                [self resetCourseView];
                
            } else {
                [YUtils showTitle:message.desc];
            }
        }];
    }
}

- (void)onNavigationRightButtonClicked {
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"编辑日程"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self toEdit];
                                                        }];
    
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"删除日程"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self delSchedule];
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
            [YUtils showHUDWithTitle];
            [[ActivityManager sharedInstance] userSchedulingDelete:[NSString stringWithFormat:@"%g", _userSchedulingInfo.internalBaseClassIdentifier] block:^(YActionMessage *message) {
                
                [YUtils hiddenProgressHUD];
                
                if (message.isSuccess) {
                    //抛通知告知删除成功
                    _userSchedulingInfo.type = @"user_scheduling";
                    NSDictionary *dic = @{@"state":@"del", @"info":_userSchedulingInfo};
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Change_Schedule
                                                                        object:nil
                                                                      userInfo:dic];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [YUtils showTitle:message.desc];
                }
                
            }];
            
            
        }
    }];
    [alert show];
}

//跳转至编辑活动
- (void)toEdit {
    NewScheduleViewController *vc = [[NewScheduleViewController alloc] initWithInfo:_userSchedulingInfo];
    [self.view.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

//更改日程
- (void)changeScheduleDetail:(NSNotification *)notification {
    NSDictionary *dic = [notification userInfo];
    
    UserSchedulingInfo *info = dic[@"info"];
    
    if (info.internalBaseClassIdentifier == _userSchedulingInfo.internalBaseClassIdentifier && [info.type isEqualToString:@"user_scheduling"]) {
        self.userSchedulingInfo = info;
        
        [self resetSchedulingView];
    }
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
