//
//  MerchantListTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MerchantListTableView.h"
#import "MerchantListTableViewCell.h"

@interface MerchantListTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MerchantListTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle =  UITableViewCellSeparatorStyleNone;
        [self registerClass:[MerchantListTableViewCell class] forCellReuseIdentifier:kMerchantListTableViewCell];
        
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
    MerchantListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMerchantListTableViewCell forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)gotoDetailWithCellType
{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(135);
}

@end
