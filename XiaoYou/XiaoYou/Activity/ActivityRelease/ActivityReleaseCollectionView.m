//
//  ActivityReleaseCollectionView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityReleaseCollectionView.h"
#import "NameCollectionViewCell.h"
#import "PlaceCollectionViewCell.h"
#import "DescriptionCollectionViewCell.h"
#import "DateAndTimeCollectionViewCell.h"
#import "TypeCollectionViewCell.h"

@interface ActivityReleaseCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@end

@implementation ActivityReleaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        self.pagingEnabled = NO;
        
        [self registerClass:[NameCollectionViewCell class] forCellWithReuseIdentifier:kNameCollectionViewCell];
        [self registerClass:[DescriptionCollectionViewCell class] forCellWithReuseIdentifier:kDescriptionCollectionViewCell];
        [self registerClass:[DateAndTimeCollectionViewCell class] forCellWithReuseIdentifier:kDateAndTimeCollectionViewCell];
        [self registerClass:[TypeCollectionViewCell class] forCellWithReuseIdentifier:kTypeCollectionViewCell
         ];
        [self registerClass:[PlaceCollectionViewCell class] forCellWithReuseIdentifier:kPlaceCollectionViewCell
         ];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource和UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NameCollectionViewCell * cell = (NameCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kNameCollectionViewCell forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        DescriptionCollectionViewCell * cell = (DescriptionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kDescriptionCollectionViewCell forIndexPath:indexPath];
        cell.myController = self.myController;
        return cell;
    }
    else if (indexPath.row == 2)
    {
        DateAndTimeCollectionViewCell * cell = (DateAndTimeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kDateAndTimeCollectionViewCell forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.row == 3)
    {
        PlaceCollectionViewCell * cell = (PlaceCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kPlaceCollectionViewCell forIndexPath:indexPath];
        return cell;
    }
    else
    {
        TypeCollectionViewCell * cell = (TypeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kTypeCollectionViewCell forIndexPath:indexPath];
        return cell;
    }
    
}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}


//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    UIEdgeInsets insets = UIEdgeInsetsMake(0, 10, 0, 10);
//    return insets;
//}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = {SCALE_NUM(230),SCALE_NUM(300)};
    return size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@",NSStringFromCGPoint(self.contentOffset));
    if (self.contentOffset.x < SCALE_NUM(75)) {
        [self.myController setPointHighlight:1];
    }
    else if (self.contentOffset.x < SCALE_NUM(305))
    {
        [self.myController setPointHighlight:2];
    }
    else if (self.contentOffset.x < SCALE_NUM(535))
    {
        [self.myController setPointHighlight:3];
    }
    else if (self.contentOffset.x < SCALE_NUM(760))
    {
        [self.myController setPointHighlight:4];
    }
    else
    {
        [self.myController setPointHighlight:5];
    }
}

@end
