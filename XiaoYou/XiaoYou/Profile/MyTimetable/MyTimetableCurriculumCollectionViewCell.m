//
//  MyTimetableCurriculumCollectionViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MyTimetableCurriculumCollectionViewCell.h"

NSString *const kMyTimetableCurriculumCollectionViewCell = @"MyTimetableCurriculumCollectionViewCellId";

#define K_LABEL_T    SCALE_NUM(5)   //课程上

@interface MyTimetableCurriculumCollectionViewCell ()

@property (nonatomic, strong) UIView *backView;         //背景
@property (nonatomic, strong) UILabel *nameLabel;       //课程名字
@property (nonatomic, strong) UILabel *classroomLabel;  //教室
@property (nonatomic, strong) UILabel *weekLabel;       //单双周

@end

@implementation MyTimetableCurriculumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //背景
        _backView = [UIView new];
        _backView.alpha = .7f;
        _backView.layer.cornerRadius = 5;
        _backView.backgroundColor = [UIColor hexChangeFloat:@"fdf1db"];
        [self.contentView addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        //课程名字
        _nameLabel = [YUtils initLabel:CONTENT_FONT(12)
                                 color:KCOLOR_B4
                                  text:@"设计伦理"
                             alignment:NSTextAlignmentCenter];
        _nameLabel.numberOfLines = 2;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.mas_equalTo(K_LABEL_T);
        }];
        
        //教室
        _classroomLabel = [YUtils initLabel:CONTENT_FONT(8)
                                 color:KCOLOR_B5
                                  text:@"美院A204"
                             alignment:NSTextAlignmentCenter];
        _classroomLabel.numberOfLines = 2;
        [self.contentView addSubview:_classroomLabel];
        [_classroomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom).offset(K_LABEL_T);
        }];
        
        //单双周
        _weekLabel = [YUtils initLabel:CONTENT_FONT(8)
                                 color:KCOLOR_B5
                                  text:@"单周"
                             alignment:NSTextAlignmentCenter];
        _weekLabel.numberOfLines = 1;
        [self.contentView addSubview:_weekLabel];
        [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_classroomLabel);
            make.top.equalTo(_classroomLabel.mas_bottom).offset(K_LABEL_T);
        }];
    }
    
    return self;
}

@end
