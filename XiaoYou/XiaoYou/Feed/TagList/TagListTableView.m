//
//  TagListTableView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "TagListTableView.h"
#import "YUtils+Component.h"
#import "TagListTableViewCell.h"

@interface TagListTableView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *data;
@end

@implementation TagListTableView

- (id)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TagListTableViewCell class] forCellReuseIdentifier:KTagListTableViewCell];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

- (NSInteger)numberOfSections {
    return 1;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return _data.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCALE_NUM(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SCALE_NUM(40);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCALE_NUM(40);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagListTableViewCell *cell = [self dequeueReusableCellWithIdentifier:KTagListTableViewCell];
    if (indexPath.row < _data.count) {
        [cell setData:_data[indexPath.row]];
    } else {
        [cell setData:nil];
    }
    return cell;
}
@end
