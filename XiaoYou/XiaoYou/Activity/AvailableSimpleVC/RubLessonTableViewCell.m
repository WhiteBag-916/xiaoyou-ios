//
//  RubLessonTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RubLessonTableViewCell.h"

NSString *const kRubLessonTableViewCell = @"RubLessonTableViewCellId";

#define K_IMG_LWH           SCALE_NUM(12)   //图标左、宽、高
#define K_COURSEIMG_T       SCALE_NUM(22)   //课程图标上间距
#define K_LECTURERIMG_T     SCALE_NUM(15)   //授课人图标上间距
#define K_DEPARTMENTSIMG_T  SCALE_NUM(14)   //院系图标上间距
#define K_LEFTLAB_L         SCALE_NUM(10)   //描述左
#define K_LEFTLAB_W         SCALE_NUM(61)   //描述宽
#define K_NAMELAB_L         SCALE_NUM(0)   //名字左
#define K_ADD_T             SCALE_NUM(20)   //加日程上
#define K_ADD_R             SCALE_NUM(9)   //加日程上
#define K_ADD_H             SCALE_NUM(26)   //加日程高
#define K_ADD_W             SCALE_NUM(70)   //加日程宽
#define K_LOCATION_IMG_W    SCALE_NUM(9)   //地点图宽

@interface RubLessonTableViewCell ()

@property (nonatomic, strong) UILabel *courseName;          //课程名称
@property (nonatomic, strong) UILabel *lecturerName;        //授课人
@property (nonatomic, strong) UILabel *timeLabel;           //上课时间
@property (nonatomic, strong) UILabel *locationLabel;       //上课地点
@property (nonatomic, strong) UILabel *departmentsName;     //院系
@property (nonatomic, strong) UIButton *addToCalendar;      //加入日程

@end

@implementation RubLessonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initView];
        
        self.contentView.backgroundColor = KCOLORWHITE;
    }
    
    return self;
}

- (void)initView {
    //课程
    UIImageView *courseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_classname"]];
    [self.contentView addSubview:courseImageView];
    
    [courseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(K_IMG_LWH);
        make.top.mas_equalTo(K_COURSEIMG_T);
    }];
    
    UILabel *courseLabel = [YUtils initLabel:CONTENT_FONT(12)
                                       color:KCOLORGREEN_B5
                                        text:@"课程名称："
                                   alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:courseLabel];
    
    [courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(courseImageView);
        make.left.equalTo(courseImageView.mas_right).offset(K_LEFTLAB_L);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _courseName = [YUtils initLabel:CONTENT_FONT(12)
                              color:KCOLORGREEN_B3
                               text:@"大学汉语"
                          alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_courseName];
    
    [_courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(courseImageView);
        make.left.equalTo(courseLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_L);
    }];
    
    //授课人
    UIImageView *lecturerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_teacher"]];
    [self.contentView addSubview:lecturerImageView];
    
    [lecturerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(courseImageView.mas_bottom).offset(K_LECTURERIMG_T);
    }];
    
    UILabel *lecturerLabel = [YUtils initLabel:CONTENT_FONT(12)
                                       color:KCOLORGREEN_B5
                                        text:@"授课人："
                                   alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:lecturerLabel];
    
    [lecturerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(lecturerImageView);
        make.left.equalTo(lecturerImageView.mas_right).offset(K_LEFTLAB_L);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _lecturerName = [YUtils initLabel:CONTENT_FONT(12)
                              color:KCOLORGREEN_B3
                               text:@"王中磊"
                          alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_lecturerName];
    
    [_lecturerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(lecturerImageView);
        make.left.equalTo(lecturerLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_L);
    }];
    
    //上课时间
    UIImageView *timeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_time"]];
    [self.contentView addSubview:timeImageView];
    
    [timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(lecturerImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *timeLeftLabel = [YUtils initLabel:CONTENT_FONT(12)
                                         color:KCOLORGREEN_B5
                                          text:@"上课时间："
                                     alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:timeLeftLabel];
    
    [timeLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(timeImageView);
        make.left.equalTo(timeImageView.mas_right).offset(K_LEFTLAB_L);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _timeLabel = [YUtils initLabel:CONTENT_FONT(12)
                                color:KCOLORGREEN_B3
                                 text:@"今天 9:00-10:30"
                            alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(timeLeftLabel);
        make.left.equalTo(timeLeftLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_L);
    }];
    
    //上课地点
    UIImageView *locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"build_icon_location"]];
    [self.contentView addSubview:locationImageView];
    
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
    [self.contentView addSubview:locationLeftLabel];
    
    [locationLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(locationImageView);
        make.left.equalTo(locationImageView.mas_right).offset(K_LEFTLAB_L);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _locationLabel = [YUtils initLabel:CONTENT_FONT(12)
                             color:KCOLORGREEN_B3
                              text:@"5号教学楼 5132室"
                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_locationLabel];
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(locationLeftLabel);
        make.left.equalTo(locationLeftLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_L);
    }];
    
    //院系
    UIImageView *departmentsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_academy"]];
    [self.contentView addSubview:departmentsImageView];
    
    [departmentsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(locationImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *departmentsLabel = [YUtils initLabel:CONTENT_FONT(12)
                                       color:KCOLORGREEN_B5
                                        text:@"院系："
                                   alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:departmentsLabel];
    
    [departmentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(departmentsImageView);
        make.left.equalTo(departmentsImageView.mas_right).offset(K_LEFTLAB_L);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _departmentsName = [YUtils initLabel:CONTENT_FONT(12)
                              color:KCOLORGREEN_B3
                               text:@"汉语言文学系"
                          alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_departmentsName];
    
    [_departmentsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(departmentsImageView);
        make.left.equalTo(departmentsLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_L);
    }];
    
    //加入日程
    _addToCalendar = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addToCalendar setTitle:@"加入日程表" forState:UIControlStateNormal];
    _addToCalendar.titleLabel.font = CONTENT_FONT(12);
    [_addToCalendar setTitleColor:KCOLORGREEN_g1 forState:UIControlStateNormal];
    _addToCalendar.layer.cornerRadius = 4;
    _addToCalendar.layer.borderColor = KCOLORGREEN_g1.CGColor;
    _addToCalendar.layer.borderWidth = 1;
    [self.contentView addSubview:_addToCalendar];
    
    [_addToCalendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(K_ADD_T);
        make.right.mas_equalTo(-K_ADD_R);
        make.width.mas_equalTo(K_ADD_W);
        make.height.mas_equalTo(K_ADD_H);
    }];
}

- (BOOL)needLine {
    return YES;
}

@end
