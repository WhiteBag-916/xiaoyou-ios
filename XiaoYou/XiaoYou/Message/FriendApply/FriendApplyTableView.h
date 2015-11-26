//
//  FriendApplyTableView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@class YViewController;

@interface FriendApplyTableView : YTableView

@property (nonatomic, weak) YViewController *superVC;
@property (nonatomic, strong) NSString *chatter;

-(NSArray *)getDataSource;

- (void)loadData;

-(void)refreshTableView:(NSArray *) dataSouceArr;

@end
