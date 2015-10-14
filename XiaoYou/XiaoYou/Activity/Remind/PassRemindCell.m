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

@property(nonatomic,retain) UIView      *wrapContentView;   //内容视图
@property(nonatomic,retain) UIImageView *titleImageView;    //图标
@property(nonatomic,retain) UILabel     *remindTitleLabel;  //标题
@property(nonatomic,retain) UIView      *topLineView;       //上面分割线
@property(nonatomic,retain) UIImageView *headImageView;     //中间内容
@property(nonatomic,retain) UILabel     *contentTitleLabel; //内容标题
@property(nonatomic,retain) UILabel     *contentNameLabel;  //内容名
@property(nonatomic,retain) UIView      *bottomLineView;    //下面分割线
@property(nonatomic,retain) UILabel     *tailLabel;         //尾部文字
@property(nonatomic,retain) UIImageView *tailImageView;     //尾部next图片

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
        self.backgroundColor = [UIColor colorWithRed:246.0/255 green:247/255 blue:249/255 alpha:0];
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
    _remindTitleLabel.text = @"活动申请通过！！！";
    _remindTitleLabel.font = [UIFont systemFontOfSize:14];
    [_remindTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.mas_right).offset(10);
        make.top.equalTo(self.titleImageView);
        make.height.equalTo(self.titleImageView);
        
    }];
    
    //中间内容部分
    _topLineView = [[UIView alloc]init];
    _topLineView.backgroundColor = KCOLORGRAY;
    [self.wrapContentView addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.top.equalTo(self.remindTitleLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    
    _headImageView = [[UIImageView alloc]init];
    [self.wrapContentView addSubview:_headImageView];
    _headImageView.image = [UIImage imageNamed:@"chatBar_face"];
    
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
    _contentTitleLabel.font = [UIFont systemFontOfSize:12.0f];
    _contentTitleLabel.text = @"校级活动公告";
    [_contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
    }];
    
    _contentNameLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_contentNameLabel];
    _contentNameLabel.font = [UIFont systemFontOfSize:12.0f];
    _contentNameLabel.text = @"名称：校级舞蹈大赛";
    [_contentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentTitleLabel.mas_left);
        make.bottom.equalTo(self.headImageView.mas_bottom);
    }];
    
    _bottomLineView = [[UIView alloc]init];
    [self.wrapContentView addSubview:_bottomLineView];
    _bottomLineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _tailLabel = [[UILabel alloc]init];
    [self.wrapContentView addSubview:_tailLabel];
    _tailLabel.text = @"看看还有什么人";
    _tailLabel.font = [UIFont systemFontOfSize:12.0f];
    [_tailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLineView.mas_bottom).offset(16);
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

@end
