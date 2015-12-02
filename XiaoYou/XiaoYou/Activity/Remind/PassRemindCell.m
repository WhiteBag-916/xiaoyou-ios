//
//  RemindCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PassRemindCell.h"
#import "ProfileInfo.h"
#import "WhoJoinInController.h"
#import "ActivityDetailViewController.h"
#import "TimeFormatterConvert.h"
#import "NotifyInfoModel.h"
#import "YUtils+UI.h"

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
    _wrapContentView = [YUtils initWrapContentViewWithBackGroundColor:[UIColor whiteColor]
                                                          borderWidth:1 borderColor:KCOLOR_B2
                                                         cornerRadius:5];
    [self.contentView addSubview:_wrapContentView];
    [_wrapContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(CELL_INSET);
        make.right.equalTo(self.contentView.mas_right).offset(-CELL_INSET);
    }];
    
    //上面部分View
    _titleImageView = [YUtils initImageViewWithImageName:@"tick"];
    [self.wrapContentView addSubview:_titleImageView];
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.equalTo(self.wrapContentView).offset(18);
        make.width.mas_equalTo(SCALE_NUM(14));
        make.height.mas_equalTo(SCALE_NUM(13));
    }];
    
    _remindTitleLabel = [[UILabel alloc]init];
    _remindTitleLabel = [YUtils initLabel:CONTENT_FONT(15) color:KCOLOR_B4
                                     text:@"恭喜,报名申请通过！！！"];
    [_remindTitleLabel sizeToFit];
    [self.wrapContentView addSubview:_remindTitleLabel];
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
    
    _headImageView = [YUtils initImageViewWithImageName:@"headImage.jpg"
                                           cornerRadius:SCALE_NUM(45)/2.0];
    [self.wrapContentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLineView).offset(15);
        make.leading.mas_equalTo(10);
        make.width.mas_equalTo(SCALE_NUM(45));
        make.height.mas_equalTo(SCALE_NUM(45));
    }];
    
    _contentTitleLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLOR_g1 text:@"校级活动公告"];
    [self.wrapContentView addSubview:_contentTitleLabel];
    [_contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.mas_right).offset(SCALE_NUM(10));
        make.trailing.mas_equalTo(SCALE_NUM(-5));
    }];
    
    _contentNameLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLOR_B3 text:@""];
    [self.wrapContentView addSubview:_contentNameLabel];
    [_contentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_contentTitleLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(self.contentTitleLabel.mas_left);
        make.trailing.mas_equalTo(SCALE_NUM(-5));
    }];
    
    _activityTimeLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLOR_B3 text:@""];
    [self.wrapContentView addSubview:_activityTimeLabel];
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
    
    _tailLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLOR_B3 text:@"看看还有什么人"];
    [self.wrapContentView addSubview:_tailLabel];
    [_tailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLineView.mas_bottom);
        make.bottom.equalTo(_wrapContentView);
        make.leading.mas_equalTo(10);
    }];
    
    _tailImageView = [YUtils initImageViewWithImageName:@"mine-concern-particulars"];
    [self.wrapContentView addSubview:_tailImageView];
    [_tailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tailLabel.mas_centerY);
        make.trailing.mas_equalTo(-10);
    }];
    
    _middleButton = [YUtils initButtonWithBackgroundColor:[UIColor clearColor]
                                                   target:self action:@selector(middleAction:)];
    [self.wrapContentView addSubview:_middleButton];
    [_middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLineView.mas_bottom);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.bottom.equalTo(_bottomLineView);
    }];
    
    _bottomButton = [YUtils initButtonWithBackgroundColor:[UIColor clearColor]
                                                   target:self action:@selector(bottomAction)];
    [self.wrapContentView addSubview:_bottomButton];
    [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLineView);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}


//点击中间部分cell
-(void)middleAction:(UIButton*)btn {
    NSString *publishID;
    if (_notifyModel) {
        publishID = self.notifyModel.idStr;
    }
    else {
        publishID = [NSString stringWithFormat:@"%ld",(long)self.model.activityPublishedId];
    }
    ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc]
                                              initWithPublishID:publishID];
    [self.viewController.navigationController pushViewController:detailVC animated:YES
                                             needHiddenBottomBar:YES];
}

