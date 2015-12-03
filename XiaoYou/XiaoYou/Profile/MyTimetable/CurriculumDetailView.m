//
//  CurriculumDetailView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "CurriculumDetailView.h"
#import "FindMyCourseViewModel.h"
#import "CurriculumManager.h"

#define K_BACK_LR         SCALE_NUM(15)
#define K_BACK_T         SCALE_NUM(123)
#define K_BACK_B         SCALE_NUM(260)

#define K_IMG_WH           SCALE_NUM(12)   //图标宽、高
#define K_IMG_L           SCALE_NUM(15)   //图标左
#define K_COURSEIMG_T       SCALE_NUM(22)   //课程图标上间距
#define K_CONTENT_B         SCALE_NUM(15)   //下
#define K_COURSEIMG_H       SCALE_NUM(14)   //文字高
#define K_LECTURERIMG_T     SCALE_NUM(15)   //授课人图标上间距
#define K_DEPARTMENTSIMG_T  SCALE_NUM(14)   //开课单位图标上间距
#define K_LEFTLAB_L         SCALE_NUM(10)   //描述左
#define K_LEFTLAB_W         SCALE_NUM(70)   //描述宽
#define K_NAMELAB_L         SCALE_NUM(0)   //名字左
#define K_NAMELAB_R         SCALE_NUM(-12)   //名字右
#define K_LOCATION_IMG_W    SCALE_NUM(9)   //地点图宽

@interface CurriculumDetailView ()

@property (nonatomic, strong) UILabel *courseName;          //课程名称
@property (nonatomic, strong) UILabel *lecturerName;        //授课人
@property (nonatomic, strong) UILabel *timeLabel;           //上课时间
@property (nonatomic, strong) UILabel *weekLabel;           //周次
@property (nonatomic, strong) UILabel *locationLabel;       //上课地点
@property (nonatomic, strong) UILabel *departmentsName;     //开课单位

@end

@implementation CurriculumDetailView

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.backgroundView];
        
        [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(hide)]];
        
        [self initContentView];
    }
    return self;
}

- (void)initContentView {
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(K_BACK_LR);
        make.right.mas_equalTo(-K_BACK_LR);
        make.centerY.equalTo(self);
    }];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.image = [[UIImage imageNamed:@"build_background"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(9, 5, 6, 5)
                                 resizingMode:UIImageResizingModeStretch];
    [self.contentView addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self initMidView];
}

