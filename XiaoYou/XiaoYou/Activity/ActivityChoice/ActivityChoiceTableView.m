//
//  ActivityChoiceTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityChoiceTableView.h"
#import "ActivityReleaseAndTypeCell.h"
#import "ActivityResultViewController.h"
#import "ActivityChoiceController.h"

@interface ActivityChoiceTableView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation ActivityChoiceTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self setUpHeaderView];

        [self registerClass:[ActivityReleaseAndTypeCell class] forCellReuseIdentifier:kActivityReleaseAndTypeCell];
    }
    return self;
}

-(void)setUpHeaderView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    backView.backgroundColor = [UIColor clearColor];
    //错号
    UIButton * dissMissBtn = [[UIButton alloc] init];
    dissMissBtn.backgroundColor = [UIColor clearColor];
    [dissMissBtn setImage:[UIImage imageNamed:@"mine-cancel"] forState:UIControlStateNormal];
    [dissMissBtn addTarget:self action:@selector(clickBtnForCancel) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:dissMissBtn];
    [dissMissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.leading.mas_equalTo(SCALE_NUM(12));
        make.height.width.mas_equalTo(SCALE_NUM(30));
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
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    //筛选
    UILabel * centerLabel = [[UILabel alloc] init];
    centerLabel.backgroundColor = [UIColor clearColor];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    if (_myType == ACTIVITY_CHOICE_TYPE)
    {
        centerLabel.text = @"活动筛选";
    }
    else
    {
        centerLabel.text = @"蹭课筛选";
    }
    centerLabel.font = CONTENT_FONT(15);
    [backView addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(backView);
        make.height.mas_equalTo(SCALE_NUM(20));
        make.width.mas_equalTo(SCALE_NUM(80));
    }];
    
    self.tableHeaderView = backView;
}

-(void)clickBtnForCancel
{
    [self.myController dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickBtnForChoice
{
    if (_myType == ACTIVITY_CHOICE_TYPE)
    {
        [self.myController dismissViewControllerAnimated:YES completion:^{
            ActivityResultViewController * resultViewController = [[ActivityResultViewController alloc] init];
            [self.myController.activityViewController.navigationController pushViewController:resultViewController animated:YES needHiddenBottomBar:YES];
        }];
    }
    else
    {
        [self.myController dismissViewControllerAnimated:YES completion:nil];
    }
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_myType == ACTIVITY_CHOICE_TYPE) {
        return 4;
    }
    else
    {
        return 1;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        ActivityReleaseAndTypeCell * cell = [self dequeueReusableCellWithIdentifier:kActivityReleaseAndTypeCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.myType = _myType;
        [cell setCellType:indexPath.row];
        return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        return SCALE_NUM(130);
    
}

@end
