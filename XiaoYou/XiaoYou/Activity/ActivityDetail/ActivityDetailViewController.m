//
//  FunnyDetaiViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailListView.h"
#import "ActivityManager.h"
#import "ActivityDetailModel.h"
#import "YCommonActionSheet.h"
#import "YNotificationDefine.h"

@interface ActivityDetailViewController ()

@property (nonatomic,strong) ActivityDetailListView *detailListView;
@property (nonatomic,strong) UIButton *joinInBtn;

@property (nonatomic,copy) NSString *publishID;
@property (nonatomic,assign) BOOL   isEnroll;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self showCustomNavigationBackButton];
    
    [self IsShowCustomNavigationMoreButton:YES];
    
    [self detailListView];
    [self setTitle:@"活动详情"];
    [self updateJoinButtonStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithPublishID:(NSString *)publishID
{
    if (self = [super init]) {
        _publishID = publishID;
    }
    return self;
}


- (void)onNavigationRightButtonClicked {
    NSLog(@"this is data...");
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"我要退出" type:YCommonActionSheetItemTypeCenterCommon block:^(NSInteger checkNum) {
        [self exitActivity];
        
    }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1] title:nil];
    [sheet show];
    
    
}


-(void)exitActivity
{
    YLogD(@"this is activity...");
    [[ActivityManager sharedInstance] cancleActivitySignUpByActivityID:self.publishID block:^(YActionMessage *message) {
        [YUtils showTitle:message.desc];
        [self updateJoinButtonStatus];
    }];
}


-(ActivityDetailListView *)detailListView {
    if (!_detailListView) {
        _joinInBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_joinInBtn];
        [_joinInBtn addTarget:self action:@selector(joinInAction) forControlEvents:UIControlEventTouchUpInside];
        _joinInBtn.layer.borderWidth = 0.6;
        [_joinInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _joinInBtn.layer.borderColor = KCOLORGRAY.CGColor;
        [_joinInBtn setTitle:@"我要加入" forState:UIControlStateNormal];
        [_joinInBtn setBackgroundColor:KCOLOR_g1];
        [_joinInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_joinInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(-1);
            make.trailing.mas_equalTo(1);
            make.bottom.mas_equalTo(1);
            make.height.mas_equalTo(50);
        }];
        
        _detailListView = [[ActivityDetailListView alloc]init];
        [self.view addSubview:_detailListView];
        [_detailListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(0);
            make.trailing.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.equalTo(_joinInBtn.mas_top);
        }];
        
    }
    _detailListView.publishID = self.publishID;
    [_detailListView loadData];
    [_detailListView sendRequest];
    return _detailListView;
}

-(void)updateJoinButtonStatus
{
    [[ActivityManager sharedInstance] findActivityDetailInfo:0 limitEnd:0 activityPublishedId:self.publishID getDetail:YES block:^(YActionMessage *message) {
        if (message.isSuccess) {
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:message.object];
            ActivityDetailModel *model = arr[0];
            if ([model.enrollStatus isEqualToString:@"not_enroll"]) {
                [_joinInBtn setTitle:@"我要加入" forState:UIControlStateNormal];
                _joinInBtn.enabled = YES;
                _joinInBtn.backgroundColor = KCOLOR_g1;
                [self IsShowCustomNavigationMoreButton:NO];
            }
            else if ([model.enrollStatus isEqualToString:@"has_enrolled"]) {
                [_joinInBtn setTitle:@"我已参加" forState:UIControlStateNormal];
                _joinInBtn.backgroundColor = KCOLOR_g2;
                _joinInBtn.enabled = NO;
                [self IsShowCustomNavigationMoreButton:YES];
            }
            else if ([model.enrollStatus isEqualToString:@"enroll_expired"]) {
                [_joinInBtn setTitle:@"报名结束" forState:UIControlStateNormal];
                _joinInBtn.enabled = NO;
                _joinInBtn.backgroundColor = KCOLOR_g2;
                [self IsShowCustomNavigationMoreButton:NO];
            }
            else if ([model.enrollStatus isEqualToString:@"enroll_auditing"]) {
                [_joinInBtn setTitle:@"正在审核" forState:UIControlStateNormal];
                _joinInBtn.enabled = NO;
                _joinInBtn.backgroundColor = KCOLOR_g2;
                [self IsShowCustomNavigationMoreButton:YES];
            }
        }
    }];
}


//参加某个活动的事件
- (void)joinInAction {
    [YUtils showHUDWithTitle:@"报名中"];
    [[ActivityManager sharedInstance] enrollActivity:self.publishID block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        if (message.isSuccess) {
            _joinInBtn.enabled = NO;
        }
        else {
            _joinInBtn.enabled = NO;
        }
        [YUtils showTitle:message.desc];
        [self updateJoinButtonStatus];
    }];
}


//1.未点击时：我要加入
//2.点击后：
//已报名成功（需要报名的活动）：我已参加
//已参加（不需报名的活动）：我已参加
//已提交报名申请（需要报名的活动）：正在审核
//*3.若该用户从日程卡中删除了某活动，再次进入时按钮显示为未点击的状态：我要加入
//
//点击按钮弱提示交互：
//4.需要报名的活动：点击「我要加入」出现toast：报名申请已提交，请等待审核。
//5.不需要报名的活动：点击「我要加入」出现toast：已成功参加该活动，请到日程卡中查看。
//6.按钮点击后不可再次点击
//
//颜色：
//未点击时：绿色g1
//点击后：浅绿色g2

@end
