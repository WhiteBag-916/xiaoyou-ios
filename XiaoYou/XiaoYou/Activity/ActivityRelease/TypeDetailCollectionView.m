//
//  TypeDetailCollectionView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/14.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TypeDetailCollectionView.h"
#import "TypeDetailCollectionViewCell.h"

@interface TypeDetailCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

@end

@implementation TypeDetailCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.pagingEnabled = NO;
        [self registerClass:[TypeDetailCollectionViewCell class] forCellWithReuseIdentifier:kTypeDetailCollectionViewCell];
        _dataSouceArr = [[NSMutableArray alloc] initWithArray:@[[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"综合类",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"公益类",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"体育类",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"文艺类",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"学术类",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"学术型",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"科技类",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"国际交流类",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"职业类",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"技术类",@"isChoice":@NO}]]];
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
    return _dataSouceArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TypeDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTypeDetailCollectionViewCell forIndexPath:indexPath];
    [cell setCellInfo:_dataSouceArr[indexPath.row]];
    return cell;
    
}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}


//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, -5, 0);
//    return insets;
//}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = {90,28};
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataSouceArr[indexPath.row][@"isChoice"] boolValue] == YES)
    {
        [_dataSouceArr[indexPath.row] setObject:@NO forKey:@"isChoice"];
    }
    else
    {
        [_dataSouceArr[indexPath.row] setObject:@YES forKey:@"isChoice"];
    }
    
    [self reloadData];
}

@end
