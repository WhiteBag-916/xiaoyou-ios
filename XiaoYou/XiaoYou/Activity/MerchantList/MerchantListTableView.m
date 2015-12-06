//
//  MerchantListTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MerchantListTableView.h"
#import "MerchantListTableViewCell.h"
#import "MerchantDetailViewController.h"
#import "CodeManager.h"

#define KPAGENUM    6

@interface MerchantListTableView ()
<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSourceArr;
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation MerchantListTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle =  UITableViewCellSeparatorStyleNone;
        [self registerClass:[MerchantListTableViewCell class]
     forCellReuseIdentifier:kMerchantListTableViewCell];
        
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

#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return YES;
}

- (BOOL)showFooterRefresh
{
    return YES;
}

- (void)loadData {
    [self beginLoadNewData];
}

- (void)loadNewData
{
    _currentIndex = 0;
    [self sendRequest];
}

- (void)loadMoreData
{
    _currentIndex = self.dataSourceArr.count;
    [self sendRequest];
}

- (void)sendRequest{
    
    [[CodeManager sharedInstance] getShopListLimitStart:_currentIndex
                                               limitEnd:_currentIndex+KPAGENUM
                                                  block:^(YActionMessage *message) {
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [self.dataSourceArr removeAllObjects];
            }
            [self.dataSourceArr addObjectsFromArray:message.object];
            
            
            [self hiddenFooter:NO];
            if ([message.object count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            [self reloadData];
            _currentIndex += KPAGENUM;
        } else {
            [YUtils showTitle:message.desc hideAfter:2];
        }
        if ([self isHeaderRefresh]) {
            [self stopLoadNewData];
        } else
        {
            [self stopLoadMoreData];
        }
    }];

}

-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantListTableViewCell * cell = [tableView
                                        dequeueReusableCellWithIdentifier:kMerchantListTableViewCell
                                        forIndexPath:indexPath];
    [cell setCellData:_dataSourceArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [YAnalysis trackEvent:@"查看合作商家" withPara:nil];
    MerchantDetailViewController * merchantDetailViewController =
    [[MerchantDetailViewController alloc] initWithModel:_dataSourceArr[indexPath.row]];
    [self.viewController.navigationController
     pushViewController:merchantDetailViewController animated:YES];
}

-(void)gotoDetailWithCellType
{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(130);
}

@end