//点击下面部分cell
-(void)bottomAction {
    NSString *publishID;
    if (_notifyModel) {
        publishID = self.notifyModel.idStr;
    }
    else {
        publishID = [NSString stringWithFormat:@"%ld",(long)self.model.activityPublishedId];
    }
    WhoJoinInController *whoJoinIn = [[WhoJoinInController alloc]init];
    whoJoinIn.publishID = publishID;
    [self.viewController.navigationController pushViewController:whoJoinIn animated:YES
                                             needHiddenBottomBar:YES];
}

#pragma waring 此处需要添加图片
-(void)setCellType:(CELL_TYPE)cellType
{
    _cellType = cellType;
    _bottomButton.enabled = YES;
    if(cellType == NEED_CHECK) {
        self.remindTitleLabel.text = @"您的报名申请已提交,正在审核中";
        _titleImageView.image = [[UIImage imageNamed:@"tick"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _bottomLineView.hidden = NO;
        _tailLabel.text = @"看看还有什么人";
        [_titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(10);
            make.top.equalTo(self.wrapContentView).offset(18);
            make.width.mas_equalTo(SCALE_NUM(14));
            make.height.mas_equalTo(SCALE_NUM(13));
        }];
        
    } else if (cellType == AUDIT_PASSED) {
        self.remindTitleLabel.text = @"恭喜,报名申请通过！！！";
        _titleImageView.image = [[UIImage imageNamed:@"tick"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _bottomLineView.hidden = NO;
        _tailLabel.text = @"看看还有什么人";
        
        [_titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(10);
            make.top.equalTo(self.wrapContentView).offset(18);
            make.width.mas_equalTo(SCALE_NUM(14));
            make.height.mas_equalTo(SCALE_NUM(13));
        }];
        
    } else if (cellType == AUDIT_NOT_PASSED) {
        _titleImageView.image = [[UIImage imageNamed:@"havetime_icon_no"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
        _titleImageView.image = [[UIImage imageNamed:@"tick"]
                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _bottomLineView.hidden = NO;
        _tailLabel.text = @"看看还有什么人";
        
        [_titleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(10);
            make.top.equalTo(self.wrapContentView).offset(18);
            make.width.mas_equalTo(SCALE_NUM(14));
            make.height.mas_equalTo(SCALE_NUM(13));
        }];
    }
}

-(void)setData:(id)model
{
    if ([model isKindOfClass:[NoticeInfo class]]) {
        [self setNoticeInfoData:model];
    } else if ([model isKindOfClass:[NotifyInfoModel class]]) {
        [self setNotifyInfoModelData:model];
    }
}

//列表请求数据使用
-(void)setNoticeInfoData:(NoticeInfo *)model
{
    _model = model;
    Author *info = model.activityUser;
    
    if (![model.activityOrganizerHeadPic isEmpty])
        [_headImageView setFaceImageWithUrl:model.activityOrganizerHeadPic];
    else
        _headImageView.image = [UIImage imageNamed:@"default_head"];
    
    _contentTitleLabel.text = model.activityOwner ? info.name : model.activityOrganizer;
    
    _contentNameLabel.text = [NSString stringWithFormat:@"名称：%@",model.activityName];
    _activityTimeLabel.text = [NSString
                               stringWithFormat:@"活动开始时间：%@",[TimeFormatterConvert
                                                                       timeConvertToFommtterAvailable:model.activityStartTime]];
}

//推送通知使用
-(void)setNotifyInfoModelData:(NotifyInfoModel *)model
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
    
    _activityTimeLabel.text = [NSString stringWithFormat:@"活动开始时间：%@",
                               [TimeFormatterConvert timeConvertToFommtterAvailable:model.startTime]];
    
    _tailLabel.text = @"看看都有谁参加了";
}

@end
