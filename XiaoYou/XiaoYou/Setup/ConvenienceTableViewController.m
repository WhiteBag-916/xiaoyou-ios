//
//  ConvenienceTableViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ConvenienceTableViewController.h"
#define REUSERIDEN  @"Convenience"
#define CELL_HEIGHT SCALE_NUM(50)
@interface ConvenienceTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView   *tableView;
@property (nonatomic, retain) NSArray       *dataSource;

@end

@implementation ConvenienceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"便利性设置"];
    [self showCustomNavigationBackButton];
    [self tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:REUSERIDEN];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}

-(void)setTitleView {
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 64)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"便利性设置";
    [titleLabel setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSERIDEN forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSERIDEN];
    }
    cell.textLabel.text = self.dataSource[indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    UISwitch *switchView = [[UISwitch alloc]init];
    [switchView addTarget:self action:@selector(switchViewClick:) forControlEvents:UIControlEventValueChanged];
    switchView.tag = 50000 + indexPath.section;
    cell.accessoryView = switchView;
    return cell;
}

- (void)switchViewClick:(UISwitch*)switchView {
    NSInteger index = switchView.tag - 50000;
    if (index == 0) {
        if (switchView.on)
            NSLog(@"test 1");
    }
    else if (index == 1) {
        NSLog(@"test 2");
    }
    else if (index == 2) {
        NSLog(@"test 3");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}



-(NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"学校官方活动提醒我",@"院系官方活动提醒我",@"校友APP发布的好玩的活动一定要提醒我"];
    }
    return _dataSource;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
