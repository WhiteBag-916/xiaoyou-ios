//
//  RemindCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PassRemindCell.h"
#import "DataConvert.h"

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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KCOLORGREEN_B1;
        [self initView];
    }
    return self;
}

-(void)setData:(RemindInfo *)remindInfo
{
    
}

-(void)initView
{
    //容器视图
    _wrapContentView = [[UIView alloc]init];
    [self.contentView addSubview:_wrapContentView];
    _wrapContentView.backgroundColor = [UIColor whiteColor];
    _wrapContentView.layer.borderWidth = 1;
    _wrapContentView.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1].CGColor;
    [_wrapContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CELL_INSET);
        make.right.equalTo(self.mas_right).offset(-CELL_INSET);
    }];
    
    _wrapContentView.layer.cornerRadius = 5;
    _wrapContentView.clipsToBounds = YES;
    
    //上面部分View
    _titleImageView = [[UIImageView alloc]init];
    _titleImageView.image = [UIImage imageNamed:@"tick"];
    [self.wrapContentView addSubview:_titleImageView];
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.equalTo(self).offset(18);
        make.width.mas_equalTo(SCALE_NUM(14));
        make.height.mas_equalTo(SCALE_NUM(13));
    }];
    
    _remindTitleLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_remindTitleLabel];
    _remindTitleLabel.text = @"恭喜,报名申请通过！！！";
    _remindTitleLabel.textColor = KCOLORGREEN_B4;
    _remindTitleLabel.font = CONTENT_FONT(15);
    [_remindTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.left.equalTo(self.titleImageView.mas_right).offset(10);
        make.centerY.equalTo(_titleImageView);
    }];
    
    //中间内容部分
    _topLineView = [[UIView alloc]init];
    _topLineView.backgroundColor = KCOLORGRAY;
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
    _headImageView.layer.cornerRadius = 25;
    _headImageView.clipsToBounds = YES;
    
    _contentTitleLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_contentTitleLabel];
    _contentTitleLabel.font = CONTENT_FONT(12);
    _contentTitleLabel.text = @"校级活动公告";
    _contentTitleLabel.textColor = KCOLORGREEN_g1;
    [_contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
    }];
    
    _contentNameLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_contentNameLabel];
    _contentNameLabel.font = CONTENT_FONT(12);
    _contentNameLabel.text = @"名称：校级舞蹈大赛";
    _contentNameLabel.textColor = KCOLORGREEN_B3;
    [_contentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_contentTitleLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(self.contentTitleLabel.mas_left);
        //make.bottom.equalTo(self.headImageView.mas_bottom);
    }];
    
    _activityTimeLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_activityTimeLabel];
    _activityTimeLabel.font = CONTENT_FONT(12);
    _activityTimeLabel.text = @"活动时间：15/12/12 18:00-20:00";
    _activityTimeLabel.textColor = KCOLORGREEN_B3;
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(_contentNameLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_contentNameLabel);
    }];
    
    _bottomLineView = [[UIView alloc]init];
    [self.wrapContentView addSubview:_bottomLineView];
    _bottomLineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_activityTimeLabel.mas_bottom).offset(SCALE_NUM(15));
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _tailLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_tailLabel];
    _tailLabel.text = @"看看还有什么人";
    _tailLabel.textColor = KCOLORGREEN_B3;
    _tailLabel.font = CONTENT_FONT(12);
    [_tailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(SCALE_NUM(12));
//        make.top.equalTo(_bottomLineView).equalTo(make.bottom.equalTo(_wrapContentView));
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
}


#pragma waring 此处需要添加图片
-(void)setCellType:(CELL_TYPE)cellType
{
    _cellType = cellType;
    if(cellType == ALREADY_SUBMIT) {
        self.remindTitleLabel.text = @"报名申请已提交,请等待审核结果";
    } else if (cellType == AUDIT_PASSED) {
        //do nothing
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
    } else if (cellType == SUCESSED_JOININ) {
        self.remindTitleLabel.text = @"你已成功参加活动";
    }
}

@end
