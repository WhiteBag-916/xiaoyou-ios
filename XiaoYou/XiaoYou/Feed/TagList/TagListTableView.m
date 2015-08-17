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
#import "SlideNavigationController.h"

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
        self.backgroundColor = [UIColor clearColor];
        _data = @[@"互联网",@"同班"];
    }
    return self;
}

- (NSInteger)numberOfSections {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCALE_NUM(45);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_data.count == indexPath.row)
    {
        [self toAddTag];
    }
}

//跳转到添加标签
- (void)toAddTag {
    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_AddTag object:nil];
    }];
}
@end
