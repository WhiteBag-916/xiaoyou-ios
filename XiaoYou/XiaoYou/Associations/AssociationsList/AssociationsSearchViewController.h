//
//  AssociationsSearchViewController.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/26.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

typedef enum : NSUInteger {
    ASSOCIATION_TYPE,       //搜索社团
    ACTIVITY_TYPE,          //活动类型
} SEARCH_TYPE;

@interface AssociationsSearchViewController : YViewController

@property (nonatomic,assign) SEARCH_TYPE searchType;

- (id)initWithArray:(NSArray *)array;

//是否展示没数据
- (void)hiddenNodata:(BOOL)hidden;

@end
