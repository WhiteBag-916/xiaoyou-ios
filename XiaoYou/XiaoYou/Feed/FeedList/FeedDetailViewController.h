//
//  FeedDetailViewController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

@interface FeedDetailViewController : YViewController

- (id)initWithFeedId:(NSString *)feedId;

- (void)openInputWithId:(NSString *)userId name:(NSString *)userName;

@end
