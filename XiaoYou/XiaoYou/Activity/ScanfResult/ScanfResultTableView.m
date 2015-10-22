//
//  ScanfResultTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScanfResultTableView.h"
#import "ScanfResultTableViewCell.h"

@interface ScanfResultTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView * backImageView;
@property(nonatomic,strong)UILabel * shopNameLabel;

@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * phoneLabel;
@property(nonatomic,strong)UILabel * placeLabel;


@property(nonatomic,strong)UIImageView * stuNameImageView;
@property(nonatomic,strong)UIImageView * stuNumImageView;
@property(nonatomic,strong)UIImageView * toastCountImageView;
@property(nonatomic,strong)UILabel * stuNameLabel;
@property(nonatomic,strong)UILabel * stuNumLabel;
@property(nonatomic,strong)UILabel * toastCountLabel;
@property(nonatomic,strong)UILabel * remindLabel;

@end

@implementation ScanfResultTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[ScanfResultTableViewCell class] forCellReuseIdentifier:kScanfResultTableViewCell];
        
        [self setUpHeaderView];
        [self setUpFooterView];
    }
    return self;
}

-(void)setUpHeaderView
{
    //背景图
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    backgroundView.image = [UIImage imageNamed:@"scanf_head_background"];
    
    //返回按钮
    _backImageView = [[UIImageView alloc]init];
    _backImageView.userInteractionEnabled = YES;
    _backImageView.image = [UIImage imageNamed:@"common_back"];
    [backgroundView addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(35));
        make.left.mas_equalTo(SCALE_NUM(15));
        make.width.mas_equalTo(SCALE_NUM(8));
        make.height.mas_equalTo(SCALE_NUM(13));
    }];
    UIButton * backButton = [[UIButton alloc] init];
    backButton.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_backImageView);
        make.width.height.mas_equalTo(30);
    }];
    [backButton addTarget:self action:@selector(popToSuperController) forControlEvents:UIControlEventTouchUpInside];
    
    //名字
    _shopNameLabel = [[UILabel alloc] init];
    _shopNameLabel.text = @"AntiSlim Coffee";
    _shopNameLabel.font = CONTENT_FONT(14);
    _shopNameLabel.textColor = KCOLORGREEN_W1;
    _shopNameLabel.textAlignment = NSTextAlignmentCenter;
    _shopNameLabel.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:_shopNameLabel];
    [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backImageView);
        make.centerX.equalTo(backgroundView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(250);
    }];
    
    //头像
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = 4;
    _headImageView.clipsToBounds = YES;
    _headImageView.image = [UIImage imageNamed:@"common_picture_loading"];
    [backgroundView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backImageView);
        make.top.equalTo(_backImageView.mas_bottom).offset(SCALE_NUM(24));
        make.width.height.mas_equalTo(SCALE_NUM(80));
    }];
    
    //电话
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.text = @"Tel：022-6666 6666";
    _phoneLabel.font = CONTENT_FONT(12);
    _phoneLabel.textColor = KCOLORGREEN_W1;
    _phoneLabel.textAlignment = NSTextAlignmentLeft;
    _phoneLabel.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(SCALE_NUM(12));
        make.top.equalTo(_headImageView.mas_top).offset(SCALE_NUM(16));
        make.right.equalTo(backgroundView).offset(SCALE_NUM(15));
        make.height.mas_equalTo(12);
    }];
    
    //位置
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.text = @"和平区西湖道风荷园1-4-201";
    _placeLabel.font = CONTENT_FONT(12);
    _placeLabel.textColor = KCOLORGREEN_W1;
    _placeLabel.textAlignment = NSTextAlignmentLeft;
    _placeLabel.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(SCALE_NUM(12));
        make.bottom.equalTo(_headImageView.mas_bottom).offset(SCALE_NUM(-16));
        make.right.equalTo(backgroundView).offset(SCALE_NUM(15));
        make.height.mas_equalTo(12);
    }];
    
    //分割线
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = KCOLORGREEN_B4;
    [backgroundView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(3));
    }];
    
    self.tableHeaderView = backgroundView;
}