- (void)initMidView {
    //课程
    UIImageView *courseImageView = [[UIImageView alloc]
                                    initWithImage:[UIImage imageNamed:@"havetime_icon_classname"]];
    [self.contentView addSubview:courseImageView];
    
    [courseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(K_IMG_L);
        make.height.width.mas_equalTo(K_IMG_WH);
        make.top.mas_equalTo(K_COURSEIMG_T);
    }];
    
    UILabel *courseLabel = [YUtils initLabel:CONTENT_FONT(12)
                                       color:KCOLOR_B5
                                        text:@"课程名称："
                                   alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:courseLabel];
    
    [courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(courseImageView);
        make.left.equalTo(courseImageView.mas_right).offset(K_LEFTLAB_L);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _courseName = [YUtils initLabel:CONTENT_FONT(12)
                              color:KCOLOR_B3
                               text:@"大学汉语"
                          alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_courseName];
    
    [_courseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(courseImageView);
        make.left.equalTo(courseLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //授课人
    UIImageView *lecturerImageView = [[UIImageView alloc]
                                      initWithImage:[UIImage imageNamed:@"havetime_icon_teacher"]];
    [self.contentView addSubview:lecturerImageView];
    
    [lecturerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(courseImageView.mas_bottom).offset(K_LECTURERIMG_T);
    }];
    
    UILabel *lecturerLabel = [YUtils initLabel:CONTENT_FONT(12)
                                         color:KCOLOR_B5
                                          text:@"授课教师："
                                     alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:lecturerLabel];
    
    [lecturerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lecturerImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _lecturerName = [YUtils initLabel:CONTENT_FONT(12)
                                color:KCOLOR_B3
                                 text:@"王中磊"
                            alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_lecturerName];
    
    [_lecturerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lecturerImageView);
        make.left.equalTo(_courseName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //上课时间
    UIImageView *timeImageView = [[UIImageView alloc]
                                  initWithImage:[UIImage imageNamed:@"havetime_icon_time"]];
    [self.contentView addSubview:timeImageView];
    
    [timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(lecturerImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *timeLeftLabel = [YUtils initLabel:CONTENT_FONT(12)
                                         color:KCOLOR_B5
                                          text:@"上课时间："
                                     alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:timeLeftLabel];
    
    [timeLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _timeLabel = [YUtils initLabel:CONTENT_FONT(12)
                             color:KCOLOR_B3
                              text:@"9:00-10:30"
                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeLeftLabel);
        make.left.equalTo(_courseName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //周次
    UIImageView *weekImageView = [[UIImageView alloc]
                                  initWithImage:[UIImage imageNamed:@"course_icon_week"]];
    [self.contentView addSubview:weekImageView];
    
    [weekImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(timeImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *weekLeftLabel = [YUtils initLabel:CONTENT_FONT(12)
                                             color:KCOLOR_B5
                                              text:@"上课周次："
                                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:weekLeftLabel];
    
    [weekLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weekImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _weekLabel = [YUtils initLabel:CONTENT_FONT(12)
                                 color:KCOLOR_B3
                                  text:@"双周，每周三"
                             alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_weekLabel];
    
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weekLeftLabel);
        make.left.equalTo(_courseName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //上课地点
    UIImageView *locationImageView = [[UIImageView alloc]
                                      initWithImage:[UIImage imageNamed:@"build_icon_location"]];
    locationImageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:locationImageView];
    
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(weekImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *locationLeftLabel = [YUtils initLabel:CONTENT_FONT(12)
                                             color:KCOLOR_B5
                                              text:@"上课地点："
                                         alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:locationLeftLabel];
    
    [locationLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(locationImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _locationLabel = [YUtils initLabel:CONTENT_FONT(12)
                                 color:KCOLOR_B3
                                  text:@"5号教学楼 5132室"
                             alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_locationLabel];
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(locationLeftLabel);
        make.left.equalTo(_courseName);
        make.right.mas_equalTo(K_NAMELAB_R);
    }];
    
    //开课单位
    UIImageView *departmentsImageView = [[UIImageView alloc]
                                         initWithImage:[UIImage imageNamed:@"havetime_icon_academy"]];
    [self.contentView addSubview:departmentsImageView];
    
    [departmentsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(locationImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
    }];
    
    UILabel *departmentsLabel = [YUtils initLabel:CONTENT_FONT(12)
                                            color:KCOLOR_B5
                                             text:@"开课单位："
                                        alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:departmentsLabel];
    
    [departmentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(departmentsImageView);
        make.left.equalTo(courseLabel);
        make.width.mas_equalTo(K_LEFTLAB_W);
    }];
    
    _departmentsName = [YUtils initLabel:CONTENT_FONT(12)
                                   color:KCOLOR_B3
                                    text:@"汉语言文学系"
                               alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_departmentsName];
    
    [_departmentsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(departmentsImageView);
        make.left.equalTo(_courseName);
        make.right.mas_equalTo(K_NAMELAB_R);
        make.bottom.mas_equalTo(-K_CONTENT_B);
    }];
}

- (void)showBackground
{
    self.backgroundView.alpha = 0.7;
}

- (void)initData:(FindMyCourseViewModel *)model {
    _courseName.text = model.courseName;
    _lecturerName.text = model.teacherName;
    _timeLabel.text = [[CurriculumManager sharedInstance] getCourseTimeByClass:model.beginPhase
                                                                       endTime:model.endPhase];
    _locationLabel.text = model.roomName;
    _departmentsName.text = model.departmentName;
    _weekLabel.text = [[CurriculumManager sharedInstance] weekByCourseTimeID:model];
}

@end
