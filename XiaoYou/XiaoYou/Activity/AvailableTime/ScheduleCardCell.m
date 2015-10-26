//
//  ScheduleCardCell.m
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#define REUSEID @"ScheduleCardCell"
#import "ScheduleCardCell.h"

@interface ScheduleCardCell ()
@property (nonatomic,strong) UIImageView    *startImageView;    //提示图片
@property (nonatomic,strong) UILabel        *titleLabel;        //标题
@property (nonatomic,strong) UILabel        *timeLabel1;        //第一项时间
@property (nonatomic,strong) UILabel        *projectLabel1;     //第一项目内容
@property (nonatomic,strong) UILabel        *timeLabel2;        //第二项时间
@property (nonatomic,strong) UILabel        *projectLabel2;     //第二项内容
@property (nonatomic,strong) UILabel        *timeLabel3;        //第三项时间
@property (nonatomic,strong) UILabel        *projectLabel3;     //第三项内容
@end

@implementation ScheduleCardCell


+(ScheduleCardCell *)cellWithTableView:(UITableView *)tableView
{
    ScheduleCardCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID];
    if (!cell) {
        cell = [[ScheduleCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEID];
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
    _startImageView.image = [UIImage imageNamed:@"green_bar"];
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(20));
        make.leading.mas_equalTo(0);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.font = CONTENT_FONT(15);
    _titleLabel.text = @"日程卡";
    _titleLabel.textColor = KCOLORGREEN_B4;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.leading.mas_equalTo(SCALE_NUM(15));
        make.centerY.equalTo(_startImageView.mas_centerY);
    }];
    
    _timeLabel1 = [[UILabel alloc]init];
    [self.contentView addSubview:_timeLabel1];
    _timeLabel1.text = @"8:00-9:00";
    _timeLabel1.font = CONTENT_FONT(12);
    _timeLabel1.textColor = KCOLORGREEN_B5;
    [_timeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_titleLabel.mas_bottom).offset(SCALE_NUM(20));
        make.left.equalTo(_titleLabel);
    }];
    
    _projectLabel1 = [[UILabel alloc]init];
    [self.contentView addSubview:_projectLabel1];
    _projectLabel1.textColor = KCOLORGREEN_B5;
    _projectLabel1.text = @"英语口语练习";
    _projectLabel1.font = CONTENT_FONT(12);
    [_projectLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.leading.mas_equalTo(SCALE_NUM(100));
        make.centerY.equalTo(_timeLabel1);
    }];
    
    _timeLabel2 = [[UILabel alloc]init];
    [self.contentView addSubview:_timeLabel2];
    _timeLabel2.textColor = KCOLORGREEN_B5;
    _timeLabel2.text = @"8:00-9:00";
    _timeLabel2.font = CONTENT_FONT(12);
    [_timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_timeLabel1.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_timeLabel1);
    }];
    
    _projectLabel2 = [[UILabel alloc]init];
    [self.contentView addSubview:_projectLabel2];
    _projectLabel2.text = @"XX社团集体大会";
    _projectLabel2.textColor = KCOLORGREEN_B5;
    _projectLabel2.font = CONTENT_FONT(12);
    [_projectLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.leading.mas_equalTo(SCALE_NUM(100));
        make.centerY.equalTo(_timeLabel2);
    }];
    
    _timeLabel3 = [[UILabel alloc]init];
    [self.contentView addSubview:_timeLabel3];
    _timeLabel3.text = @"10:00-12:00";
    _timeLabel3.textColor = KCOLORGREEN_B5;
    _timeLabel3.font = CONTENT_FONT(12);
    [_timeLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_timeLabel2.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_timeLabel2);
        make.bottom.mas_equalTo(SCALE_NUM(-15));
    }];
    
    _projectLabel3 = [[UILabel alloc]init];
    [self.contentView addSubview:_projectLabel3];
    _projectLabel3.text = @"读书社名人讲座";
    _projectLabel3.font = CONTENT_FONT(12);
    _projectLabel3.textColor = KCOLORGREEN_B5;
    [_projectLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.leading.mas_equalTo(SCALE_NUM(100));
        make.centerY.equalTo(_timeLabel3);
    }];
    
}

@end
