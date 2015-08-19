//
//  SearchFilterViewController.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

typedef void(^SearchFilterSelectedBlock)(NSArray *select);

@interface SearchFilterViewController : YViewController

@property (nonatomic, strong) NSArray *isSelectArray;

- (void)endSelected:(SearchFilterSelectedBlock)block;

@end
