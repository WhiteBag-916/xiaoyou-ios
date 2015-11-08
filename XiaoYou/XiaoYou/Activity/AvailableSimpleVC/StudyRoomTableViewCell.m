//
//  StudyRoomTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "StudyRoomTableViewCell.h"
#import "Result.h"

NSString *const kStudyRoomTableViewCell = @"StudyRoomTableViewCellId";

#define K_BUTTON_T         SCALE_NUM(30)  
#define K_LABEL_T         SCALE_NUM(15)

@interface StudyRoomTableViewCell ()

@property (nonatomic, strong) UIButton *studyRoomNameButton;
@property (nonatomic, strong) UILabel *studyRoomNumberLabel;

@end

@implementation StudyRoomTableViewCell

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
    _studyRoomNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _studyRoomNameButton.userInteractionEnabled = NO;
    [_studyRoomNameButton setImage:[UIImage imageNamed:@"common_icon_classroom"] forState:UIControlStateNormal];
    [_studyRoomNameButton setTitle:@"教学2楼" forState:UIControlStateNormal];
    [_studyRoomNameButton setTitleColor:KCOLOR_B4 forState:UIControlStateNormal];
    _studyRoomNameButton.titleLabel.font = CONTENT_FONT(15);
    [_studyRoomNameButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    [self.contentView addSubview:_studyRoomNameButton];
    
    [_studyRoomNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.mas_equalTo(K_BUTTON_T);
    }];
    
    _studyRoomNumberLabel = [YUtils initLabel:CONTENT_FONT(12)
                                        color:KCOLOR_B5
                                         text:@"11个教室没课"
                                    alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_studyRoomNumberLabel];
    
    [_studyRoomNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.mas_equalTo(-K_BUTTON_T);
    }];
}

- (BOOL)needLine {
    return YES;
}

- (void)initData:(Result *)model
{
    [_studyRoomNameButton setTitle:model.buildName forState:UIControlStateNormal];
    _studyRoomNumberLabel.text =[NSString stringWithFormat:@"%g个教室没课",model.roomCount];
    
}

@end
