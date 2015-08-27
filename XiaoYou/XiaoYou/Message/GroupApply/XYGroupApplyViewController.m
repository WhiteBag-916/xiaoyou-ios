//
//  XYGroupApplyViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYGroupApplyViewController.h"
#import "GroupApplyTableView.h"
#import "YCommonActionSheet.h"
#import "XYChoicePersonViewController.h"
#import "ApplicantList.h"

@interface XYGroupApplyViewController ()

@property(nonatomic,strong)GroupApplyTableView * groupApplyTableView;
@property (nonatomic, strong) NSString *groupId;

@end

@implementation XYGroupApplyViewController

- (instancetype)initWithGroupId:(NSString *)groupId {
    if (self = [super init]) {
        _groupId = groupId;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

-(void)setUpUI
{
    self.title = @"社团申请";
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    
    _groupApplyTableView = [[GroupApplyTableView alloc] initWithGroupId:_groupId];
    _groupApplyTableView.superVC = self;
    _groupApplyTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_groupApplyTableView];
    
    [_groupApplyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [_groupApplyTableView loadData];
    
}

- (void)onNavigationRightButtonClicked
{
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"清空社团申请者列表"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self removeAllData];
                                                        }];
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"集体发信"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            NSLog(@"集体发信");
                                                            
                                                            [self choicePerson];
                                                            
                                                        }];
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1,item2] title:nil];
    [sheet show];
}

- (void)removeAllData {
    [_groupApplyTableView refreshTableView:[NSArray array]];
}

- (void)choicePerson {
    NSArray *dataArray = [_groupApplyTableView getData];
    NSMutableArray *authorArray = [@[] mutableCopy];
    
    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [authorArray addObject:[obj author]];
    }];
    
    XYChoicePersonViewController * choicePersonViewController = [[XYChoicePersonViewController alloc] init];
    choicePersonViewController.authorArr = [NSArray arrayWithArray:authorArray];
    [self.navigationController pushViewController:choicePersonViewController animated:YES needHiddenBottomBar:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
