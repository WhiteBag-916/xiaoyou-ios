//
//  RemindListTableView.h
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@interface RemindListTableView : YTableView

@property (nonatomic,strong) NSMutableArray *remindListArray;

- (void)sendRequest;

@end
