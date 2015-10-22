//
//  FunnyDetailListView.h
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "ActivityModel.h"

@interface ActivityDetailListView : YTableView

@property (nonatomic,strong) ActivityModel *model;
@end