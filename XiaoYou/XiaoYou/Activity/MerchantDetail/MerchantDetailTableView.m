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
#import "SupplierShopDiscounts.h"

@interface MerchantDetailTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)TopView * topView;
@property(nonatomic,strong)MiddleInfoView * middleInfoView;
@property(nonatomic,strong)ShopList * model;
@property(nonatomic,strong)NSMutableArray * dataSourceArr;

@end

@implementation MerchantDetailTableView

- (instancetype)initWithModel:(ShopList *) model
{
    self = [super init];
    if (self) {
        
        _model = model;
        self.dataSourceArr = (NSMutableArray *)_model.supplierShopDiscounts;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self setUpHeaderView];
        
        [self registerClass:[MerchantDetailTableViewCell class] forCellReuseIdentifier:kMerchantDetailTableViewCell];
    }
    return self;
}

-(NSMutableArray *)dataSourceArr
{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

-(void)setUpHeaderView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*3/4+SCALE_NUM(132))];
 
    _topView = [[TopView alloc] initWithModel:_model];
    _topView.backgroundColor = [UIColor clearColor];
    [backView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH*3/4);
    }];
    
    _middleInfoView = [[MiddleInfoView alloc] initWithModel:_model];
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
    return _dataSourceArr.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMerchantDetailTableViewCell forIndexPath:indexPath];
    if (indexPath.row == 0)
    {
        [cell setCellInfo:nil isHeader:YES];
    }
    else
    {
        [cell setCellInfo:_dataSourceArr[indexPath.row -1] isHeader:NO];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSourceArr.count == indexPath.row) {
        return SCALE_NUM(70);
    }
    else
    {
        return SCALE_NUM(50);
    }
}

@end
