//
//  StudyRoomDetailTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "StudyRoomDetailTableViewCell.h"

NSString *const kStudyRoomDetailTableViewCell = @"StudyRoomDetailTableViewCellId";

#define K_IMG_L             SCALE_NUM(12)   //图标左
#define K_IMG_TW            SCALE_NUM(19)   //图标上
#define K_IMG_H             SCALE_NUM(14)   //图标高
#define K_TEXT_L            SCALE_NUM(6)    //字左
#define K_ROOM_T            SCALE_NUM(15)   //室上
#define K_TEXT_H            SCALE_NUM(12)   //字高

@interface StudyRoomDetailTableViewCell ()

//@property (nonatomic, strong) UILabel *studyFloorLabel; //自习楼
@property (nonatomic, strong) UILabel *studyRoomLabel;  //自习室
@property (nonatomic, strong) UILabel *timeLabel;       //时间

@end

@implementation StudyRoomDetailTableViewCell

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
//    //1
//    UIImageView *studyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_classroom"]];
//    [self.contentView addSubview:studyImageView];
//    
//    [studyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(K_IMG_L);
//        make.top.width.mas_equalTo(K_IMG_TW);
//        make.height.mas_equalTo(K_IMG_H);
//    }];
//    
//    //2
//    _studyFloorLabel = [YUtils initLabel:CONTENT_FONT(15)
//                                   color:KCOLOR_B4
//                                    text:@"教学2楼"
//                               alignment:NSTextAlignmentLeft];
//    [self.contentView addSubview:_studyFloorLabel];
//    
//    [_studyFloorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(studyImageView.mas_right).offset(K_TEXT_L);
//        make.height.equalTo(studyImageView);
//        make.right.mas_equalTo(-K_TEXT_L);
//        make.top.equalTo(studyImageView);
//    }];
    
    //3
    _studyRoomLabel = [YUtils initLabel:CONTENT_FONT(12)
                                  color:KCOLOR_B5
                                   text:@"2012室"
                              alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_studyRoomLabel];
    
    [_studyRoomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(K_IMG_L);
        make.height.mas_equalTo(K_TEXT_H);
        make.top.mas_equalTo(K_IMG_TW);
    }];
    
    //4
    _timeLabel = [YUtils initLabel:CONTENT_FONT(12)
                                  color:KCOLOR_B5
                                   text:@"无课时间：14:00-16:00"
                              alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_studyRoomLabel);
        make.height.mas_equalTo(K_TEXT_H);
        make.bottom.mas_equalTo(-K_IMG_TW);
    }];
}

- (BOOL)needLine {
    return YES;
}


- (void)initData:(FreeBuildingDetailModel *)model{

    _studyRoomLabel.text = model.roomName;
    _timeLabel.text = @"无课时间：14:00-16:00";
    
}

@end
