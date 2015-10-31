//
//  StudyRoomDetailTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "StudyRoomDetailTableView.h"
#import "StudyRoomDetailTableViewCell.h"
#import "ActivityManager.h"

@interface StudyRoomDetailTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

@end

@implementation StudyRoomDetailTableView

- (instancetype)initWithBuildName:(NSString *) name
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self sendRequest:name];
        [self registerClass:[StudyRoomDetailTableViewCell class] forCellReuseIdentifier:kStudyRoomDetailTableViewCell];
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


- (void)sendRequest:(NSString *)name
{
    [YUtils showHUDWithTitle];
    [[ActivityManager sharedInstance] freeBuildingDetail:name block:^(YActionMessage *message) {
        
        [YUtils hiddenProgressHUD];
        if (message.isSuccess) {
            
            self.dataSouceArr = message.object;
            [self reloadData];
        }
        else
        {
            [YUtils showTitle:message.desc hideAfter:2];
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
    StudyRoomDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudyRoomDetailTableViewCell];
    [cell initData:_dataSouceArr[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(75);
}

@end
