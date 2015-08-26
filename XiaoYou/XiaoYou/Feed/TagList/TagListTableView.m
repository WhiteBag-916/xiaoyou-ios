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
#import "ProfileInfo.h"
#import "ProvisionManager.h"
#import "Tags.h"

@interface TagListTableView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) int type;
@end

@implementation TagListTableView


- (id)initWithType:(int)type {
    self = [super init];
    if (self) {
        _type = type;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TagListTableViewCell class] forCellReuseIdentifier:KTagListTableViewCell];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = false;
    }
    return self;
}
- (void)loadData {
    ProfileInfo *info = [[ProvisionManager sharedInstance] getProfile];
    _data = [info.tagModels arrayByAddingObjectsFromArray:info.queryCodes];
    [self reloadData];
}
- (void)setData:(NSArray *)tagNames {
    _data = [NSArray arrayWithArray:tagNames];
    [self reloadData];
}
- (NSInteger)numberOfSections {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_type == TagMenuType) {
        return _data.count + 1;
    }
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCALE_NUM(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagListTableViewCell *cell = [self dequeueReusableCellWithIdentifier:KTagListTableViewCell];
    if (indexPath.row < _data.count) {
        if (_type == TagMenuType) {
            [cell setData:[_data[indexPath.row] name]];
        } else {
            [cell setData:_data[indexPath.row]];
        }
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
    } else {
        if (_type == TagMenuType) {
            Tags *tag = _data[indexPath.row];
            
            [self toFeedFilter:tag.internalBaseClassIdentifier name:tag.name];
        }
    }
}
- (void)toFeedFilter:(NSString *)filter name:(NSString *)name {
    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_FeedFilter object:nil userInfo:@{@"filter":filter, @"name":name}];
    }];
}
//跳转到添加标签
- (void)toAddTag {
    [[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Push_AddTag object:nil];
    }];
}
@end
