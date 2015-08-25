//
//  AssociationsDetailTableView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsDetailTableView.h"
#import "AssociationsListTableViewCell.h"
#import "ContactsInfoDetailTableViewCell.h"
#import "FeedListTableViewCell.h"

@interface AssociationsDetailTableView ()
<UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) NSArray *feedListArray;

@end

@implementation AssociationsDetailTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[AssociationsListTableViewCell class] forCellReuseIdentifier:kAssociationsListTableViewCell];
        [self registerClass:[ContactsInfoDetailTableViewCell class] forCellReuseIdentifier:kContactsInfoDetailTableViewCell];
        [self registerClass:[FeedListTableViewCell class] forCellReuseIdentifier:kOrganizationFeedListTableViewCell];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return AssociationsDetailTableViewSectionEnd;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (AssociationsDetailTableViewTitleSection == section) {
        return 1;
    } else if (AssociationsDetailTableViewLikeSection == section) {
        return 2;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (AssociationsDetailTableViewTitleSection == section) {
        AssociationsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAssociationsListTableViewCell];
        
        return cell;
    } else if (AssociationsDetailTableViewLikeSection == section) {
        ContactsInfoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContactsInfoDetailTableViewCell];
        
        NSString * indexStr = [NSString stringWithFormat:@"%ld",row];
        
        if (0 == row)
        {
            NSDictionary * dic = @{@"content":[NSString stringWithFormat:@"%g人向%@撰写的内容敬酒", 200.0,@"网球社"],@"index":indexStr};
            [cell setCellInfo:dic hiddenLine:YES];
            return cell;
        }
        else if (1 == indexPath.row)
        {
            NSDictionary * dic = @{@"content":[NSString stringWithFormat:@"%g人觉得%@很酷", 200.0,@"网球社"],@"index":indexStr, @"isCool":@(NO)};
            [cell setCellInfo:dic hiddenLine:NO];
            return cell;
        }
        
        return cell;
    } else if (AssociationsDetailTableViewFeedSection == section) {
        FeedListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrganizationFeedListTableViewCell];
        
        return cell;
    }
    
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (AssociationsDetailTableViewTitleSection == section) {
        return SCALE_NUM(90);
    } else if (AssociationsDetailTableViewLikeSection == section) {
        return SCALE_NUM(40);
    }
    //计算高度
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kOrganizationFeedListTableViewCell cacheByIndexPath:indexPath configuration:^(FeedListTableViewCell *cell) {
        [cell setData:_feedListArray[indexPath.row]];
    }];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
