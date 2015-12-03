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
#import "XYContactsInfoDetailViewController.h"
#import "ContactManager.h"


#define kPaddingDistance                SCALE_NUM(10)
#define kHeaderViewHeight               SCALE_NUM(100)

@interface GroupInfoDetailCollectionView ()
<UICollectionViewDataSource,UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,GroupInfoCollectionViewCellDelegate>

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
        
        [self registerClass:[GroupInfoCollectionViewCell class]
 forCellWithReuseIdentifier:kGroupInfoCollectionViewCell];
        [self registerClass:[GroupInfoDetailHeaderView class]
 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
        withReuseIdentifier:kGroupInfoDetailHeaderView];
        _dataSourceArr = [[NSMutableArray alloc] init];
        
        _isShowDel = NO;
    }
    return self;
}

#pragma mark - GroupInfoCollectionViewCellDelegate
- (void)showDel:(BOOL)show {
    if (_isShowDel != show) {
        _isShowDel = show;
        
        [_dataSourceArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![[obj[@"model"] uid] isEqualToString:[YShareData defaultData][kShareData_UserID]])
            {
                obj[@"isDelete"] = @(show);
            }
        }];
        
        [self reloadData];
    }
}

#pragma mark - 刷新界面
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
    [_headView setHeaderViewInfo:_headerModel andIsClass:self.myController.isClass];
    [self reloadData];
}

#pragma mark - UICollectionViewDataSource和UICollectionViewDelegate
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
            if ([[@(_headerModel.internalBaseClassIdentifier) stringValue]
                 isEqualToString: tag.internalBaseClassIdentifier])
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
    [MobClick event:@"event23"];
    GroupInfoCollectionViewCell * cell =
    (GroupInfoCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    if (indexPath.row < _dataSourceArr.count)
    {
        if ([[_dataSourceArr[indexPath.row] objectForKey:@"isDelete"] boolValue])
        {
            [self showDel:NO];
        }
        else
        {
            if ([[_dataSourceArr[indexPath.row][@"model"] uid]
                 isEqualToString:[YShareData defaultData][kShareData_UserID]])
            {
                return;
            }
            else
            {
                XYContactsInfoDetailViewController * contactsInfoDetailVC =
                [[XYContactsInfoDetailViewController alloc] init];
                contactsInfoDetailVC.studentDic = (NSMutableDictionary *)cell.modelDic;
                contactsInfoDetailVC.uid = [_dataSourceArr[indexPath.row][@"model"] uid];
                [self.myController.navigationController pushViewController:contactsInfoDetailVC
                                                                  animated:YES
                                                       needHiddenBottomBar:YES];
            }
            
        }
        
    }
    else
    {

        XYChoicePersonViewController * choicePersonViewController =
        [[XYChoicePersonViewController alloc] init];
        choicePersonViewController.superType = kXYGroupInfoDetailViewController;
        choicePersonViewController.groupId = self.myController.gid;
        [self.myController.navigationController pushViewController:choicePersonViewController
                                                          animated:YES needHiddenBottomBar:YES];
    
        
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
    return SCALE_NUM(5);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(kPaddingDistance, kPaddingDistance,
                                           kPaddingDistance, kPaddingDistance);
    return insets;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return SCALE_NUM(20);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {SCREEN_WIDTH,kHeaderViewHeight};
    return size;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    _headView =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                       withReuseIdentifier:kGroupInfoDetailHeaderView
                                              forIndexPath:indexPath];
    [_headView setHeaderViewInfo:_headerModel andIsClass:self.myController.isClass];
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
            if ([[@(_headerModel.internalBaseClassIdentifier) stringValue]
                 isEqualToString: tag.internalBaseClassIdentifier])
            {
                [_dataSourceArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([[obj[@"model"] uid] isEqualToString:uid])
                    {
                        [_dataSourceArr removeObjectAtIndex:idx];
                        [[ContactManager sharedInstance] deleteGroupUser:
                         [NSString stringWithFormat:@"%g",_headerModel.internalBaseClassIdentifier]
                                                           deleteUserIds:uid
                                                                   block:^(YActionMessage *message) {
                            
                        }];
                        *stop = YES;
                    }
                }];
            }

        }
        
    } 
    
    [self reloadData];
}

- (void)longPressCell {
    
    if (!_myController.isClass)
    {
        NSArray * groupArr =[[ProvisionManager sharedInstance] getProfile].managerGroups;
        if (groupArr.count > 0)
        {
            for (int i = 0; i < groupArr.count; i++)
            {
                Tags * tag = groupArr[i];
                if ([[@(_headerModel.internalBaseClassIdentifier) stringValue]
                     isEqualToString: tag.internalBaseClassIdentifier])
                {
                    [self showDel:YES];
                }
                
            }
            
        }
        
    }

    
}

@end
