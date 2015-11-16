//
//  RemindCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PassRemindCell.h"
#import "UIImageView+WebCache.h"
#import "ProfileInfo.h"
#import "WhoJoinInController.h"
#import "ActivityDetailViewController.h"
#import "TimeFormatterConvert.h"
#import "NotifyInfoModel.h"

#define REUSRID             @"PassRemindCell"
#define CELL_INSET          SCALE_NUM(12)
#define TOP_CELL_HEIGHT     SCALE_NUM(44)
@interface PassRemindCell ()

@property(nonatomic,strong) UIView      *wrapContentView;   //内容视图
@property(nonatomic,strong) UIImageView *titleImageView;    //图标
@property(nonatomic,strong) UILabel     *remindTitleLabel;  //标题
@property(nonatomic,strong) UIView      *topLineView;       //上面分割线
@property(nonatomic,strong) UIImageView *headImageView;     //中间内容
@property(nonatomic,strong) UILabel     *contentTitleLabel; //内容标题
@property(nonatomic,strong) UILabel     *contentNameLabel;  //内容名
@property(nonatomic,strong) UILabel     *activityTimeLabel; //活动时间
@property(nonatomic,strong) UIView      *bottomLineView;    //下面分割线
@property(nonatomic,strong) UILabel     *tailLabel;         //尾部文字
@property(nonatomic,strong) UIImageView *tailImageView;     //尾部next图片

@property(nonatomic,strong) UIButton    *middleButton;      //中间button
@property(nonatomic,strong) UIButton    *bottomButton;      //底部button


@property(nonatomic,strong) NoticeInfo  *model;             //提醒model

@property(nonatomic,strong) NotifyInfoModel *notifyModel;
@end


@implementation PassRemindCell


+(PassRemindCell *)passRemindCellWithTableView:(UITableView *)tableView
{
    PassRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSRID];
    if (!cell) {
        cell = [[PassRemindCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSRID];
    }
    return cell;
}

-(BOOL)needLine
{
    return NO;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
    _wrapContentView = [[UIView alloc]init];
    [self.contentView addSubview:_wrapContentView];
    _wrapContentView.backgroundColor = [UIColor whiteColor];
    _wrapContentView.layer.borderWidth = 1;
    _wrapContentView.layer.borderColor = KCOLOR_B2.CGColor;
    [_wrapContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(CELL_INSET);
        make.right.equalTo(self.contentView.mas_right).offset(-CELL_INSET);
    }];
    
    _wrapContentView.layer.cornerRadius = 5;
    _wrapContentView.clipsToBounds = YES;
    
    //上面部分View
    _titleImageView = [[UIImageView alloc]init];
    _titleImageView.image = [UIImage imageNamed:@"tick"];
    [self.wrapContentView addSubview:_titleImageView];
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.equalTo(self.wrapContentView).offset(18);
        make.width.mas_equalTo(SCALE_NUM(14));
        make.height.mas_equalTo(SCALE_NUM(13));
    }];
    
    _remindTitleLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_remindTitleLabel];
    _remindTitleLabel.text = @"恭喜,报名申请通过！！！";
    _remindTitleLabel.textColor = KCOLOR_B4;
    _remindTitleLabel.font = CONTENT_FONT(15);
    [_remindTitleLabel sizeToFit];
    [_remindTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(17));
        make.left.equalTo(self.titleImageView.mas_right).offset(10).priorityLow();
        make.centerY.equalTo(_titleImageView);
    }];
    
    //中间内容部分
    _topLineView = [[UIView alloc]init];
    _topLineView.backgroundColor = KCOLOR_B2;
    [self.wrapContentView addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.top.equalTo(_wrapContentView).offset(SCALE_NUM(44));
        make.height.mas_equalTo(1);
    }];
    
    _headImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_headImageView];
    _headImageView.image = [UIImage imageNamed:@"headImage.jpg"];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLineView).offset(15);
        make.leading.mas_equalTo(10);
        make.width.mas_equalTo(SCALE_NUM(45));
        make.height.mas_equalTo(SCALE_NUM(45));
    }];
    _headImageView.layer.cornerRadius = SCALE_NUM(45)/2.0;
    _headImageView.layer.masksToBounds = YES;
    
    _contentTitleLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_contentTitleLabel];
    _contentTitleLabel.font = CONTENT_FONT(12);
    _contentTitleLabel.text = @"校级活动公告";
    _contentTitleLabel.textColor = KCOLOR_g1;
    [_contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.mas_right).offset(SCALE_NUM(10));
        make.trailing.mas_equalTo(SCALE_NUM(-5));
    }];
    
    _contentNameLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_contentNameLabel];
    _contentNameLabel.font = CONTENT_FONT(12);
    _contentNameLabel.text = @"名称：%@";
    _contentNameLabel.textColor = KCOLOR_B3;
    [_contentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_contentTitleLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(self.contentTitleLabel.mas_left);
        make.trailing.mas_equalTo(SCALE_NUM(-5));
    }];
    
    _activityTimeLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_activityTimeLabel];
    _activityTimeLabel.font = CONTENT_FONT(12);
    _activityTimeLabel.text = @"活动开始时间：%@";
    _activityTimeLabel.textColor = KCOLOR_B3;
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(14));
        make.top.equalTo(_contentNameLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_contentNameLabel);
    }];
    
    _bottomLineView = [[UIView alloc]init];
    [self.wrapContentView addSubview:_bottomLineView];
    _bottomLineView.backgroundColor = KCOLORGRAY_B6;
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_activityTimeLabel.mas_bottom).offset(SCALE_NUM(15));
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _tailLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_tailLabel];
    _tailLabel.text = @"看看还有什么人";
    _tailLabel.textColor = KCOLOR_B3;
    _tailLabel.font = CONTENT_FONT(12);
    [_tailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLineView.mas_bottom);
        make.bottom.equalTo(_wrapContentView);
        make.leading.mas_equalTo(10);
    }];
    
    _tailImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_tailImageView];
    _tailImageView.image = [UIImage imageNamed:@"mine-concern-particulars"];
    [_tailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tailLabel.mas_centerY);
        make.trailing.mas_equalTo(-10);
    }];
    
    _middleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.wrapContentView addSubview:_middleButton];
    _middleButton.backgroundColor = [UIColor clearColor];
    [_middleButton addTarget:self action:@selector(middleAction:) forControlEvents:UIControlEventTouchUpInside];
    [_middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLineView.mas_bottom);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.bottom.equalTo(_bottomLineView);
    }];
    
    _bottomButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.wrapContentView addSubview:_bottomButton];
    _bottomButton.backgroundColor = [UIColor clearColor];
    [_bottomButton addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLineView);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}


