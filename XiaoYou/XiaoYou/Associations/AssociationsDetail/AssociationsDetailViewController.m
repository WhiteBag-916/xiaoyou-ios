//
//  AssociationsDetailViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsDetailViewController.h"
#import "AssociationsDetailTableView.h"
#import "YCommonActionSheet.h"

@interface AssociationsDetailViewController ()

@property (nonatomic, strong) AssociationsDetailTableView *associationsDetailTableView;
@property (nonatomic, strong) UIButton *addButton; //一键入社

@end

@implementation AssociationsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"网球社";
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    
    [self initView];
}

- (void)onNavigationRightButtonClicked {
    YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeShare title:@"分享这条动态至" extraData:@{@"tag":@"互联网",@"content":@"balabala",@"pic":@"http://cdn.duitang.com/uploads/item/201411/22/20141122111634_RBCXS.jpeg"}];
    
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] title:nil];
    [sheet show];
}

- (void)initView {
    //button
    _addButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setTitle:@"一键申请加入网球社" forState:UIControlStateNormal];
    [_addButton setTitleColor:KCOLORWHITE forState:UIControlStateNormal];
    [_addButton setBackgroundColor:KCOLORGREEN_009688];
    [_addButton addTarget:self action:@selector(pressAddButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(SCALE_NUM(48));
    }];
    
    //tableview
    _associationsDetailTableView = [[AssociationsDetailTableView alloc] init];
    [self.view addSubview:_associationsDetailTableView];
    
    [_associationsDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_addButton.mas_top);
    }];
}

- (void)pressAddButton {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
