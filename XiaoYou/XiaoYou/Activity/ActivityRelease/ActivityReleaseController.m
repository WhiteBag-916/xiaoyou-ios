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
    //顶部Label
    UILabel * topLabel = [[UILabel alloc] init];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.text = @"有创意的发布文案有助于薅到更多好玩的人";
    topLabel.textColor = KCOLORGREEN_B5;
    topLabel.font = CONTENT_FONT(12);
    [self.view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(40);
    }];
    
    //CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _releaseCollectionView = [[ActivityReleaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _releaseCollectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_releaseCollectionView];
    [_releaseCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(305);
    }];
    
    //.........
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
