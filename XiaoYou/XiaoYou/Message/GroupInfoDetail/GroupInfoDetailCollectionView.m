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
#import "ProfileInfo.h"
#import "Tags.h"
#import "GroupModel.h"
#import "Author.h"
#import "XYChoicePersonViewController.h"
#import "ContactManager.h"


#define kPaddingDistance                10
#define kHeaderViewHeight               100

@interface GroupInfoDetailCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GroupInfoCollectionViewCellDelegate>

@property (nonatomic,strong)GroupModel * headerModel;
@property (nonatomic,strong)GroupInfoDetailHeaderView * headView;
@property (nonatomic, assign) BOOL isShowDel;
@property (nonatomic,strong)NSMutableArray * dataSourceArr;

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
        _dataSourceArr = [[NSMutableArray alloc] init];
        
        _isShowDel = NO;
    }
    return self;
}

- (void)showDel:(BOOL)show {
    if (_isShowDel != show) {
        _isShowDel = show;
        
        [_dataSourceArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            obj[@"isDelete"] = @(show);
        }];
        
        [self reloadData];
    }
}

-(void)refreshTableView:(GroupDetail *) model
{
    [_dataSourceArr removeAllObjects];
    _headerModel = model.groupModel;
    NSMutableArray * tempDataSourceArr = [[NSMutableArray alloc] initWithArray:model.groupMemebers];
    for (int i = 0; i < tempDataSourceArr.count; i++)
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:tempDataSourceArr[i] forKey:@"model"];
        [dic setObject:@NO forKey:@"isDelete"];
        [_dataSourceArr addObject:dic];
    }
    [_headView setHeaderViewInfo:_headerModel];
    [self reloadData];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * groupArr =[[ProvisionManager sharedInstance] getProfile].managerGroups;
    if (groupArr.count > 0)
    {
        for (int i = 0; i < groupArr.count; i++)
        {
            Tags * tag = groupArr[i];
            if ([[@(_headerModel.internalBaseClassIdentifier) stringValue] isEqualToString: tag.internalBaseClassIdentifier])
            {
                return _dataSourceArr.count + 1;
            }
        }
        return _dataSourceArr.count; 
    }
    else
    {
        return _dataSourceArr.count;
    }
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupInfoCollectionViewCell * cell = (GroupInfoCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kGroupInfoCollectionViewCell forIndexPath:indexPath];
    cell.delegate= self;
    if (indexPath.row < _dataSourceArr.count) {
        [cell setCellInfo:_dataSourceArr[indexPath.row]];
        
        return cell;
    }
    else
    {
        Author * authr = [[Author alloc] init];
        authr.name = @"";
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:authr forKey:@"model"];
        [dic setObject:@NO forKey:@"isDelete"];
        [cell setCellInfo:dic];
        return cell;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _dataSourceArr.count)
    {
        [self showDel:NO];
    }
    else
    {
        XYChoicePersonViewController * choicePersonViewController = [[XYChoicePersonViewController alloc] init];
        choicePersonViewController.uid = [[ProvisionManager sharedInstance] getProfile].uid;
        choicePersonViewController.superType = kXYGroupInfoDetailViewController;
        [self.myController.navigationController pushViewController:choicePersonViewController animated:YES needHiddenBottomBar:YES];
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
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
    _headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kGroupInfoDetailHeaderView forIndexPath:indexPath];
    [_headView setHeaderViewInfo:_headerModel];
    return _headView;
}

#pragma mark - GroupInfoCollectionViewCellDelegate
- (void)delCell:(NSString *)uid {
    //删除
    NSArray * groupArr =[[ProvisionManager sharedInstance] getProfile].managerGroups;
    if (groupArr.count > 0)
    {
        for (int i = 0; i < groupArr.count; i++)
        {
            Tags * tag = groupArr[i];
            if ([[@(_headerModel.internalBaseClassIdentifier) stringValue] isEqualToString: tag.internalBaseClassIdentifier])
            {
                [_dataSourceArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([[obj[@"model"] uid] isEqualToString:uid])
                    {
                        [_dataSourceArr removeObjectAtIndex:idx];
                        [[ContactManager sharedInstance] deleteGroupUser:[NSString stringWithFormat:@"%g",_headerModel.internalBaseClassIdentifier] deleteUserIds:uid block:^(YActionMessage *message) {
                            
                        }];
                        *stop = YES;
                    }
                }];
            }
        }
        
    }
    else
    {
        [YUtils showTitle:@"只有社长才有此权限" hideAfter:2];
    }  
    
    [self reloadData];
}

- (void)longPressCell {
    [self showDel:YES];
}

@end
