//
//  ScheduleNotifyCell.m
//  XiaoYou
//
//  Created by sheng on 15/11/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScheduleNotifyCell.h"
#import "TimeFormatterConvert.h"

#define REUSRID             @"ScheduleNotifyCell"
#define CELL_INSET          SCALE_NUM(12)
#define TOP_CELL_HEIGHT     SCALE_NUM(44)

@interface ScheduleNotifyCell ()

@property(nonatomic,strong) UIView      *wrapContentView;   //内容视图
@property(nonatomic,strong) UILabel     *remindTitleLabel;  //提醒标题
@property(nonatomic,strong) UIView      *topLineView;       //上面分割线

@property(nonatomic,strong) UILabel     *scheduleNameLabel; //日程名字
@property(nonatomic,strong) UILabel     *beginTimeLable;    //开始时间

@end

@implementation ScheduleNotifyCell


+(ScheduleNotifyCell *)cellWithTableView:(UITableView *)tableView
{
    ScheduleNotifyCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSRID];
    if (!cell) {
        cell = [[ScheduleNotifyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSRID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KCOLOR_B1;
        [self initView];
    }
    return self;
}


-(void)initView
{
    //容器视图
    _wrapContentView = [YUtils initWrapContentViewWithBackGroundColor:[UIColor whiteColor]
                                                          borderWidth:1
                                                          borderColor:KCOLOR_B2
                                                         cornerRadius:5];
    [self.contentView addSubview:_wrapContentView];
    [_wrapContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CELL_INSET);
        make.right.equalTo(self.mas_right).offset(-CELL_INSET);
    }];
    
    //中间内容部分
    _topLineView = [YUtils initLineViewWithbackgroundColor:KCOLOR_B2];
    [self.wrapContentView addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.top.equalTo(_wrapContentView).offset(SCALE_NUM(44));
        make.height.mas_equalTo(1);
    }];
    
    _remindTitleLabel = [YUtils initLabel:CONTENT_FONT(15) color:KCOLOR_B4 text:@""];
    [self.wrapContentView addSubview:_remindTitleLabel];
    [_remindTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(5));
        make.top.equalTo(_wrapContentView);
        make.bottom.equalTo(_topLineView);
    }];
    
    _scheduleNameLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLOR_B3 text:@""];
    [self.wrapContentView addSubview:_scheduleNameLabel];
    [_scheduleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_remindTitleLabel);
        make.top.equalTo(_topLineView).offset(SCALE_NUM(10));
    }];
    
    _beginTimeLable = [YUtils initLabel:CONTENT_FONT(12) color:KCOLOR_B3 text:@""];
    [self.wrapContentView addSubview:_beginTimeLable];
    [_beginTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scheduleNameLabel);
        make.top.equalTo(_scheduleNameLabel.mas_bottom).offset(SCALE_NUM(10));
    }];
}

-(void)setData:(NotifyInfoModel *)model
{
    _remindTitleLabel.text = model.em_push_title;
    _scheduleNameLabel.text = model.name;
    _beginTimeLable.text = [NSString stringWithFormat:@"活动开始时间：%@",
                            [TimeFormatterConvert timeConvertToFommtterNotice:model.startTime]];
}

@end
