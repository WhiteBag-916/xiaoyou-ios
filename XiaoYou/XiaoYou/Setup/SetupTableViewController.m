//
//  SetupTableViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "SetupTableViewController.h"
#import "ConvenienceTableViewController.h"
#import "YViewController.h"
#import "YVIew+Ext.h"
@interface SetupTableViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSArray       *dataSource;
@property (nonatomic, retain) UITableView   *tableView;

@end

@implementation SetupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitleView];
    [self showCustomNavigationBackButton];
    [self tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SetUp"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setTitleView {
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 64)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"设置及其它";
    [titleLabel setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView = titleLabel;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}

#pragma mark 准备数据源
-(NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"我收藏的",@"我关注的活动类型",@"便利性设置"];
    }
    return _dataSource;
}


#pragma mark 协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuserIden = @"SetUp";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIden forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIden];
    }
    cell.textLabel.text = self.dataSource[indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    if (indexPath.section == 0)
        cell.imageView.image = [UIImage imageNamed:@"setup_mystore"];
    else if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:@"setup_other"];
    }
    else if (indexPath.section == 2) {
        cell.imageView.image = [UIImage imageNamed:@"setup_mystore"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        ConvenienceTableViewController *convence = [[ConvenienceTableViewController alloc]init];
        [self.navigationController pushViewController:convence animated:YES];
    }
}
@end
