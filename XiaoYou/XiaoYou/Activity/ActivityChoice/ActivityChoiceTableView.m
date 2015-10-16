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
#import "ActivityResultViewController.h"

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
    dissMissBtn.backgroundColor = [UIColor clearColor];
    [dissMissBtn setImage:[UIImage imageNamed:@"mine-cancel"] forState:UIControlStateNormal];
    [dissMissBtn addTarget:self action:@selector(clickBtnForCancel) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:dissMissBtn];
    [dissMissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.leading.mas_equalTo(SCALE_NUM(12));
        make.height.width.mas_equalTo(SCALE_NUM(15));
    }];
    
    //对号
    UIButton * finishBtn = [[UIButton alloc] init];
    finishBtn.backgroundColor = [UIColor clearColor];
    [finishBtn setImage:[UIImage imageNamed:@"mine-complete-grey"] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(clickBtnForChoice) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:finishBtn];
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.width.mas_equalTo(SCALE_NUM(15));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    //筛选
    UILabel * centerLabel = [[UILabel alloc] init];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.text = @"筛选";
    centerLabel.font = CONTENT_FONT(15);
    [backView addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(backView);
        make.height.mas_equalTo(SCALE_NUM(20));
        make.width.mas_equalTo(SCALE_NUM(60));
    }];
    
    self.tableHeaderView = backView;
}

-(void)clickBtnForCancel
{
    [self.myController dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickBtnForChoice
{
    [self.myController dismissViewControllerAnimated:YES completion:nil];
    ActivityResultViewController * resultViewController = [[ActivityResultViewController alloc] init];
    [self.myController.superViewController.navigationController pushViewController:resultViewController animated:YES];

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
//    if (indexPath.row == 0)
//    {
//        ActivityDateAndTimeCell * cell = [self dequeueReusableCellWithIdentifier:kActivityDateAndTimeCell forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//    else
//    {
        ActivityReleaseAndTypeCell * cell = [self dequeueReusableCellWithIdentifier:kActivityReleaseAndTypeCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellType:indexPath.row];
        return cell;
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0)
//    {
//        return SCALE_NUM(180);
//    }
//    else
//    {
        return SCALE_NUM(140);
//    }
    
}

@end
