//
//  GroupInfoDetailCollectionView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupInfoDetailCollectionView.h"
#import "GroupInfoCollectionViewCell.h"
#import "YSystemDefine.h"
#import "GroupInfoDetailHeaderView.h"
#import "ProvisionManager.h"

#define kPaddingDistance                10
#define kHeaderViewHeight               100

@interface GroupInfoDetailCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSMutableArray * dataSourceArr;
@property (nonatomic,strong)GroupModel * headerModel;

@end

@implementation GroupInfoDetailCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        
        [self registerClass:[GroupInfoCollectionViewCell class] forCellWithReuseIdentifier:kGroupInfoCollectionViewCell];   
        [self registerClass:[GroupInfoDetailHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kGroupInfoDetailHeaderView];
    }
    return self;
}

-(void)refreshTableView:(GroupDetail *) model
{
    _headerModel = model.groupModel;
    _dataSourceArr = [[NSMutableArray alloc] initWithArray:model.groupMemebers];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSourceArr.count + 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupInfoCollectionViewCell * cell = (GroupInfoCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kGroupInfoCollectionViewCell forIndexPath:indexPath];
    if (indexPath.row < _dataSourceArr.count) {
        
        [cell setCellInfo:_dataSourceArr[indexPath.row]];
        
        return cell;
    }
    else
    {
        
        [cell setCellInfo:@{@"name":@"",@"add":@"add"}];
        
        return cell;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"highLight");
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(kPaddingDistance, kPaddingDistance, kPaddingDistance, kPaddingDistance);
    return insets;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {SCREEN_WIDTH,kHeaderViewHeight};
    return size;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    GroupInfoDetailHeaderView *headView;
    
    headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kGroupInfoDetailHeaderView forIndexPath:indexPath];
    [headView setHeaderViewInfo:_headerModel];
    return headView;
}

@end
