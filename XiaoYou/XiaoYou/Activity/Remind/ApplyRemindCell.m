//
//  ApplyRemindCell.m
//  XiaoYou
//
//  Created by sheng on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ApplyRemindCell.h"
#import "ConnectTag.h"
#import "Tags.h"
#import "UIImageView+Ext.h"
#import "ProfileInfo.h"

#define CELL_INSET          SCALE_NUM(12)
#define TOP_CELL_HEIGHT     SCALE_NUM(44)
#define REUSERID            @"ApplyRemindCell"
@interface ApplyRemindCell ()
//上面部分View
@property(nonatomic,retain) UIView      *wrapContentView;   //内容视图
@property(nonatomic,retain) UIImageView *titleImageView;    //图标
@property(nonatomic,retain) UILabel     *remindTitleLabel;  //标题
//中间分割线
@property(nonatomic,retain) UIView      *topLineView;       //上面分割线
//中间部分View
@property(nonatomic,retain) UIImageView *headImageView;     //中间内容
@property(nonatomic,strong) UILabel     *nameLabel;         //姓名
@property(nonatomic,strong) ConnectTag  *connectTagView;    //关系词(班社乡)
@property(nonatomic,strong) UILabel     *applyContentLable; //
//底部View
@property(nonatomic,strong) UIView      *bottomLineView;    //底部线

//底部View
@property(nonatomic,strong) UIView      *bottomSelectView;  //底部View
@property(nonatomic,strong) UIButton    *statusButton;      //申请状态(已同意，已忽略)
@property(nonatomic,strong) UIButton    *agreeButton;       //同意按钮
@property(nonatomic,strong) UIButton    *ignoreButton;      //忽略按钮
@property(nonatomic,strong) UIView      *middleLineView;    //中间分割线
@end

@implementation ApplyRemindCell


+(ApplyRemindCell *)cellWithTableView:(UITableView *)tableView
{
    ApplyRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSERID];
    if (!cell) {
        cell = [[ApplyRemindCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSERID];
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

-(void)setCellType:(APPLY_CELL_TYPE)cellType
{
    if (cellType == WAIT_SELECT) {
        _bottomSelectView.hidden = NO;
        _statusButton.hidden = YES;
        [_applyContentLable updateConstraints];
    }
    else if (cellType == IGNORED) {
        _statusButton.hidden = NO;
        _bottomSelectView.hidden = YES;
    }
}

-(BOOL)needLine
{
    return NO;
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
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(CELL_INSET);
        make.right.equalTo(self.mas_right).offset(-CELL_INSET);
    }];
    
    _wrapContentView.layer.cornerRadius = 5;
    _wrapContentView.clipsToBounds = YES;
    
    //上面部分View
    //1.对号图片
    _titleImageView = [[UIImageView alloc]init];
    _titleImageView.image = [UIImage imageNamed:@"tick"];
    [self.wrapContentView addSubview:_titleImageView];
    [_titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.equalTo(self).offset(18);
        make.width.mas_equalTo(SCALE_NUM(14));
        make.height.mas_equalTo(SCALE_NUM(13));
    }];
    
    //2.提醒标题
    _remindTitleLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_remindTitleLabel];
    _remindTitleLabel.text = @"有人参加你的活动";
    _remindTitleLabel.font = CONTENT_FONT(15);
    [_remindTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(17));
        make.left.equalTo(self.titleImageView.mas_right).offset(10).priorityLow();
        make.centerY.equalTo(_titleImageView);
    }];
    
    //中间内容部分，分割线
    _topLineView = [[UIView alloc]init];
    _topLineView.backgroundColor = KCOLOR_B2;
    [self.wrapContentView addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.top.equalTo(self.remindTitleLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    
    //1.头像
    _headImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_headImageView];
    _headImageView.image = [UIImage imageNamed:@"headImage.jpg"];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLineView).offset(15);
        make.leading.mas_equalTo(10);
        make.width.mas_equalTo(SCALE_NUM(45));
        make.height.mas_equalTo(SCALE_NUM(45));
    }];
    _headImageView.layer.cornerRadius = (SCALE_NUM(45)/2.0);
    _headImageView.clipsToBounds = YES;
    
    _nameLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_nameLabel];
    _nameLabel.font = CONTENT_FONT(12);
    _nameLabel.text = @"李颖";
    _nameLabel.textColor = KCOLOR_g1;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(SCALE_NUM(10));
        make.centerY.equalTo(_headImageView.mas_centerY);
    }];
    
    _connectTagView = [[ConnectTag alloc]init];
    [self.wrapContentView addSubview:_connectTagView];
    [_connectTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView.mas_centerY);
        make.trailing.mas_equalTo(SCALE_NUM(-10));
        //make.height.mas_equalTo(SCALE_NUM(20));
    }];
    
    Tags *tag1 = [[Tags alloc]init];
    tag1.name = @"班";
    Tags *tag2 = [[Tags alloc]init];
    tag2.name = @"社";
    Tags *tag3 = [[Tags alloc]init];
    tag3.name = @"乡";
    [_connectTagView updateWithTag:[NSArray arrayWithObjects:tag1,tag2,tag3, nil]];;
    
    _applyContentLable = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_applyContentLable];
    _applyContentLable.numberOfLines = 0;
    _applyContentLable.lineBreakMode = NSLineBreakByWordWrapping;
    _applyContentLable.text = @"参加了你的%@活动!";
    _applyContentLable.textColor = KCOLOR_B3;
    _applyContentLable.font = CONTENT_FONT(12);
    [_applyContentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom).offset(SCALE_NUM(21));
        make.left.equalTo(_headImageView);
        make.trailing.mas_equalTo(0);
        
    }];
    
//    _bottomLineView = [[UIView alloc]init];
//    [self.wrapContentView addSubview:_bottomLineView];
//    
//    _bottomLineView.backgroundColor = KCOLORGRAY_B6;
//    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(_wrapContentView);
//        make.trailing.equalTo(_wrapContentView);
//        make.height.mas_equalTo(1);
//        make.bottom.equalTo(_wrapContentView.mas_bottom).offset(SCALE_NUM(-44));
//    }];
    
//    [_applyContentLable mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(_bottomLineView.mas_top).offset(SCALE_NUM(-10));
//    }];
    
    //[self addStatusButton];
    //[self addBottomSelectView];
}

-(void)setData:(NoticeInfo *)model
{
    Author *info = model.activityUser;
    [_headImageView setFaceImageWithUrl:info.headPic];
    _nameLabel.text = info.name;
    //_applyContentLable.text = [NSString stringWithFormat:_applyContentLable.text,model.activityName];
    
    [_applyContentLable setText:[NSString stringWithFormat:_applyContentLable.text,model.activityName] lineSpacing:5.0];
    [_connectTagView updateWithTag:info.propetiesCommon];
}

-(void)setNotifyData:(NotifyInfoModel *)model
{
    _titleImageView.image = nil;
    [_remindTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(5)).priorityHigh();
    }];
    _remindTitleLabel.text = model.em_push_title;
    [_headImageView setFaceImageWithUrl:model.headIcon];
    _nameLabel.text = model.organizer;
    _applyContentLable.text = [NSString stringWithFormat:_applyContentLable.text,model.name];
}

@end
