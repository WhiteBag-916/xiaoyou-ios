//
//  ProfileViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileViewController.h"
#import "YUtils+Component.h"
#import "ProfilePersonListController.h"
#import "ProfileFeedContentView.h"
#import "ProfilePublishViewController.h"
#import "ProfileMyViewController.h"
#import "YCommonEditViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileInfo.h"
#import "YUtils+HUD.h"
#import "YActionMessage.h"
#import "ProvisionManager.h"
#import "ProfileTagViewController.h"

#import "ProfileOthersViewController.h"

#define KTOPHEIGHT SCALE_NUM(90)
#define KHEADIMG_SIZE SCALE_NUM(45)
#define KHEADIMGMARIN_LEFT SCALE_NUM(10)
#define KHEADIMGMARIN_DOWN SCALE_NUM(15)

#define KNAMEMARGIN_LEFT SCALE_NUM(12)
#define KSCHOOLNOMARGIN_TOP SCALE_NUM(10)

#define KMIDDELITEMHEIGHT SCALE_NUM(50)
#define KBOTTOMITEMMARGIN_TOP SCALE_NUM(20)
#define KBOTTOMLABELSIZE SCALE_NUM(35)

#define KFEEDMARGIN_TOP SCALE_NUM(20)

@interface ProfileViewController ()
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *schoolNo;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *respectNum;
@property (nonatomic, strong) UILabel *coolNum;
@property (nonatomic, strong) UILabel *attitudeLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *tagCountLabel;
@property (nonatomic, strong) UILabel *feedHintLabel;
@property (nonatomic, strong) ProfileFeedContentView *feed;


@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSArray *tagModels;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData:)
                                                 name:kNotification_Profile_GetProfile
                                               object:nil];
    [self initMyView];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)initMyView {
    
    [self initScroll];
    [self initTop];
    [self initMiddle];
    [self initBottom];
    [self prepareLoadData];
}
- (void)prepareLoadData {
    _loadingView = [[UIView alloc] init];
    [self.view addSubview:_loadingView];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    _loadingView.backgroundColor = [UIColor whiteColor];
    _loadingView.hidden = true;
}
- (void)startLoadData {
    if ([[ProvisionManager sharedInstance] getProfile] != nil) {
        [self loadData:[[ProvisionManager sharedInstance] getProfile]];
    } else {
        _loadingView.hidden = false;
        _hud = [YUtils showHUDAddedTo:self.view title:@"正在加载" animated:true];
    }
}
- (void)afterLoadData:(YActionMessage *)message {
    [_hud removeFromSuperview];
    _loadingView.hidden = true;
    if (message.isSuccess) {
        [self loadData:message.object];
    } else {
        [YUtils showTitle:message.desc];
    }
}
- (void)refreshData:(NSNotification *)notification {
    [self afterLoadData:[notification userInfo][kNotification_Request_Message]];
}
- (void)loadData:(ProfileInfo *)info {
    [_headImg setFaceImageWithUrl:info.headPic];
    _userName.text = info.userName;
    _schoolNo.text = info.studentNo;
    _respectNum.text = [NSString stringWithFormat:@"敬酒：%d", (int)info.praiseCount];
    _coolNum.text = [NSString stringWithFormat:@"觉得很酷：%d", (int)info.coolCount];
    _attitudeLabel.text = (info.selfIntro.length == 0? @"你是一个没有态度的人":info.selfIntro);
    _userId = info.uid;
    _tagModels = info.tagModels;
    if (_tagModels.count == 0) {
        _tagLabel.text = @"你没有任何关注";
        _tagLabel.textColor = [UIColor blackColor];
        _tagCountLabel.text = @"";
    } else {
        _tagLabel.text = [_tagModels[0] name];
        _tagLabel.textColor = KCOLORGREEN_009688;
        if (_tagModels.count > 1) {
            _tagCountLabel.text = [NSString stringWithFormat:@"等%d个", (int)_tagModels.count];
        } else {
            _tagCountLabel.text = @"";
        }
    }
    if (info.lastFeeds.count == 0) {
        _feedHintLabel.text = @"你没有任何观点";
        [_feed setData:nil];
    } else {
        _feedHintLabel.text = @"查看全部";
        [_feed setData:info.lastFeeds[0]];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = true;
}

- (void)initScroll {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    scroll.showsVerticalScrollIndicator = false;
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _containerView = [[UIView alloc] init];
    [scroll addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
        make.width.equalTo(scroll);
    }];
}
- (void)initTop {
    _topView = [[UIView alloc] init];
    [_containerView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_containerView);
        make.height.mas_equalTo(KTOPHEIGHT);
    }];
    _topView.backgroundColor = KCOLORGREEN_455A64;
    [_topView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openProfile)]];
    
    UIView *infoView = [[UIView alloc] init];
    [_topView addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView).offset(KHEADIMGMARIN_LEFT);
        make.height.mas_equalTo(KHEADIMG_SIZE);
        make.right.equalTo(_topView);
        make.bottom.equalTo(_topView).offset(-KHEADIMGMARIN_DOWN);
    }];
    
    _headImg = [[UIImageView alloc] init];
    [infoView addSubview:_headImg];
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(infoView);
        make.width.mas_equalTo(KHEADIMG_SIZE);
    }];
    _headImg.layer.cornerRadius = KHEADIMG_SIZE/2;
    _headImg.clipsToBounds = true;
    _headImg.image = [UIImage imageNamed:@"default_head"];
    
    UIView *titleView = [[UIView alloc] init];
    [infoView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImg.mas_right).offset(KNAMEMARGIN_LEFT);
        make.centerY.equalTo(_headImg);
    }];
    
    _userName = [YUtils initLabel:CONTENT_FONT(15) color:KCOLORWHITE text:@"用户名" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [titleView addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(titleView);
        make.right.lessThanOrEqualTo(titleView);
    }];
    
    _schoolNo = [YUtils initLabel:CONTENT_FONT(9) color:KCOLORWHITE text:@"" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [titleView addSubview:_schoolNo];
    [_schoolNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userName.mas_bottom).offset(KSCHOOLNOMARGIN_TOP);
        make.bottom.left.equalTo(titleView);
        make.right.lessThanOrEqualTo(titleView);
    }];
    
    [self rightArray:0 inView:infoView];
    
}

