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
#import "UserSchedulingInfo.h"

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
    
    [self IsShowCustomNavigationMoreButton:NO];
    
    [self.detailListView loadData];
    [self setTitle:@"活动详情"];
    //[self updateJoinButtonStatus];
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
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"我要退出" type:YCommonActionSheetItemTypeCenterCommon block:^(NSInteger checkNum) {
        [self exitActivity];
        
    }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1] title:nil];
    [sheet show];
}


-(void)exitActivity
{
    [[ActivityManager sharedInstance] cancleActivitySignUpByActivityID:self.publishID block:^(YActionMessage *message) {
        if (message.isSuccess) {
            [self updateJoinButtonStatus];
        }
        [YUtils showTitle:message.desc];
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
    return _detailListView;
}

-(void)updateJoinButtonStatus
{
    [[ActivityManager sharedInstance] findActivityDetailInfo:0 limitEnd:0 activityPublishedId:self.publishID getDetail:YES block:^(YActionMessage *message) {
        if (message.isSuccess) {
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:message.object];
            ActivityDetailModel *model = arr[0];
            
            //构造日程
            UserSchedulingInfo *info = [UserSchedulingInfo new];
            info.type = @"activity";
            info.internalBaseClassIdentifier = model.activityPublishedDto.activityPublishedModel.activityPublishedModelIdentifier;
            info.content = model.activityPublishedDto.activityPublishedModel.name;
            info.startTime = model.activityPublishedDto.activityPublishedModel.actStartTime;
            info.endTime = model.activityPublishedDto.activityPublishedModel.actEndTime;
            
            if ([model.enrollStatus isEqualToString:@"not_enroll"]) {
                [_joinInBtn setTitle:@"我要加入" forState:UIControlStateNormal];
                _joinInBtn.enabled = YES;
                _joinInBtn.backgroundColor = KCOLOR_g1;
                [self IsShowCustomNavigationMoreButton:NO];
                
                //未加入
                //抛通知告知日程删除
                NSDictionary *dic = @{@"state":@"del", @"info":info};
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Change_Schedule
                                                                    object:nil
                                                                  userInfo:dic];
            }
            else if ([model.enrollStatus isEqualToString:@"has_enrolled"]) {
                [_joinInBtn setTitle:@"我已参加" forState:UIControlStateNormal];
                _joinInBtn.backgroundColor = KCOLOR_g2;
                _joinInBtn.enabled = NO;
                [self IsShowCustomNavigationMoreButton:YES];
                
                //已加入
                //抛通知告知日程添加
                NSDictionary *dic = @{@"state":@"add", @"info":info};
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Change_Schedule
                                                                    object:nil
                                                                  userInfo:dic];
            }
            else if ([model.enrollStatus isEqualToString:@"enroll_expired"]) {
                [_joinInBtn setTitle:@"报名结束" forState:UIControlStateNormal];
                _joinInBtn.enabled = NO;
                _joinInBtn.backgroundColor = KCOLOR_g2;
                [self IsShowCustomNavigationMoreButton:YES];
            }
            else if ([model.enrollStatus isEqualToString:@"enroll_auditing"]) {
                [_joinInBtn setTitle:@"正在审核" forState:UIControlStateNormal];
                _joinInBtn.enabled = NO;
                _joinInBtn.backgroundColor = KCOLOR_g2;
                [self IsShowCustomNavigationMoreButton:YES];
            }
            else if ([model.enrollStatus isEqualToString:@"self_activity"]) {
                _joinInBtn.enabled = YES;
                _joinInBtn.backgroundColor = KCOLOR_g2;
                [_joinInBtn setTitle:@"我已参加" forState:UIControlStateNormal];
                [self IsShowCustomNavigationMoreButton:NO];
            }
            [_detailListView loadData];
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
            [self updateJoinButtonStatus];
        }
        else {
        }
        [YUtils showTitle:message.desc];
        
    }];
}

@end
