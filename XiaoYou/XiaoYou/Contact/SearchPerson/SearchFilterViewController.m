//
//  SearchFilterViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SearchFilterViewController.h"
#import "YTableView.h"
#import "SearchFilterTableViewCell.h"
#import "ContactManager.h"
#import "FriendsCondition.h"
#import "YModel+ActionMessage.h"

NSString *const filterName = @"filterName";
NSString *const filterIsSelected = @"filterIsSelected";

@interface SearchFilterViewController ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *filterAllArray;
@property (nonatomic, strong) YTableView *searchFilterTableView;
@property (nonatomic, copy) SearchFilterSelectedBlock searchFilterSelectedBlock;

@end

@implementation SearchFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenFail) name:kNotification_Server_Token_Fail object:nil];
    
    self.title = @"筛选条件";
    [self showCustomNavigationCancelButton];
    [self showCustomNavigationSureButton];
    
//    [self initData];
    self.filterAllArray = [[NSMutableArray alloc] init];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resetRightButton];
    
    //拉取筛选条件
    [self friendsConditionRequest];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tokenFail {
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)onNavigationLeftButtonClicked {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onNavigationRightButtonClicked {
    NSMutableArray *selectArray = [@[] mutableCopy];
    
    //重新排序
    [_filterAllArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if ([obj[filterIsSelected] boolValue])
        {
            [selectArray addObject:obj[filterName]];
        }
    }];
    
    _searchFilterSelectedBlock(selectArray);
    
    [self onNavigationLeftButtonClicked];
}

- (void)friendsConditionRequest {
    [[ContactManager sharedInstance] friendsCondition:^(YActionMessage *message) {
        if (message.isSuccess) {
            [message.object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                //构造
                [_filterAllArray addObject:[@{filterName:obj,filterIsSelected:@NO} mutableCopy]];
            }];
            
            [self initData];
            
            [_searchFilterTableView reloadData];
        } else {
            [YUtils showTitle:message.desc];
            
            [self onNavigationLeftButtonClicked];
        }
    }];
}

- (void)initData {
//    //构造
//    self.filterAllArray = @[[@{filterName:@"同系",filterIsSelected:@NO} mutableCopy]
//                            ,[@{filterName:@"同年级",filterIsSelected:@NO} mutableCopy]
//                            ,[@{filterName:@"老乡",filterIsSelected:@NO} mutableCopy]
//                            ,[@{filterName:@"同社团",filterIsSelected:@NO} mutableCopy]
//                            ,[@{filterName:@"篮球社",filterIsSelected:@NO} mutableCopy]
//                            ,[@{filterName:@"互联网创业",filterIsSelected:@NO} mutableCopy]
//                            ,[@{filterName:@"男",filterIsSelected:@NO} mutableCopy]
//                            ,[@{filterName:@"女",filterIsSelected:@NO} mutableCopy]];
    
    //设置哪些已经选中
    [_filterAllArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_isSelectArray enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx, BOOL *stop) {
            if ([[obj2 label] isEqualToString:[obj[filterName] label]]) {
                [obj setValue:@YES forKey:filterIsSelected];
            }
        }];
    }];
}

- (void)initView {
    _searchFilterTableView = [[YTableView alloc] init];
    _searchFilterTableView.delegate = self;
    _searchFilterTableView.dataSource = self;
    _searchFilterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_searchFilterTableView registerClass:[SearchFilterTableViewCell class] forCellReuseIdentifier:kSearchFilterTableViewCell];
    [self.view addSubview:_searchFilterTableView];
    [_searchFilterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)endSelected:(SearchFilterSelectedBlock)block {
    _searchFilterSelectedBlock = block;
}

//重置右上角按钮是否可点
- (void)resetRightButton
{
    //判断
    if ([self isSelectedArray])
    {
        self.navigationRightButton.userInteractionEnabled = YES;
        [self.navigationRightButton setImage:[UIImage imageNamed:@"complete"] forState:UIControlStateNormal];
    }
    else
    {
        self.navigationRightButton.userInteractionEnabled = NO;
        [self.navigationRightButton setImage:[UIImage imageNamed:@"complete-grey"] forState:UIControlStateNormal];
    }
}

//是否有选中
- (BOOL)isSelectedArray {
    __block BOOL isSelect = NO;
    
    [_filterAllArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if ([obj[filterIsSelected] boolValue])
        {
            isSelect = YES;
            *stop = YES;
        }
    }];
    
    return isSelect;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_filterAllArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchFilterTableViewCell];
    
    [cell initData:[_filterAllArray[indexPath.row][filterName] label] select:[_filterAllArray[indexPath.row][filterIsSelected] boolValue]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(45);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _filterAllArray[indexPath.row][filterIsSelected] = @(![_filterAllArray[indexPath.row][filterIsSelected] boolValue]);
    [_searchFilterTableView reloadData];
    
    [self resetRightButton];
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
