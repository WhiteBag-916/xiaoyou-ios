//
//  ApplyRemindCell.m
//  XiaoYou
//
//  Created by sheng on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ApplyRemindCell.h"

#define CELL_INSET          SCALE_NUM(12)
#define TOP_CELL_HEIGHT     SCALE_NUM(44)

@interface ApplyRemindCell ()

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

@implementation ApplyRemindCell


//+(ApplyRemindCell *)cellWithTableView:(UITableView *)tableView
//{
//    //ApplyRemindCell *cel
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    _topLineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
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
}



@end
