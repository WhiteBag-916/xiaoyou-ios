//
//  GroupApplyTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupApplyTableView.h"
#import "GroupApplyTableViewCell.h"

@interface GroupApplyTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GroupApplyTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[GroupApplyTableViewCell class] forCellReuseIdentifier:kGroupApplyTableViewCell];
    }
    return self;
}

-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
    [self reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GroupApplyTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kGroupApplyTableViewCell forIndexPath:indexPath];
    
    [cell setCellInfo:nil];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 167;
}


@end