-(void)setUpFooterView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    
    //分割线
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = KCOLORGREEN_B4;
    [backView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(3));
    }];
    
    //姓名
    _stuNameImageView = [[UIImageView alloc] init];
    _stuNameImageView.image = [UIImage imageNamed:@"scanf_stu_name"];
    [backView addSubview:_stuNameImageView];
    [_stuNameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(30));
        make.top.mas_equalTo(SCALE_NUM(25));
        make.width.mas_equalTo(SCALE_NUM(18));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    
    _stuNameLabel = [[UILabel alloc] init];
    _stuNameLabel.text = @"姓名：校园小助手";
    _stuNameLabel.font = CONTENT_FONT(12);
    _stuNameLabel.textColor = KCOLORGREEN_B5;
    _stuNameLabel.textAlignment = NSTextAlignmentLeft;
    _stuNameLabel.backgroundColor = [UIColor orangeColor];
    [backView addSubview:_stuNameLabel];
    [_stuNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_stuNameImageView.mas_right).offset(SCALE_NUM(20));
        make.centerY.equalTo(_stuNameImageView);
        make.right.equalTo(backView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(12);
    }];
    
    //学号
    _stuNumImageView = [[UIImageView alloc] init];
    _stuNumImageView.image = [UIImage imageNamed:@"scanf_stu_num"];
    [backView addSubview:_stuNumImageView];
    [_stuNumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(30));
        make.top.equalTo(_stuNameImageView.mas_bottom).offset(SCALE_NUM(15));
        make.width.mas_equalTo(SCALE_NUM(24));
        make.height.mas_equalTo(SCALE_NUM(22));
    }];
    
    _stuNumLabel = [[UILabel alloc] init];
    _stuNumLabel.text = @"学号：100001";
    _stuNumLabel.font = CONTENT_FONT(12);
    _stuNumLabel.textColor = KCOLORGREEN_B5;
    _stuNumLabel.textAlignment = NSTextAlignmentLeft;
    _stuNumLabel.backgroundColor = [UIColor orangeColor];
    [backView addSubview:_stuNumLabel];
    [_stuNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_stuNameLabel);
        make.centerY.equalTo(_stuNumImageView);
        make.right.equalTo(backView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(12);
    }];
    
    //敬酒数
    _toastCountImageView = [[UIImageView alloc] init];
    _toastCountImageView.image = [UIImage imageNamed:@"scanf_stu_toast"];
    [backView addSubview:_toastCountImageView];
    [_toastCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(30));
        make.top.equalTo(_stuNumImageView.mas_bottom).offset(SCALE_NUM(15));
        make.width.mas_equalTo(SCALE_NUM(26));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    
    _toastCountLabel = [[UILabel alloc] init];
    _toastCountLabel.text = @"敬酒数：121";
    _toastCountLabel.font = CONTENT_FONT(12);
    _toastCountLabel.textColor = KCOLORGREEN_B5;
    _toastCountLabel.textAlignment = NSTextAlignmentLeft;
    _toastCountLabel.backgroundColor = [UIColor orangeColor];
    [backView addSubview:_toastCountLabel];
    [_toastCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_stuNameLabel);
        make.centerY.equalTo(_toastCountImageView);
        make.right.equalTo(backView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(12);
    }];
    
    //提示Label
    _remindLabel = [[UILabel alloc] init];
    _remindLabel.text = @"敬酒数量越多";
    _remindLabel.font = CONTENT_FONT(12);
    _remindLabel.textColor = KCOLORGREEN_B5;
    _remindLabel.textAlignment = NSTextAlignmentLeft;
    _remindLabel.backgroundColor = [UIColor orangeColor];
    [backView addSubview:_remindLabel];
    [_remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_stuNameLabel);
        make.centerY.equalTo(_toastCountImageView);
        make.right.equalTo(backView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(12);
    }];
    self.tableFooterView = backView;
    
}

-(void)popToSuperController
{
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanfResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kScanfResultTableViewCell forIndexPath:indexPath];
    if (indexPath.row == 0)
    {
        [cell setCellInfo:@"商家优惠详情" isHeader:YES];
    }
    else
    {
        [cell setCellInfo:@"商家优惠优惠详情" isHeader:NO];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(50);
}

@end
