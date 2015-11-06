//
//  ScheduleCardCell.m
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#define REUSEID @"ScheduleCardCell"
#import "ScheduleCardCell.h"
#import "Scheduling.h"
#import "TimeFormatterConvert.h"
#import "NotifyViewController.h"
#import "AvailableViewController.h"

@interface ScheduleCardCell ()

@property (nonatomic,strong) UIImageView    *startImageView;    //提示图片
@property (nonatomic,strong) UILabel        *titleLabel;        //标题
@property (nonatomic,strong) UILabel        *timeLabel1;        //第一项时间
@property (nonatomic,strong) UILabel        *projectLabel1;     //第一项目内容
@property (nonatomic,strong) UILabel        *timeLabel2;        //第二项时间
@property (nonatomic,strong) UILabel        *projectLabel2;     //第二项内容
@property (nonatomic,strong) UILabel        *timeLabel3;        //第三项时间
@property (nonatomic,strong) UILabel        *projectLabel3;     //第三项内容
@property (nonatomic,strong) UIImageView    *notHaveSchedule;   //没有日程

@property (nonatomic,strong) UIButton       *messageNotRead;    //多少条未读消息
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

#pragma mark 协议方法
-(BOOL)needLine
{
    return YES;
}

-(CGFloat)lineX
{
    return 20;
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
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(3));
    }];
    
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.font = CONTENT_FONT(15);
    _titleLabel.text = @"日程卡";
    _titleLabel.textColor = KCOLOR_B4;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.leading.mas_equalTo(SCALE_NUM(15));
        make.centerY.equalTo(_startImageView.mas_centerY);
    }];
    
    _timeLabel1 = [[UILabel alloc]init];
    [self.contentView addSubview:_timeLabel1];
    _timeLabel1.text = @"8:00-9:00";
    _timeLabel1.font = CONTENT_FONT(12);
    _timeLabel1.textColor = KCOLOR_B5;
    _timeLabel1.numberOfLines = 1;
    _timeLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
    [_timeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCALE_NUM(205));
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_titleLabel.mas_bottom).offset(SCALE_NUM(20));
        make.left.equalTo(_titleLabel);
    }];
    
    _projectLabel1 = [[UILabel alloc]init];
    [self.contentView addSubview:_projectLabel1];
    _projectLabel1.textColor = KCOLOR_B5;
    _projectLabel1.text = @"英语口语练习";
    _projectLabel1.font = CONTENT_FONT(10);
    [_projectLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.left.equalTo(_timeLabel1.mas_right).offset(SCALE_NUM(5));
        make.centerY.equalTo(_timeLabel1);
        make.trailing.mas_equalTo(SCALE_NUM(-15));
    }];
    
    _timeLabel2 = [[UILabel alloc]init];
    [self.contentView addSubview:_timeLabel2];
    _timeLabel2.textColor = KCOLOR_B5;
    _timeLabel2.text = @"8:00-9:00";
    _timeLabel2.font = CONTENT_FONT(12);
    _timeLabel2.numberOfLines = 1;
    _timeLabel2.lineBreakMode = NSLineBreakByTruncatingTail;
    [_timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_timeLabel1);
        make.top.equalTo(_timeLabel1.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_timeLabel1);
    }];
    
    _projectLabel2 = [[UILabel alloc]init];
    [self.contentView addSubview:_projectLabel2];
    _projectLabel2.text = @"XX社团集体大会";
    _projectLabel2.textColor = KCOLOR_B5;
    _projectLabel2.font = CONTENT_FONT(10);
    [_projectLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.height.mas_equalTo(SCALE_NUM(12));
        make.left.equalTo(_projectLabel1);
        make.centerY.equalTo(_timeLabel2);
        make.right.equalTo(_projectLabel1);
    }];
    
    _timeLabel3 = [[UILabel alloc]init];
    [self.contentView addSubview:_timeLabel3];
    _timeLabel3.text = @"10:00-12:00";
    _timeLabel3.textColor = KCOLOR_B5;
    _timeLabel3.font = CONTENT_FONT(12);
    _timeLabel3.numberOfLines = 1;
    _timeLabel3.lineBreakMode = NSLineBreakByTruncatingTail;
    [_timeLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_timeLabel2);
        make.top.equalTo(_timeLabel2.mas_bottom).offset(SCALE_NUM(15)).priorityLow();
        make.left.equalTo(_timeLabel2);
        make.bottom.mas_equalTo(SCALE_NUM(-15)).priorityHigh();
    }];
    
    _projectLabel3 = [[UILabel alloc]init];
    [self.contentView addSubview:_projectLabel3];
    _projectLabel3.text = @"读书社名人讲座";
    _projectLabel3.font = CONTENT_FONT(10);
    _projectLabel3.textColor = KCOLOR_B5;
    [_projectLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.height.mas_equalTo(SCALE_NUM(12));
        make.left.equalTo(_projectLabel2);
        make.centerY.equalTo(_timeLabel3);
        make.right.equalTo(_projectLabel2);
    }];
    
    _notHaveSchedule = [[UIImageView alloc]init];
    [self.contentView addSubview:_notHaveSchedule];
    _notHaveSchedule.hidden = YES;
    _notHaveSchedule.image = [UIImage imageNamed:@"no_data_schedule"];
    [_notHaveSchedule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel1);
        make.bottom.equalTo(_timeLabel2.mas_top).offset(SCALE_NUM(-5));
    }];
}

