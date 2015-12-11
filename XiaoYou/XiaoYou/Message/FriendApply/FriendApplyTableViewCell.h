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

@protocol FriendApplyTableViewCellDelegate <NSObject>

-(void)didSelectButton:(double) num applyId:(double) applyId;

@end

@interface FriendApplyTableViewCell : YTableViewCell

@property (nonatomic, weak) YViewController *superVC;
@property (nonatomic, weak) id<FriendApplyTableViewCellDelegate>delegate;

-(void)setCellInfo:(ApplicantList *) model;

@end
