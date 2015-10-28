//
//  StudyRoomCell.m
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "StudyRoomCell.h"
#define REUSEID @"StudyRoomCell"
@interface StudyRoomCell ()

@property (nonatomic,strong) UIImageView    *startImageView;
@property (nonatomic,strong) UILabel        *titleLabel;
@property (nonatomic,strong) UILabel        *desLabel;

@end

@implementation StudyRoomCell


+(StudyRoomCell *)cellWithTableView:(UITableView *)tableView
{
    StudyRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID];
    if (!cell) {
        cell = [[StudyRoomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView
{
    _startImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_startImageView];
    _startImageView.image = [UIImage imageNamed:@"_bar"];
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(20));
        make.leading.mas_equalTo(0);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.text = @"114个教室没课";
    _titleLabel.font = CONTENT_FONT(15);
    _titleLabel.textColor = KCOLOR_B4;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.centerY.equalTo(_startImageView.mas_centerY);
        make.leading.mas_equalTo(SCALE_NUM(15));
    }];
    
    _desLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_desLabel];
    _desLabel.font = CONTENT_FONT(12);
    _desLabel.textColor = KCOLOR_B5;
    _desLabel.text = @"没什么大事就去学习一下？";
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_titleLabel.mas_bottom).offset(SCALE_NUM(20));
        make.left.equalTo(_titleLabel);
        make.bottom.mas_equalTo(SCALE_NUM(-15));
    }];
}

@end
