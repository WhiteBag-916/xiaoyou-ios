//
//  StudyRoomDetailTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "StudyRoomDetailTableView.h"
#import "StudyRoomDetailTableViewCell.h"

@interface StudyRoomDetailTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@end

@implementation StudyRoomDetailTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[StudyRoomDetailTableViewCell class] forCellReuseIdentifier:kStudyRoomDetailTableViewCell];
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
    StudyRoomDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStudyRoomDetailTableViewCell];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(75);
}

@end
