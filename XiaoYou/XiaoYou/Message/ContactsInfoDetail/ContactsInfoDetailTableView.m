//
//  ContactsInfoDetailTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsInfoDetailTableView.h"
#import "ContactsInfoDetailTableViewCell.h"
#import "ConnectTag.h"
#import "UIImageView+Ext.h"
#import "Tags.h"
#import "ProfilePublishViewController.h"
#import "ContactManager.h"
#import "YUtils+HUD.h"

#define kHeaderViewHeight              90
#define kHeadWidthAndHeight            46
#define kNameLabelWidth                80
#define kHeadCornerRadius              23
#define kPaddingDistance               12
#define kLabelHeightDistacnce          14
#define kFlagImageViewWidth            9
#define kFlagImageViewHeight           13


@interface ContactsInfoDetailTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *flagLabel;
@property (strong, nonatomic)  UILabel *statesLabel;
@property (strong, nonatomic)  ConnectTag * connectTag;
@property (nonatomic,strong) ProfileInfo * model;

@property (nonatomic,strong) UIView * feedBackView;
@property (nonatomic,strong) UILabel * feedLabel;
@property (nonatomic,strong) UILabel * feedCountLabel;
@property (nonatomic,strong) UIImageView * flagImageView;

@property (nonatomic,strong) NSMutableArray * flagNameArr;

@end

@implementation ContactsInfoDetailTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = NO;
        
        [self registerClass:[ContactsInfoDetailTableViewCell class] forCellReuseIdentifier:kContactsInfoDetailTableViewCell];
    }
    return self;
}

-(void)refreshTableView:(ProfileInfo *) model
{
    _model = model;
    self.flagNameArr = [[NSMutableArray alloc]init];
    for (int i = 0; i <_model.tagsCommon.count; i++)
    {
        [self.flagNameArr addObject:[_model.tagsCommon[i] name]];
    }
    [self setUpHeaderView];
    [self setUpFooterView];
    [self reloadData];
}

-(void)setUpHeaderView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewHeight)];
    //头像
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = kHeadCornerRadius;
    _headImageView.clipsToBounds = YES;
    _headImageView.backgroundColor = [UIColor clearColor];
    [_headImageView setFaceImageWithUrl:_model.headPic];
    [backView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPaddingDistance);
        make.centerY.equalTo(backView);
        make.width.height.mas_equalTo(kHeadWidthAndHeight);
    }];
    //姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = CONTENT_FONT(14);
    _nameLabel.text = _model.userName;
    _nameLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.width.mas_equalTo(kNameLabelWidth);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
   //标签
    _connectTag = [[ConnectTag alloc] init];
    [backView addSubview:_connectTag];
    [_connectTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kPaddingDistance);
        make.top.mas_equalTo(kPaddingDistance);
    }];

    //共同标签
    [_connectTag updateWithTag:_model.propetiesCommon];
    //状态
    _statesLabel = [[UILabel alloc] init];
    _statesLabel.font = CONTENT_FONT(12);
    _statesLabel.numberOfLines = 0;
    if (![_model.selfIntro isEqualToString:@""])
    {
        _statesLabel.text = _model.selfIntro;
    }
    else
    {
        _statesLabel.text = @"一个没有态度的人";
    }
    
    _statesLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_statesLabel];
    [_statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.right.equalTo(backView).offset(-kPaddingDistance);
        make.top.equalTo(_nameLabel.mas_bottom).offset(kPaddingDistance);
    }];
    self.tableHeaderView = backView;
    

}

-(void)setUpFooterView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewHeight)];
    //头像
    _feedBackView = [[UIImageView alloc] init];
    _feedBackView.layer.cornerRadius = kHeadCornerRadius;
    _feedBackView.clipsToBounds = YES;
    _feedBackView.backgroundColor = [UIColor hexChangeFloat:@"258f74"];
    [backView addSubview:_feedBackView];
    [_feedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPaddingDistance);
        make.centerY.equalTo(backView);
        make.width.height.mas_equalTo(kHeadWidthAndHeight);
    }];
    _feedCountLabel = [[UILabel alloc] init];
    _feedCountLabel.backgroundColor = [UIColor clearColor];
    _feedCountLabel.textColor = [UIColor whiteColor];
    _feedCountLabel.textAlignment = NSTextAlignmentCenter;
    _feedCountLabel.text = @"观点";
    [backView addSubview:_feedCountLabel];
    [_feedCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPaddingDistance);
        make.centerY.equalTo(backView);
        make.width.height.mas_equalTo(kHeadWidthAndHeight);
    }];
    
    //姓名
    _feedLabel = [[UILabel alloc] init];
    _feedLabel.font = CONTENT_FONT(14);
    _feedLabel.text = [NSString stringWithFormat:@"共%g条",_model.feedCount];
    _feedLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_feedLabel];
    [_feedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_feedBackView);
        make.left.equalTo(_feedBackView.mas_right).offset(kPaddingDistance);
        make.width.mas_equalTo(kNameLabelWidth);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    
    _flagImageView = [[UIImageView alloc] init];
    _flagImageView.backgroundColor = [UIColor clearColor];
    _flagImageView.image = [UIImage imageNamed:@"mine-concern-particulars"];
    [backView addSubview:_flagImageView];
    [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_feedBackView);
        make.right.mas_equalTo(-kPaddingDistance);
        make.width.mas_equalTo(kFlagImageViewWidth);
        make.height.mas_equalTo(kFlagImageViewHeight);
    }];
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFooterView)];
    [backView addGestureRecognizer:tapGestureRecognizer];
    
    self.tableFooterView = backView;
}

-(void)tapFooterView
{
    ProfilePublishViewController * profilePublish = [[ProfilePublishViewController alloc] initWithUserId:_model.uid name:_model.userName];
    [self.myController.navigationController pushViewController:profilePublish animated:YES needHiddenBottomBar:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _flagNameArr.count + 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ContactsInfoDetailTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kContactsInfoDetailTableViewCell forIndexPath:indexPath];
    
    NSString * indexStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    if (indexPath.row == 0)
    {
        NSDictionary * dic = @{@"content":[NSString stringWithFormat:@"%g人向%@撰写的内容敬酒",_model.praiseCount,_model.userName],@"index":indexStr};
        [cell setCellInfo:dic hiddenLine:YES];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        NSDictionary * dic = @{@"content":[NSString stringWithFormat:@"%g人觉得%@很酷",_model.coolCount,_model.userName],@"index":indexStr, @"isCool":@(_model.isCool)};
        [cell setCellInfo:dic hiddenLine:YES];
        return cell;
    }
    else
    {
        NSDictionary * dic = @{@"content":self.flagNameArr[indexPath.row - 2],@"index":indexStr};
        [cell setCellInfo:dic hiddenLine:YES];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1)
    {
        return 60;
    }
    else
    {
        return 40;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        [YUtils showHUDWithTitle];
        [[ContactManager sharedInstance] praise:_model.uid block:^(YActionMessage *message) {
            if (message.isSuccess) {
                _model.isCool = !_model.isCool;
                if (_model.isCool) {
                    ++_model.coolCount;
                } else {
                    --_model.coolCount;
                }
                
                [self reloadData];
            }
            [YUtils hiddenProgressHUD];
        }];
    }
}
@end