- (void)initMiddle {
    _middleView = [[UIView alloc] init];
    [_containerView addSubview:_middleView];
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_topView);
        make.top.equalTo(_topView.mas_bottom);
    }];
    UIView *item1 = [self whiteItem:true];
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_middleView);
        make.height.mas_equalTo(KMIDDELITEMHEIGHT);
    }];
    
    UIView *item2 = [self whiteItem:false];
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1.mas_bottom);
        make.left.right.height.equalTo(item1);
        make.bottom.equalTo(_middleView);
    }];
}

- (void)initBottom {
    _bottomView = [[UIView alloc] init];
    [_containerView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_middleView);
        make.top.equalTo(_middleView.mas_bottom);
        make.bottom.equalTo(_containerView);
    }];
    UIView *tmp = nil;
    for (int i = 0; i < 3; i ++) {
        UIView *item = [self greenItem:i];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if (tmp == nil) {
                make.top.equalTo(_bottomView).offset(KBOTTOMITEMMARGIN_TOP);
            } else {
                make.top.equalTo(tmp.mas_bottom).offset(KBOTTOMITEMMARGIN_TOP);
            }
            make.left.right.equalTo(_bottomView);
        }];
        tmp = item;
    }
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tmp).offset(KBOTTOMITEMMARGIN_TOP);
    }];
}

- (UIView *)whiteItem:(BOOL)isRespect {
    UIView *item = [[UIView alloc] init];
    [_middleView addSubview:item];
    UIImageView *icon = [[UIImageView alloc] init];
    [item addSubview:icon];
    [self rightArray:1 inView:item];
    if (isRespect) {
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openRespect)]];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(SCALE_NUM(17));
            make.centerX.equalTo(_headImg);
            make.centerY.equalTo(item);
        }];
        icon.image = [UIImage imageNamed:@"mine-toast"];
        _respectNum = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"敬酒：0" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [item addSubview:_respectNum];
        [_respectNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName);
            make.top.bottom.right.equalTo(item);
        }];
    } else {
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCool)]];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(SCALE_NUM(17));
            make.centerX.equalTo(_headImg);
            make.centerY.equalTo(item);
        }];
        icon.image = [UIImage imageNamed:@"mine-heart"];
        _coolNum = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"觉得很酷：0" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [item addSubview:_coolNum];
        [_coolNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName);
            make.top.bottom.right.equalTo(item);
        }];
        
    }
    
    return item;
}

