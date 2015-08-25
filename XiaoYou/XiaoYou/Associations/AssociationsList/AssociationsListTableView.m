//
//  AssociationsListTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsListTableView.h"
#import "AssociationsListTableViewCell.h"
#import "AssociationsDetailViewController.h"

@interface AssociationsListTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) NSArray *feedListArray;

@end

@implementation AssociationsListTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[AssociationsListTableViewCell class] forCellReuseIdentifier:kAssociationsListTableViewCell];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssociationsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAssociationsListTableViewCell];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AssociationsDetailViewController *associationsDetailViewController = [[AssociationsDetailViewController alloc] init];
    [_superVC.navigationController pushViewController:associationsDetailViewController animated:YES needHiddenBottomBar:YES];
}

@end