//点击中间部分cell
-(void)middleAction:(UIButton*)btn {
    YLogD(@"this is midele action");
    NSString *publishID;
    if (_notifyModel) {
        publishID = self.notifyModel.idStr;
    }
    else {
        publishID = [NSString stringWithFormat:@"%ld",(long)self.model.activityPublishedId];
    }
    ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc]initWithPublishID:publishID];
    [self.viewController.navigationController pushViewController:detailVC animated:YES needHiddenBottomBar:YES];
}

//点击下面部分cell
-(void)bottomAction:(UIButton*)btn {
    NSString *publishID;
    if (_notifyModel) {
        publishID = self.notifyModel.idStr;
    }
    else {
        publishID = [NSString stringWithFormat:@"%ld",(long)self.model.activityPublishedId];
    }
    WhoJoinInController *whoJoinIn = [[WhoJoinInController alloc]init];
    whoJoinIn.publishID = publishID;
    [self.viewController.navigationController pushViewController:whoJoinIn animated:YES needHiddenBottomBar:YES];
}

#pragma waring 此处需要添加图片
-(void)setCellType:(CELL_TYPE)cellType
{
    _cellType = cellType;
    if(cellType == NEED_CHECK) {
        self.remindTitleLabel.text = @"您的报名申请已提交,正在审核中";
    } else if (cellType == AUDIT_PASSED) {
        self.remindTitleLabel.text = @"恭喜,报名申请通过！！！";
    } else if (cellType == AUDIT_NOT_PASSED) {
        _titleImageView.image = [[UIImage imageNamed:@"havetime_icon_no"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(SCALE_NUM(16));
            make.height.mas_equalTo(SCALE_NUM(14));
            make.width.mas_equalTo(SCALE_NUM(5));
        }];
        _remindTitleLabel.text = @"很遗憾，你的报名申请未通过审核";
        _bottomLineView.hidden = YES;
        _tailLabel.text = @"";
        _tailImageView.image = nil;
        _bottomButton.enabled = NO;
    } else if (cellType == NOT_NEED_CHECK) {
        self.remindTitleLabel.text = @"你已成功参加活动";
    }
}

-(void)setData:(id)model
{
    if ([model isKindOfClass:[NoticeInfo class]]) {
        [self setNoticeInfoData:model];
    } else if ([model isKindOfClass:[NotifyInfoModel class]]) {
        [self setNotifyModel:model];
    }
}

-(void)setNoticeInfoData:(NoticeInfo *)model
{
    _model = model;
    Author *info = model.activityUser;
    
    if (![model.activityOrganizerHeadPic isEmpty])
        [_headImageView setFaceImageWithUrl:model.activityOrganizerHeadPic];
    else
        _headImageView.image = [UIImage imageNamed:@"default_head"];
    if (_cellType == NOT_NEED_CHECK) {
        _contentTitleLabel.text = model.activityOrganizer;
    }
    else {
        _contentTitleLabel.text = info.name;
    }
    _contentNameLabel.text = [NSString stringWithFormat:_contentNameLabel.text,model.activityName];
    _activityTimeLabel.text = [NSString stringWithFormat:_activityTimeLabel.text,[TimeFormatterConvert timeConvertToFommtterAvailable:model.activityStartTime]];
}

-(void)setNotifyData:(NotifyInfoModel *)model
{
    _notifyModel = model;
    _titleImageView.image = nil;
    [_headImageView setFaceImageWithUrl:model.headIcon];
    _remindTitleLabel.font = CONTENT_FONT(12);
    [_remindTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(5)).priorityHigh();
        make.trailing.mas_equalTo(SCALE_NUM(-3));
    }];
    _remindTitleLabel.text = model.em_push_title;
    _contentTitleLabel.text = model.organizer;
    _contentNameLabel.text = [NSString stringWithFormat:@"名称：%@",model.name];
    
    _activityTimeLabel.text = [NSString stringWithFormat:@"活动开始时间：%@",[TimeFormatterConvert timeConvertToFommtterAvailable:model.startTime]];
    
    _tailLabel.text = @"看看都有谁参加了";
}

@end
