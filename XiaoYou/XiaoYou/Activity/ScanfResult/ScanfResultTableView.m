//
//  ScanfResultTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ScanfResultTableView.h"
#import "ScanfResultTableViewCell.h"
#import "CodeManager.h"
#import "ShopList.h"
#import "SupplierShopModel.h"
#import "SupplierShopDiscounts.h"
#import "UIImageView+Ext.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"

@interface ScanfResultTableView ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

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

@property(nonatomic,strong)ShopList * model;
@property(nonatomic,strong)NSMutableArray * dataSourceArr;

@end

@implementation ScanfResultTableView

- (instancetype)initWithResult:(NSString *) result
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[ScanfResultTableViewCell class] forCellReuseIdentifier:kScanfResultTableViewCell];
        
        [YUtils showHUDWithTitle];
        
        [[CodeManager sharedInstance] getByQRCodeContent:result block:^(YActionMessage *message) {
            
            [YUtils hiddenProgressHUD];
            if (message.isSuccess)
            {
                _model = message.object;
                
                self.dataSourceArr = (NSMutableArray *)_model.supplierShopDiscounts;
                
                [self reloadData];
                
                [self setUpHeaderView];
                [self setUpFooterView];
            }
            else
            {
                [YUtils showTitle:message.desc hideAfter:2];
            }
        }];
        
    }
    return self;
}

-(NSMutableArray *)dataSourceArr
{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

-(void)setUpHeaderView
{
    SupplierShopModel * shopModel = _model.supplierShopModel;
    
    //背景图
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_NUM(170))];
    backgroundView.image = [UIImage imageNamed:@"scanf_head_background"];
    backgroundView.userInteractionEnabled = YES;
    
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
        make.centerX.centerY.equalTo(_backImageView);
        make.width.height.mas_equalTo(30);
    }];
    [backButton addTarget:self action:@selector(popToSuperController) forControlEvents:UIControlEventTouchUpInside];
    
    //名字
    _shopNameLabel = [[UILabel alloc] init];
    _shopNameLabel.text = shopModel.name;
    _shopNameLabel.font = CONTENT_FONT(14);
    _shopNameLabel.textColor = KCOLOR_W1;
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
    [_headImageView setNormalImageWithUrl:shopModel.shopLogoUrl];
    [backgroundView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backImageView);
        make.top.equalTo(_backImageView.mas_bottom).offset(SCALE_NUM(24));
        make.width.height.mas_equalTo(SCALE_NUM(80));
    }];
    
    //电话
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.text = shopModel.telephone;
    _phoneLabel.font = CONTENT_FONT(12);
    _phoneLabel.textColor = KCOLOR_g1;
    _phoneLabel.textAlignment = NSTextAlignmentLeft;
    _phoneLabel.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(SCALE_NUM(12));
        make.top.equalTo(_headImageView.mas_top).offset(SCALE_NUM(16));
        make.right.equalTo(backgroundView).offset(SCALE_NUM(15));
        make.height.mas_equalTo(12);
    }];
    
    UIButton * phoneButton = [[UIButton alloc] init];
    phoneButton.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:phoneButton];
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_phoneLabel);
        make.bottom.equalTo(_phoneLabel).offset(SCALE_NUM(10));
        make.top.equalTo(_phoneLabel).offset(SCALE_NUM(-10));
    }];
    [phoneButton addTarget:self action:@selector(callPhoneNum) forControlEvents:UIControlEventTouchUpInside];
    
    //位置
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.text = shopModel.address;
    _placeLabel.font = CONTENT_FONT(12);
    _placeLabel.textColor = KCOLOR_W1;
    _placeLabel.numberOfLines = 0;
    _placeLabel.textAlignment = NSTextAlignmentLeft;
    _placeLabel.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(SCALE_NUM(12));
        make.bottom.equalTo(_headImageView.mas_bottom).offset(SCALE_NUM(-10));
        make.right.equalTo(backgroundView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(35);
    }];
    
    //分割线
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = KCOLOR_B4;
    [backgroundView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(3));
    }];
    
    self.tableHeaderView = backgroundView;
}

