//
//  ProfileOthersViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileOthersViewController.h"
#import "ConnectTag.h"
#import "ProfileFeedContentView.h"
#import "FeedTag.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"
#import "Feed.h"
#import "ContactManager.h"

#define KHEADIMGMARGIN SCALE_NUM(12)
#define KHEADIMGSIZE SCALE_NUM(45)

#define KLABELMARGIN_TOP SCALE_NUM(35)

@interface ProfileOthersViewController()
@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) ConnectTag *connectTag;
@property (nonatomic, strong) UILabel *respectLabel;
@property (nonatomic, strong) UILabel *coolLabel;
@property (nonatomic, strong) ProfileFeedContentView *feed;


@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;

@property (nonatomic, strong) UIView *loadingView;

@end

@implementation ProfileOthersViewController

- (id)initWithUserId:(NSString *)userId {
    self = [super init];
    if (self) {
        _userId = userId;
        self.hidesBottomBarWhenPushed = true;
    }
    return self;
}
- (void)viewDidLoad {
    [self initController];
    [self initView];
}
- (void)initController {
    self.navigationController.navigationBarHidden = false;
    self.title = @"详情";
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    self.view.backgroundColor = KCOLORWHITE;
}
- (void)initView {
    [self initScoll];
    [self initTop];
    [self initMiddle];
    [self initBottom];
}
- (void)initScoll {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    scroll.showsVerticalScrollIndicator = false;
    
    _containerView = [[UIView alloc] init];
    [scroll addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
        make.width.equalTo(scroll.mas_width);
    }];
}
- (void)initTop {
    _topView = [[UIView alloc] init];
    [_containerView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_containerView);
        make.top.left.equalTo(_containerView).offset(KHEADIMGMARGIN);
    }];
    _headImg = [[UIImageView alloc] init];
    [_topView addSubview:_headImg];
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_topView);
        make.size.mas_equalTo(CGSizeMake(KHEADIMGSIZE, KHEADIMGSIZE));
        make.bottom.lessThanOrEqualTo(_topView);
    }];
    _headImg.backgroundColor = [UIColor redColor];
    _headImg.layer.cornerRadius = KHEADIMGSIZE/2;
    _headImg.clipsToBounds = true;
    
    _nameLabel = [YUtils initLabel:CONTENT_FONT(14) color:[UIColor blackColor] text:@"用户" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [_topView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImg);
        make.left.mas_equalTo(_headImg.mas_right).offset(KHEADIMGMARGIN);
    }];
    
    _connectTag = [[ConnectTag alloc] init];
    [_topView addSubview:_connectTag];
    [_connectTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView);
        make.centerY.equalTo(_nameLabel);
    }];
    
    _contentLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"" frame:CGRectZero alignment:NSTextAlignmentLeft];
    _contentLabel.numberOfLines = 0;
    [_topView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.right.equalTo(_topView);
        make.bottom.lessThanOrEqualTo(_topView);
        make.top.equalTo(_nameLabel.mas_bottom).offset(SCALE_NUM(15));
    }];
    
}
- (void)initMiddle {
    _respectLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:[NSString stringWithFormat:@"%d人向%@撰写的内容敬酒", 2000, @"用户"] frame:CGRectZero alignment:NSTextAlignmentLeft];
    [_containerView addSubview:_respectLabel];
    [_respectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentLabel);
        make.top.equalTo(_topView.mas_bottom).offset(KLABELMARGIN_TOP);
    }];
    UIImageView *icon = [[UIImageView alloc] init];
    [_containerView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCALE_NUM(17));
        make.centerX.equalTo(_headImg);
        make.centerY.equalTo(_respectLabel);
    }];
    icon.image = [UIImage imageNamed:@"mine-toast"];
    
    _coolLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:[NSString stringWithFormat:@"%d人觉得%@很酷", 2000, @"用户"] frame:CGRectZero alignment:NSTextAlignmentLeft];
    [_containerView addSubview:_coolLabel];
    [_coolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_respectLabel);
        make.top.equalTo(_respectLabel.mas_bottom).offset(KLABELMARGIN_TOP);
    }];
    icon = [[UIImageView alloc] init];
    [_containerView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCALE_NUM(17));
        make.centerX.equalTo(_headImg);
        make.centerY.equalTo(_coolLabel);
    }];
    icon.image = [UIImage imageNamed:@"mine-heart"];
    
}

- (void)initBottom {
    _feed = [[ProfileFeedContentView alloc] initWithType:ProfileFeedOthers];
    [_containerView addSubview:_feed];
    [_feed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_coolLabel.mas_bottom).offset(KLABELMARGIN_TOP);
        make.right.equalTo(_topView);
        make.bottom.equalTo(_containerView);
    }];
    [_feed.tagView.tagIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headImg);
    }];
    [_feed.tagView.tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
    }];
}
- (void)preLoadData {
    _loadingView = [[UIView alloc] init];
    [self.view addSubview:_loadingView];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _loadingView.backgroundColor = KCOLORWHITE;
}
- (void)startLoadData {
    MBProgressHUD *hud = [YUtils showHUDAddedTo:_loadingView title:@"正在加载"];
    [[ContactManager sharedInstance] getUserDetailInfo:_userId hxId:nil block:^(YActionMessage *message) {
        [hud removeFromSuperview];
        if (message.isSuccess) {
            [_loadingView removeFromSuperview];
            [self loadData:message.object];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}
- (void)loadData:(ProfileInfo *)info {
    _userId = info.uid;
    _nameLabel.text = info.userName;
    [_connectTag updateWithTag:info.propetiesCommon];
    _contentLabel.text = info.selfIntro;
    if (_contentLabel.text.length == 0) {
        _contentLabel.text = @"一个没有态度的人";
    }
    _respectLabel.text = [NSString stringWithFormat:@"%d人向%@撰写的内容敬酒", (int)info.praiseCount, info.userName];
    _coolLabel.text = [NSString stringWithFormat:@"%d人觉得%@很酷", (int)info.coolCount, info.userName];
    if (info.lastFeeds.count == 0) {
        [_feed setData:nil];
    } else {
        [_feed setData:info.lastFeeds[0]];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self preLoadData];
}
- (void)viewDidAppear:(BOOL)animated {
    [self startLoadData];
}
@end
