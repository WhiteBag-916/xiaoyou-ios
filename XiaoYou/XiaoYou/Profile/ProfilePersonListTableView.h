//
//  ProfilePersonListTableView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@interface ProfilePersonListTableView : YTableView
- (id)initWIthType:(BOOL)isRespect;
- (void)loadData:(NSArray *)data;
@end
