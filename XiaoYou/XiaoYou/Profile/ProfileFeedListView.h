//
//  ProfileFeedListView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"
@class ProfilePublishViewController;
@interface ProfileFeedListView : YTableView

@property (nonatomic, weak) ProfilePublishViewController *parent;
- (void)loadData:(NSString *)userId;
@end