-(void)setUpFooterView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_NUM(170))];
    
    ProfileInfo *info = [[ProvisionManager sharedInstance] getProfile];
    
    //分割线
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = KCOLOR_B4;
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
        make.width.mas_equalTo(SCALE_NUM(9));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    _stuNameLabel = [[UILabel alloc] init];
    _stuNameLabel.text = [NSString stringWithFormat:@"姓名：%@",info.userName];
    _stuNameLabel.font = CONTENT_FONT(12);
    _stuNameLabel.textColor = KCOLOR_B5;
    _stuNameLabel.textAlignment = NSTextAlignmentLeft;
    _stuNameLabel.backgroundColor = [UIColor clearColor];
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
        make.centerX.equalTo(_stuNameImageView);
        make.top.equalTo(_stuNameImageView.mas_bottom).offset(SCALE_NUM(15));
        make.width.mas_equalTo(SCALE_NUM(12));
        make.height.mas_equalTo(SCALE_NUM(11));
    }];
    
    _stuNumLabel = [[UILabel alloc] init];
    _stuNumLabel.text = [NSString stringWithFormat:@"学号：%@",info.studentNo];
    _stuNumLabel.font = CONTENT_FONT(12);
    _stuNumLabel.textColor = KCOLOR_B5;
    _stuNumLabel.textAlignment = NSTextAlignmentLeft;
    _stuNumLabel.backgroundColor = [UIColor clearColor];
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
        make.centerX.equalTo(_stuNameImageView);
        make.top.equalTo(_stuNumImageView.mas_bottom).offset(SCALE_NUM(15));
        make.width.mas_equalTo(SCALE_NUM(13));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    _toastCountLabel = [[UILabel alloc] init];
    _toastCountLabel.text = [NSString stringWithFormat:@"敬酒：%g",info.praiseCount];
    _toastCountLabel.font = CONTENT_FONT(12);
    _toastCountLabel.textColor = KCOLOR_B5;
    _toastCountLabel.textAlignment = NSTextAlignmentLeft;
    _toastCountLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_toastCountLabel];
    [_toastCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_stuNameLabel);
        make.centerY.equalTo(_toastCountImageView);
        make.right.equalTo(backView).offset(SCALE_NUM(-15));
        make.height.mas_equalTo(12);
    }];
    
    //提示Label
    _remindLabel = [[UILabel alloc] init];
    _remindLabel.text = @"敬酒数量越多可获得更加优惠的校友礼劵!";
    _remindLabel.font = CONTENT_FONT(14);
    _remindLabel.textColor = KCOLOR_g1;
    _remindLabel.textAlignment = NSTextAlignmentCenter;
    _remindLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_remindLabel];
    [_remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(SCALE_NUM(10));
        make.top.equalTo(_toastCountImageView.mas_bottom).offset(SCALE_NUM(15));
        make.right.equalTo(backView).offset(SCALE_NUM(-10));
        make.height.mas_equalTo(SCALE_NUM(14));
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
    return _dataSourceArr.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanfResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kScanfResultTableViewCell forIndexPath:indexPath];
    if (indexPath.row == 0)
    {
        [cell setCellInfo:nil isHeader:YES];
    }
    else
    {
        [cell setCellInfo:_dataSourceArr[indexPath.row - 1] isHeader:NO];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSourceArr.count == indexPath.row) {
        return SCALE_NUM(70);
    }
    else
    {
        return SCALE_NUM(50);
    }
}

-(void)callPhoneNum
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:_phoneLabel.text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString * phoneStr = [NSString stringWithFormat:@"tel://%@",_phoneLabel.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr]];
    }
    else
    {
        return;
    }
}

@end
