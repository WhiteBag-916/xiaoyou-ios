//
//  ChoicePersonTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ChoicePersonTableView.h"
#import "ChoicePersonTableViewCell.h"
#import "XYGroupInfoDetailViewController.h"
#import "LinkManList.h"
#import "Author.h"

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
        _dataSouceArr = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - 刷新界面

-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
    [_dataSouceArr removeAllObjects];
    [dataSouceArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if ([_superVC.superType isEqualToString:kXYGroupInfoDetailViewController]) {
            LinkManList * model = obj;
            [dic setObject:model forKey:@"model"];
            [dic setObject:model.name forKey:@"name"];
            [dic setObject:model.icon forKey:@"icon"];
            [dic setObject:@NO forKey:@"isSelected"];
            [_dataSouceArr addObject:dic];
        }
        else
        {
            Author * model = obj;
            [dic setObject:model forKey:@"model"];
            [dic setObject:model.name forKey:@"name"];
            [dic setObject:model.headPic forKey:@"icon"];
            [dic setObject:@NO forKey:@"isSelected"];
            [_dataSouceArr addObject:dic];
        }
        
    }];
    [self reloadData];
}

#pragma mark - UITableViewDataSource和UITableViewDataDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChoicePersonTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kChoicePersonTableViewCell forIndexPath:indexPath];
    [cell setCellInfo:_dataSouceArr[indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataSouceArr[indexPath.row][@"isSelected"] boolValue] == YES)
    {
        [_dataSouceArr[indexPath.row] setObject:@NO forKey:@"isSelected"];
    }
    else
    {
        [_dataSouceArr[indexPath.row] setObject:@YES forKey:@"isSelected"];
    }
    
    [self reloadData];
}

@end
