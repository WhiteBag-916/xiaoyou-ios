//
//  FeedDetailViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedDetailViewController.h"
#import "FeedDetailTableView.h"
#import "Masonry.h"

#define KBOTTOMHEIGHT SCALE_NUM(30)
@interface FeedDetailViewController()

@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) FeedDetailTableView *feedDetailTable;

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
    [self initRightBarButton];
    [self initTable];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [_feedDetailTable loadData:@[@"",@""]];
}

- (void)initRightBarButton {
    UIBarButtonItem  *btn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(openShare)];
    btn.tintColor = [UIColor clearColor];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)initTable {
    _feedDetailTable  = [[FeedDetailTableView alloc] init];
    [self.view addSubview:_feedDetailTable];
    [_feedDetailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-KBOTTOMHEIGHT);
    }];
}

- (void)openShare {
    
}
@end
