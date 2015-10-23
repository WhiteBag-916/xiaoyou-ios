//
//  ActivityIdentityTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityIdentityTableView.h"
#import "ActivityIdentityTableViewCell.h"

@interface ActivityIdentityTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ActivityIdentityTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[ActivityIdentityTableViewCell class] forCellReuseIdentifier:kActivityIdentityTableViewCell];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityIdentityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kActivityIdentityTableViewCell forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(40);
}

@end
