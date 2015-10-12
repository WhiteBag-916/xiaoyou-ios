//
//  ActivityChoiceTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityChoiceTableView.h"
#import "ActivityDateAndTimeCell.h"
#import "ActivityReleaseAndTypeCell.h"

@interface ActivityChoiceTableView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation ActivityChoiceTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self setUpHeaderView];
        
        [self registerClass:[ActivityDateAndTimeCell class] forCellReuseIdentifier:kActivityDateAndTimeCell];
        [self registerClass:[ActivityReleaseAndTypeCell class] forCellReuseIdentifier:kActivityReleaseAndTypeCell];
    }
    return self;
}

-(void)setUpHeaderView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    //错号
    UIButton * dissMissBtn = [[UIButton alloc] init];
    dissMissBtn.backgroundColor = [UIColor redColor];
    [backView addSubview:dissMissBtn];
    [dissMissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.leading.mas_equalTo(12);
        make.height.width.mas_equalTo(15);
    }];
    
    //对号
    UIButton * finishBtn = [[UIButton alloc] init];
    finishBtn.backgroundColor = [UIColor redColor];
    [backView addSubview:finishBtn];
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.trailing.mas_equalTo(-12);
        make.height.width.mas_equalTo(15);
    }];
    //筛选
    UILabel * centerLabel = [[UILabel alloc] init];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.text = @"筛选";
    centerLabel.font = CONTENT_FONT(14);
    [backView addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(backView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    self.tableHeaderView = backView;
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
    if (indexPath.row == 0)
    {
        ActivityDateAndTimeCell * cell = [self dequeueReusableCellWithIdentifier:kActivityDateAndTimeCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        ActivityReleaseAndTypeCell * cell = [self dequeueReusableCellWithIdentifier:kActivityReleaseAndTypeCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellType:indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 160;
    }
    else
    {
        return 140;
    }
    
}

@end
