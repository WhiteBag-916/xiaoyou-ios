//
//  MerchantDetailTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MerchantDetailTableView.h"
#import "TopView.h"
#import "MiddleInfoView.h"
#import "MerchantDetailTableViewCell.h"

@interface MerchantDetailTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)TopView * topView;
@property(nonatomic,strong)MiddleInfoView * middleInfoView;

@end

@implementation MerchantDetailTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self setUpHeaderView];
        
        [self registerClass:[MerchantDetailTableViewCell class] forCellReuseIdentifier:kMerchantDetailTableViewCell];
    }
    return self;
}

-(void)setUpHeaderView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_NUM(300))];
 
    _topView = [[TopView alloc] initWithImageCount:8];
    _topView.backgroundColor = [UIColor clearColor];
    [backView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(150));
    }];
    
    _middleInfoView = [[MiddleInfoView alloc] init];
    _middleInfoView.backgroundColor = [UIColor clearColor];
    [backView addSubview:_middleInfoView];
    [_middleInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(132));
        make.top.equalTo(_topView.mas_bottom);
    }];
    
    self.tableHeaderView = backView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMerchantDetailTableViewCell forIndexPath:indexPath];
    if (indexPath.row == 0)
    {
        [cell setCellInfo:@"商家优惠详情" isHeader:YES];
    }
    else
    {
        [cell setCellInfo:@"商家优惠优惠详情商家优惠优惠详情商家优惠优惠详情商家优惠优惠详情商家优惠优惠详情商家优惠优惠详情" isHeader:NO];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(50);
}

@end