-(void)setData:(NSArray *)scheduleArr
{
    for (int i = 0; i < scheduleArr.count; i++) {
        Scheduling *schedule = [scheduleArr objectAtIndex:i];
        if (i == 0) {
            _timeLabel1.text    = schedule.content;
            _projectLabel1.text = [TimeFormatterConvert timeConvertToFommtterScheduleStartTime:schedule.startTime EndTime:schedule.endTime];
            if ([_projectLabel1.text isEqualToString:@"进行中"]) {
                _projectLabel1.textColor = KCOLOR_g1;
            }
            _timeLabel2.text    = @"";
            _projectLabel2.text = @"";
            _timeLabel3.text    = @"";
            _projectLabel3.text = @"";
        } else if (i == 1) {
            _timeLabel2.text = schedule.content;
            _projectLabel2.text = [TimeFormatterConvert timeConvertToFommtterScheduleStartTime:schedule.startTime EndTime:schedule.endTime];
            if ([_projectLabel2.text isEqualToString:@"进行中"]) {
                _projectLabel2.textColor = KCOLOR_g1;
            }
            _timeLabel3.text    = @"";
            _projectLabel3.text = @"";
        } else if (i == 2) {
            _timeLabel3.text = schedule.content;
            _projectLabel3.text = [TimeFormatterConvert timeConvertToFommtterScheduleStartTime:schedule.startTime EndTime:schedule.endTime];
            if ([_projectLabel3.text isEqualToString:@"进行中"]) {
                _projectLabel3.textColor = KCOLOR_g1;
            }
        }
    }
    if (scheduleArr.count == 0) {
        _timeLabel1.text = @"";
        _projectLabel1.text = @"";
        _timeLabel2.text = @"";
        _projectLabel2.text = @"";
        _timeLabel3.text = @"";
        _projectLabel3.text = @"";
        _notHaveSchedule.hidden = NO;
    }
    if (scheduleArr.count == 1) {
        [_timeLabel1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(SCALE_NUM(-15));
        }];
    }
    else if (scheduleArr.count == 2) {
        [_timeLabel2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(SCALE_NUM(-15));
        }];
    }
}

//设置消息未读提醒
-(void)setMessageNotReadIsVisible:(BOOL)isVisible Text:(NSString *)text
{
    self.messageNotRead.hidden = !isVisible;
    [self.messageNotRead setTitle:text forState:UIControlStateNormal];
}

//消息未读提醒Action
-(UIButton *)messageNotRead
{
    if (!_messageNotRead) {
        _messageNotRead = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_messageNotRead];
        _messageNotRead.backgroundColor = [UIColor blackColor];
        _messageNotRead.layer.cornerRadius = 5;
        _messageNotRead.clipsToBounds = YES;
        _messageNotRead.alpha = 0.7;
        [_messageNotRead setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_messageNotRead addTarget:self action:@selector(messageNotReadAction) forControlEvents:UIControlEventTouchUpInside];
        [_messageNotRead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.mas_equalTo(SCALE_NUM(10));
        }];
    }
    return _messageNotRead;
}

//消息未读提醒Action
-(void)messageNotReadAction
{
    NotifyViewController *notiVC = [[NotifyViewController alloc]init];
    [self.viewController.navigationController pushViewController:notiVC animated:YES needHiddenBottomBar:YES];
}


@end
