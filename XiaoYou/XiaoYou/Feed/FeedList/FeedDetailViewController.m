//
//  FeedDetailViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedDetailViewController.h"

@interface FeedDetailViewController()

@property (nonatomic, strong) NSString *feedId;

@end

@implementation FeedDetailViewController

- (id)initWithFeedId:(NSString *)feedId {
    self = [super init];
    if (self) {
        _feedId = feedId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    self.title = @"详情";
    
    
}

@end
