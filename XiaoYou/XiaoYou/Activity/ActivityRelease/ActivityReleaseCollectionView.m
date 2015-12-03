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
#import "CheckCollectionViewCell.h"

@interface ActivityReleaseCollectionView ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate>

//是否为社长
@property (nonatomic,assign) BOOL isIdentity;

@end

@implementation ActivityReleaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
                andIsIdentity:(BOOL) isIdentity
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        _isIdentity = isIdentity;
        
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[NameCollectionViewCell class]
 forCellWithReuseIdentifier:kNameCollectionViewCell];
        [self registerClass:[DescriptionCollectionViewCell class]
 forCellWithReuseIdentifier:kDescriptionCollectionViewCell];
        [self registerClass:[DateAndTimeCollectionViewCell class]
 forCellWithReuseIdentifier:kDateAndTimeCollectionViewCell];
        [self registerClass:[TypeCollectionViewCell class]
 forCellWithReuseIdentifier:kTypeCollectionViewCell
         ];
        [self registerClass:[PlaceCollectionViewCell class]
 forCellWithReuseIdentifier:kPlaceCollectionViewCell
         ];
        [self registerClass:[CheckCollectionViewCell class]
 forCellWithReuseIdentifier:kCheckCollectionViewCell
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
    if (_isIdentity)
    {
        return 6;
    }
    else
    {
        return 5;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NameCollectionViewCell * cell =
        (NameCollectionViewCell *)[collectionView
                                   dequeueReusableCellWithReuseIdentifier:kNameCollectionViewCell
                                   forIndexPath:indexPath];
        cell.myCollectionView = self;
        return cell;
    }
    else if (indexPath.row == 1)
    {
        DescriptionCollectionViewCell * cell =
        (DescriptionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kDescriptionCollectionViewCell forIndexPath:indexPath];
        cell.myController = self.myController;
        return cell;
    }
    else if (indexPath.row == 2)
    {
        DateAndTimeCollectionViewCell * cell =
        (DateAndTimeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kDateAndTimeCollectionViewCell forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.row == 3)
    {
        PlaceCollectionViewCell * cell =
        (PlaceCollectionViewCell *)[collectionView
                                    dequeueReusableCellWithReuseIdentifier:kPlaceCollectionViewCell
                                    forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.row == 4)
    {
        TypeCollectionViewCell * cell = (TypeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kTypeCollectionViewCell forIndexPath:indexPath];
        return cell;
    }
    else
    {
        CheckCollectionViewCell * cell =
        (CheckCollectionViewCell *)[collectionView
                                    dequeueReusableCellWithReuseIdentifier:kCheckCollectionViewCell
                                    forIndexPath:indexPath];
        return cell;
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = {SCALE_NUM(230),SCALE_NUM(300)};
    return size;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@",NSStringFromCGPoint(self.contentOffset));
    if (self.contentOffset.x < SCALE_NUM(75)) {
        [self.myController setPointHighlight:POINT1];
    }
    else if (self.contentOffset.x < SCALE_NUM(305))
    {
        [self.myController setPointHighlight:POINT2];
    }
    else if (self.contentOffset.x < SCALE_NUM(535))
    {
        [self.myController setPointHighlight:POINT3];
    }
    else if (self.contentOffset.x < SCALE_NUM(760))
    {
        [self.myController setPointHighlight:POINT4];
    }
    else if (self.contentOffset.x < SCALE_NUM(1000))
    {
        [self.myController setPointHighlight:POINT5];
    }
    else
    {
        [self.myController setPointHighlight:POINT6];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing:YES];
}

@end
