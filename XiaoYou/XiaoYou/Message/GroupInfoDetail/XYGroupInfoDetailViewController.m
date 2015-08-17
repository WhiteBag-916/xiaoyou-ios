//
//  XYGroupInfoDetailViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYGroupInfoDetailViewController.h"
#import "GroupInfoDetailCollectionView.h"

@interface XYGroupInfoDetailViewController ()

@property (nonatomic,strong) GroupInfoDetailCollectionView * groupInfoDetailCollectionView;

@end

@implementation XYGroupInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    [self setUpUI];
    
}

-(void)setUpUI
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(70, 70);
    _groupInfoDetailCollectionView = [[GroupInfoDetailCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KTabBarheight-KNavigationBarheight) collectionViewLayout:flowLayout];
    [self.view addSubview:_groupInfoDetailCollectionView];
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
