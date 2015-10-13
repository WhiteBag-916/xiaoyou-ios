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

@interface StudyRoomTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@end

@implementation StudyRoomTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[StudyRoomTableViewCell class] forCellReuseIdentifier:kStudyRoomTableViewCell];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudyRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudyRoomTableViewCell];
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
    [self.viewController.navigationController pushViewController:vc animated:YES needHiddenBottomBar:YES];
    return;
}
@end
