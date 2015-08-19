//
//  ChoicePersonTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ChoicePersonTableView.h"
#import "ChoicePersonTableViewCell.h"

@interface ChoicePersonTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ChoicePersonTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[ChoicePersonTableViewCell class] forCellReuseIdentifier:kChoicePersonTableViewCell];
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
    
    ChoicePersonTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kChoicePersonTableViewCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellInfo:nil];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self reloadData];
    ChoicePersonTableViewCell * cell = (ChoicePersonTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor magentaColor];
}

@end
