//
//  FunnyDetailListView.h
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "NoticeInfo.h"

@interface ActivityDetailListView : YTableView

@property (nonatomic,copy) NSString *publishID;

//数据源
@property (nonatomic,strong) NSMutableArray *activityDetailArray;

@property (nonatomic,assign) BOOL isContainsMe;

-(void)loadData;

-(void)sendRequest;

-(void)loadNewData;
@end