//
//  FeedFilterViewController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

@interface FeedFilterViewController : YViewController

@property (nonatomic, assign) BOOL needRefresh;
- (id)initWithFilter:(NSString *)filter name:(NSString *)name;

- (void)goToDetail:(NSString *)feedId;
@end