- (UIView *)greenItem:(int)index {
    UIView *item = [[UIView alloc] init];
    [_bottomView addSubview:item];
    NSArray *names = @[@"态度", @"关注", @"观点"];
    UILabel *icon = [YUtils initLabel:CONTENT_FONT(10) color:KCOLORWHITE text:names[index] frame:CGRectZero alignment:NSTextAlignmentCenter];
    icon.backgroundColor = KCOLORGREEN_009688;
    icon.layer.cornerRadius = KBOTTOMLABELSIZE/2;
    icon.clipsToBounds = true;
    [item addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(KBOTTOMLABELSIZE);
        make.centerX.equalTo(_headImg);
        make.top.equalTo(item);
        make.bottom.lessThanOrEqualTo(item);
    }];
    if (index == 0) {
        _attitudeLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"" frame:CGRectZero alignment:NSTextAlignmentLeft];
        _attitudeLabel.numberOfLines = 0;
        [item addSubview:_attitudeLabel];
        [_attitudeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(icon);
            make.left.equalTo(_userName);
            make.right.equalTo(item).offset(-SCALE_NUM(12));
            make.centerY.equalTo(icon).priorityLow();
            make.bottom.lessThanOrEqualTo(item);
        }];
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openAttitude)]];
    }
    if (index == 1) {
        _tagLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLORGREEN_009688 text:@"" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [item addSubview:_tagLabel];
        [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName);
            make.centerY.equalTo(icon);
        }];
        _tagCountLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [item addSubview:_tagCountLabel];
        [_tagCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tagLabel.mas_right).offset(5);
            make.centerY.equalTo(_tagLabel);
        }];
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openTagList)]];
        [self rightArray:2 inView:item];
    }
    if (index == 2) {
        
        _feedHintLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"查看全部" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [item addSubview:_feedHintLabel];
        [_feedHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName);
            make.right.equalTo(item);
            make.centerY.equalTo(icon);
        }];
        [self rightArray:2 inView:_feedHintLabel];
        _feed = [[ProfileFeedContentView alloc] init];
        _feed.userInteractionEnabled = false;
        [item addSubview:_feed];
        [_feed mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName);
            make.right.equalTo(item).offset(-SCALE_NUM(12));
            make.top.equalTo(_feedHintLabel.mas_bottom).offset(KFEEDMARGIN_TOP);
            make.bottom.lessThanOrEqualTo(item);
        }];
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openFeed)]];
    }
    
    return item;
}

- (UIImageView *)rightArray:(int)type inView:(UIView *)view{
    UIImageView *right = [[UIImageView alloc] init];
    [view addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(view);
        make.right.equalTo(view).offset(-SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(8));
    }];
    switch (type) {
        case 0:
            right.image = [UIImage imageNamed:@"mine-particulars"];
            break;
        case 1:
            right.image = [UIImage imageNamed:@"mine-toast-particulars"];
            break;
        case 2:
            right.image = [UIImage imageNamed:@"mine-concern-particulars"];
            break;
        default:
            break;
    }
    right.contentMode = UIViewContentModeRight;
    return right;
}


- (void)viewDidAppear:(BOOL)animated {
    [self startLoadData];
}
- (void)openTagList {
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:[[ProfileTagViewController alloc] initWithMyTags:_tagModels]];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}
- (void)openAttitude {
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:[[YCommonEditViewController alloc] initWithType:YCommonEditAttitude preText:_attitudeLabel.text]];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}
- (void)openRespect {
    [self.navigationController pushViewController:[[ProfilePersonListController alloc] initWithType:0] animated:true];
}
- (void)openCool {
    [self.navigationController pushViewController:[[ProfilePersonListController alloc] initWithType:1] animated:true];
}
- (void)openFeed {
    [self.navigationController pushViewController:[[ProfilePublishViewController alloc] init] animated:true];
}

- (void)openProfile {
    [self.navigationController pushViewController:[[ProfileOthersViewController alloc] init] animated:true];
}



@end
