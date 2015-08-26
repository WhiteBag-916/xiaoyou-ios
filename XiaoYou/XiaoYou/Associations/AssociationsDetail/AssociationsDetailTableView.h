//
//  AssociationsDetailTableView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@class YViewController;

typedef NS_ENUM(NSInteger, AssociationsDetailTableViewSection) {
    AssociationsDetailTableViewTitleSection=0,      //社团详情
    AssociationsDetailTableViewLikeSection,         //点赞，酷
    AssociationsDetailTableViewFeedSection,         //feed
    AssociationsDetailTableViewSectionEnd
};

@interface AssociationsDetailTableView : YTableView

@property (nonatomic, weak) YViewController *parent;

@end
