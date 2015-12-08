//
//  JoinInTopView.m
//  XiaoYou
//
//  Created by sheng on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#define HEADIMAGE_LEADING   SCALE_NUM(12)
#define HEAD_IMAGE_SIZE     SCALE_NUM(45)
#define NAME_LEADING        SCALE_NUM(14)
#import "JoinInTopView.h"
#import "ContactManager.h"
#import "XYContactsInfoDetailViewController.h"
#import "YShareData.h"
#import "ProfileViewController.h"
#import "ProfileMyViewController.h"

@interface JoinInTopView ()

@property (nonatomic,strong) UIImageView    *headImageView;         //头像
@property (nonatomic,strong) UILabel        *nameLabel;             //姓名
@property (nonatomic,strong) UIImageView    *genderImageView;       //性别
@property (nonatomic,strong) UIButton       *addFriendImageView;    //添加好友
@property (nonatomic,strong) UILabel        *isSelfNameLabel;       //是否是自己

@property (nonatomic,strong) Author         *author;                //数据模型

@end

@implementation JoinInTopView


-(instancetype)init
{
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)setData:(Author *)author
{
    _author = author;
    [_headImageView setFaceImageWithUrl:author.headPic];
    _nameLabel.text = author.name;
    [self updateStatus:author.friendStatus];
    
    if ([author.gender isEqualToString:@"男"]) {
        _genderImageView.image = [UIImage imageNamed:@"funny_detail_boy"];
    } else
    {
        _genderImageView.image = [UIImage imageNamed:@"funny_detail_girl"];
    }
    
    NSString *myUid = [[YShareData defaultData] valueForKey:kShareData_UserID];
    if (![author.uid isEqualToString:myUid]) {
        _isSelfNameLabel.text = @"";
    } else
    {
        _genderImageView.image = nil;
        _isSelfNameLabel.text = @"自己";
        _isSelfNameLabel.font = CONTENT_FONT(10);
        _isSelfNameLabel.textColor = KCOLOR_B5;
        [_isSelfNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_genderImageView.mas_left).offset(SCALE_NUM(0)).priorityHigh();
        }];
    }
}

-(void)initView
{
    _headImageView = [YUtils initImageViewWithImageName:@"headImage.jpg" cornerRadius:HEAD_IMAGE_SIZE/2.0];
    [self addSubview:_headImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(gotoPersonDetail)];
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:tap];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(HEADIMAGE_LEADING);
        make.top.mas_equalTo(HEADIMAGE_LEADING);
        make.width.mas_equalTo(HEAD_IMAGE_SIZE);
        make.height.mas_equalTo(HEAD_IMAGE_SIZE);
    }];
    
    _nameLabel = [YUtils initLabel:CONTENT_FONT(14) color:nil text:@""];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headImageView.centerY);
        make.left.equalTo(_headImageView.mas_right).offset(NAME_LEADING);
    }];
    
    _genderImageView = [YUtils initImageViewWithImageName:@"funny_detail_boy"];
    [self addSubview:_genderImageView];
    [_genderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(SCALE_NUM(10));
        make.centerY.equalTo(_nameLabel.mas_centerY);
        make.height.mas_equalTo(SCALE_NUM(14));
        make.width.mas_equalTo(SCALE_NUM(14));
    }];
    
    _isSelfNameLabel = [YUtils initLabel:CONTENT_FONT(10) color:nil text:@"自己"];
    [self addSubview:_isSelfNameLabel];
    [_isSelfNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_genderImageView.mas_right).offset(SCALE_NUM(8)).priorityLow();
        make.top.equalTo(_genderImageView);
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    _addFriendImageView = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:_addFriendImageView];
    [_addFriendImageView addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
    [_addFriendImageView setImage:[[UIImage imageNamed:@"mine-add-friend"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_addFriendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.top.equalTo(_headImageView.mas_top).offset(SCALE_NUM(2));
        make.height.mas_equalTo(SCALE_NUM(25));
        make.width.mas_equalTo(SCALE_NUM(25));
    }];
}

//更新好友申请状态
//1 陌生人、2 申请中、3 已是好友
- (void)updateStatus:(NSString *)status {
    if ([status isEqualToString:@"1"]) {
        _addFriendImageView.hidden = false;
        _addFriendImageView.enabled = true;
    }
    if ([status isEqualToString:@"2"]) {
        _addFriendImageView.hidden = false;
        _addFriendImageView.enabled = false;
        [_addFriendImageView setImage:[[UIImage imageNamed:@"add-friend-no"]
                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                             forState:UIControlStateNormal];
    }
    if ([status isEqualToString:@"3"]) {
        _addFriendImageView.hidden = true;
    }
}

//添加好友
- (void)clickAdd {
    //展示提示
    [YAnalysis trackEvent:@"加好友_活动详情" withPara:nil];
    YCommonAlertView *alert = [[YCommonAlertView alloc]
                               initWithTitle:nil message:
                               [NSString stringWithFormat:@"确定向%@发送好友申请吗？", _author.name]
                                                         buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        if (1 == index) {
            [YAnalysis trackEvent:@"确定_人_加好友弹窗" withPara:nil];
            [YUtils showHUDWithTitle:@"发送中"];
            [[ContactManager sharedInstance]
             submitFriendApply:_author.uid block:^(YActionMessage *message) {
                 [YUtils hiddenProgressHUD];
                if (message.isSuccess) {
                    _author.friendStatus = @"2";
                    [self updateStatus:_author.friendStatus];
                }
                [YUtils showTitle:message.desc];
            }];
        } else {
            [YAnalysis trackEvent:@"取消_人_加好友弹窗" withPara:nil];
        }
    }];
    [alert show];
}

- (void)gotoPersonDetail {
    [YAnalysis trackEvent:@"参加活动的用户_活动详情" withPara:nil];
    XYContactsInfoDetailViewController *detailVC = [[XYContactsInfoDetailViewController alloc]init];
    detailVC.uid = _author.uid;
    
    ProfileMyViewController *myVC = [[ProfileMyViewController alloc]init];
    
    //
    if ([_author.uid isEqualToString:[[YShareData defaultData] valueForKey:kShareData_UserID]]) {
        [self.viewController.navigationController pushViewController:myVC animated:YES
                                                 needHiddenBottomBar:YES];
    }
    else {
        [self.viewController.navigationController pushViewController:detailVC animated:YES
                                                 needHiddenBottomBar:YES];
    }
}

@end
