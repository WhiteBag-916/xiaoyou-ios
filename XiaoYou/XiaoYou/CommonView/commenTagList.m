//
//  commenTagList.m
//  XiaoYou
//
//  Created by sheng on 15/9/22.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "commenTagList.h"

@interface commenTagList ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collView;

@end

@implementation commenTagList


-(UICollectionView *)collView
{
    if (!_collView) {
        _collView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self addSubview:_collView];
    }
    return _collView;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [[UICollectionViewCell alloc]init];
    UILabel *label = [[UILabel alloc]init];
    [cell addSubview:label];
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 200);
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
