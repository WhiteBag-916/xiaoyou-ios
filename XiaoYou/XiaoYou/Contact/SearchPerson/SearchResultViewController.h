//
//  SearchResultViewController.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

@interface SearchResultViewController : YViewController

@property (nonatomic, strong) NSMutableArray *searchCondition; //搜索条件,如果有名字，加上姓名
@property (nonatomic, strong) NSString *searchName;     //搜索名字

@end
