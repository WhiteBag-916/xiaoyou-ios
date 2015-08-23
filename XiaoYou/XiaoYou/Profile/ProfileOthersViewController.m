//
//  ProfileOthersViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileOthersViewController.h"

@interface ProfileOthersViewController()
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation ProfileOthersViewController

- (id)initWithUserId:(NSString *)userId {
    self = [super init];
    if (self) {
        _userId = userId;
        self.hidesBottomBarWhenPushed = true;
    }
    return self;
}
- (void)viewDidLoad {
    [self initController];
}
- (void)initController {
    self.navigationController.navigationBarHidden = false;
    self.title = @"详情";
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    self.view.backgroundColor = KCOLORWHITE;
}
@end
