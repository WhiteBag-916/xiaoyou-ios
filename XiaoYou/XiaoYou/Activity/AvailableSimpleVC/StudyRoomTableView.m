//
//  StudyRoomTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "StudyRoomTableView.h"
#import "StudyRoomTableViewCell.h"
#import "AvailableSimpleViewController.h"
#import "ActivityManager.h"

@interface StudyRoomTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

@end

@implementation StudyRoomTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self sendRequest];
        
        [self registerClass:[StudyRoomTableViewCell class] forCellReuseIdentifier:kStudyRoomTableViewCell];
    }
    return self;
}

-(NSMutableArray *)dataSouceArr
{
    if (!_dataSouceArr) {
        _dataSouceArr = [NSMutableArray array];
    }
    return _dataSouceArr;
}

#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return NO;
}

- (BOOL)showFooterRefresh
{
    return NO;
}

- (void)loadData {
    [self beginLoadNewData];
}

- (void)loadNewData
{
    [self sendRequest];
}

- (void)loadMoreData
{
    [self sendRequest];
}

- (void)sendRequest{
    
    [YUtils showHUDWithTitle];
    [[ActivityManager sharedInstance] freeBuildingList:^(YActionMessage *message) {
        
        if (message.isSuccess)
        {
            [YUtils hiddenProgressHUD];
            self.dataSouceArr = message.object;
            [self reloadData];
        }
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudyRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudyRoomTableViewCell];
    [cell initData:_dataSouceArr[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AvailableSimpleViewController *vc = [[AvailableSimpleViewController alloc] initWithType:AvailableSimpleTypeStudyRoomDetail];
    vc.num = indexPath.row;
    FreeBuildingListModel * model = _dataSouceArr[indexPath.row];
    vc.buildName = model.buildName;
    [self.viewController.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
    return;
}
@end
