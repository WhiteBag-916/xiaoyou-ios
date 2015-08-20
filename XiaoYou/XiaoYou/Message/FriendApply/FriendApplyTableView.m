//
//  FriendApplyTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FriendApplyTableView.h"
#import "FriendApplyTableViewCell.h"

@interface FriendApplyTableView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation FriendApplyTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[FriendApplyTableViewCell class] forCellReuseIdentifier:kFriendApplyTableViewCell];
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
    
    FriendApplyTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kFriendApplyTableViewCell forIndexPath:indexPath];
    [cell setCellInfo:nil];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 167;
}


@end
