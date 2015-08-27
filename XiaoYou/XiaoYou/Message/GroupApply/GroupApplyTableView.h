//
//  GroupApplyTableView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@class YViewController;

@interface GroupApplyTableView : YTableView

@property (nonatomic, weak) YViewController *superVC;

- (instancetype)initWithGroupId:(NSString *)groupId;

- (void)loadData;

-(void)refreshTableView:(NSArray *) dataSouceArr;

@end
