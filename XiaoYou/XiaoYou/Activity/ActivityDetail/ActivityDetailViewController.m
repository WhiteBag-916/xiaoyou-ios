//
//  FunnyDetaiViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailListView.h"
#import "ActivityModelTest.h"
#import "ActivityManager.h"
#import "ActivityDetailModel.h"

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
    [self detailListView];
    [self setTitle:@"活动详情"];
    [self initJoinButton];
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

-(ActivityDetailListView *)detailListView {
    if (!_detailListView) {
        _joinInBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_joinInBtn];
        _joinInBtn.enabled = self.isEnroll;
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
            make.height.mas_equalTo(SCALE_NUM(45));
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
    [_detailListView sendRequest];
    return _detailListView;
}


-(void)initJoinButton
{
    [[ActivityManager sharedInstance] findActivityDetailInfo:0 limitEnd:0 activityPublishedId:self.publishID getDetail:YES block:^(YActionMessage *message) {
        if (message.isSuccess) {
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:message.object];
            ActivityDetailModel *model = arr[0];
            _joinInBtn.enabled = !model.enroll;
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
            [YUtils showTitle:message.desc];
            _joinInBtn.enabled = NO;
        }
    }];
}

@end
