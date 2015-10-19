//
//  ActivityResultTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/16.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityResultTableView.h"
#import "AvailableCell.h"
#import "ActivityDetailViewController.h"

#define REUSEID @"AvailableCell"

@interface ActivityResultTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray * dataSouceArr;

@end

@implementation ActivityResultTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[AvailableCell class] forCellReuseIdentifier:REUSEID];
        
    }
    return self;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AvailableCell * cell = [tableView dequeueReusableCellWithIdentifier:REUSEID forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     if ([cell isKindOfClass:[AvailableCell class]]) {
        [self gotoDetailWithCellType];
    }
}

-(void)gotoDetailWithCellType
{
    ActivityDetailViewController *activityDetailVC = [[ActivityDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:activityDetailVC animated:YES needHiddenBottomBar:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(430);
}

@end
