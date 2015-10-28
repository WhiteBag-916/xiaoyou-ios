//
//  AssociationsSearchViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsSearchViewController.h"
#import "AssociationsListTableView.h"
#import "YTableView.h"
#import "ActivityResultTableView.h"
#import "YTimer.h"
#import "YCommonNoDataView.h"

const NSInteger kSearchTimerDelay = 2.f;

@interface AssociationsSearchViewController ()
<UISearchBarDelegate>

@property (nonatomic, strong) AssociationsListTableView *associationsListTableView;
@property (nonatomic, strong) ActivityResultTableView *searchActivityListView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *associationsArray;//社团数组
@property (nonatomic, assign) YTimerID searchTimerID;  //两秒搜索
@property (nonatomic, strong) YCommonNoDataView *noDataView;//搜索没数据

@end

@implementation AssociationsSearchViewController

- (id)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        self.associationsArray = [[NSArray alloc] initWithArray:array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)initView {
    UIView *headView = [UIView new];
    headView.backgroundColor = KCOLOR_455A64;
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(KNavigationBarheight);
    }];
    
    //cancel
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:KCOLORWHITE forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pressCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headView).offset(SCALE_NUM(-10));
        make.width.mas_equalTo(SCALE_NUM(50));
        make.centerY.equalTo(headView).offset(10);
    }];
    
    //search
    _searchBar = [UISearchBar new];
    [_searchBar setBackgroundImage:[UIImage new]];
    _searchBar.placeholder = @"输入社团名称搜索";
    if (self.searchType == ACTIVITY_TYPE)
        _searchBar.placeholder = @"输入活动名称搜索";
    
    [_searchBar becomeFirstResponder];
    _searchBar.delegate = self;
    [headView addSubview:_searchBar];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(10));
        make.right.equalTo(cancelButton.mas_left);
        make.centerY.equalTo(headView).offset(10);
    }];
    
    //活动列表
    if (self.searchType == ACTIVITY_TYPE) {
        _searchActivityListView = [[ActivityResultTableView alloc] init];
        [_searchActivityListView hiddenHeader:YES];
        [self.view addSubview:_searchActivityListView];
        [_searchActivityListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.view);
            make.top.equalTo(headView.mas_bottom);
        }];
    }
    //associations tableView
    else {
        _associationsListTableView = [[AssociationsListTableView alloc] init];
        [_associationsListTableView hiddenHeader:YES];
        _associationsListTableView.superVC = self;
        [self.view addSubview:_associationsListTableView];
    
        [_associationsListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.view);
            make.top.equalTo(headView.mas_bottom);
        }];
    }
    
    //noDataView
    _noDataView = [[YCommonNoDataView alloc] initWithType:NoDataView_SearchActivity];
    _noDataView.hidden = YES;
    [self.view addSubview:_noDataView];
    [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.equalTo(headView.mas_bottom);
    }];
}

- (void)pressCancelButton {
    [self.navigationController popViewControllerAnimated:YES];
}

//是否展示没数据
- (void)hiddenNodata:(BOOL)hidden {
    _noDataView.hidden = hidden;
}

//搜索学校社团
- (void)searchAssociationsByKey
{
    NSString *searchKey = [_searchBar.text lowercaseString];
    [_associationsListTableView resetArrayBySearch:searchKey];
}

//搜索活动
- (void)searchActivity
{
    NSString *searchKey = [_searchBar.text lowercaseString];
    [_searchActivityListView sendRequestBySearchDataByKey:searchKey];
}

- (void)toSearch {
    if (self.searchType == ACTIVITY_TYPE) {
        [self searchActivity];
    }
    else {
        [self searchAssociationsByKey];
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![searchBar.text isEmpty]) {
        
        //取消定时器
        [YTimer killTimerWithID:_searchTimerID];
        
        //重新开始
        _searchTimerID = [YTimer scheduledTimerWithTimeInterval:kSearchTimerDelay repeats:NO block:^{
            [self toSearch];
        }];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //取消定时器
    [YTimer killTimerWithID:_searchTimerID];
    
    [self toSearch];
}


@end
