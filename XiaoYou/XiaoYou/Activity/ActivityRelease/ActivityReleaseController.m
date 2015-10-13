//
//  ActivityReleaseController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityReleaseController.h"
#import "ActivityReleaseCollectionView.h"

@interface ActivityReleaseController ()

@property (nonatomic,strong) ActivityReleaseCollectionView * releaseCollectionView;

@end

@implementation ActivityReleaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

-(void)setUpUI
{
    UILabel * topLabel = [[UILabel alloc] init];
    topLabel.backgroundColor = [UIColor grayColor];
    topLabel.text = @"有创意的发布文案有助于薅到更多好玩的人";
    topLabel.font = CONTENT_FONT(12);
    [self.view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
