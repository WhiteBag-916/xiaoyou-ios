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

@interface RubLessonTableViewCell ()

@property (nonatomic, strong) UILabel *courseName;          //课程名称
@property (nonatomic, strong) UILabel *lecturerName;        //授课人
@property (nonatomic, strong) UILabel *departmentsName;     //院系

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
                              color:KCOLORGREEN_B5
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
                              color:KCOLORGREEN_B5
                               text:@"王中磊"
                          alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_lecturerName];
    
    [_lecturerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(lecturerImageView);
        make.left.equalTo(lecturerLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_L);
    }];
    
    //院系
    UIImageView *departmentsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"havetime_icon_academy"]];
    [self.contentView addSubview:departmentsImageView];
    
    [departmentsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(courseImageView);
        make.top.equalTo(lecturerImageView.mas_bottom).offset(K_DEPARTMENTSIMG_T);
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
                              color:KCOLORGREEN_B5
                               text:@"汉语言文学系"
                          alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_departmentsName];
    
    [_departmentsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(departmentsImageView);
        make.left.equalTo(departmentsLabel.mas_right).offset(K_NAMELAB_L);
        make.right.mas_equalTo(K_NAMELAB_L);
    }];
}

- (BOOL)needLine {
    return YES;
}

@end
