//
//  FriendApplyTableViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"
#import "ApplicantList.h"

@class YViewController;

extern NSString *const kFriendApplyTableViewCell;

@interface FriendApplyTableViewCell : YTableViewCell

@property (nonatomic, weak) YViewController *superVC;

-(void)setCellInfo:(ApplicantList *) model;

@end
