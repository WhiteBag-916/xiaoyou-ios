//
//  TypeDetailCollectionView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/14.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TypeDetailCollectionView.h"
#import "TypeDetailCollectionViewCell.h"
#import "ActivityReleaseDataManager.h"

@interface TypeDetailCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

@property(nonatomic,strong)ActivityReleaseDataManager * dataManager;
//@property(nonatomic,strong)NSMutableArray * typeArr;
@property(nonatomic,strong)NSString * typeStr;

@end

@implementation TypeDetailCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        self.pagingEnabled = NO;
        [self registerClass:[TypeDetailCollectionViewCell class] forCellWithReuseIdentifier:kTypeDetailCollectionViewCell];
        _dataSouceArr = [[NSMutableArray alloc] initWithArray:@[[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"竞技·比赛",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"讲座·培训",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"实习·招聘",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"运动·户外",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"义工·支教",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"社交·沙龙",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"演出·晚会",@"isChoice":@NO}],[NSMutableDictionary dictionaryWithDictionary:@{@"type":@"综合·其他",@"isChoice":@YES}]]];
        
        _dataManager = [ActivityReleaseDataManager shareActivityReleaseDataManager];
        _dataManager.ActivityTypeStr = @"综合·其他";
//        _typeArr = [[NSMutableArray alloc] init];
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
    CGSize size = {SCALE_NUM(90),SCALE_NUM(28)};
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = @{@"position":@5};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
    
    //判断是否被选中
    if (![_dataSouceArr[indexPath.row][@"isChoice"] boolValue])
    {
        for (int i = 0; i < _dataSouceArr.count ;i++)
        {
            if (i == indexPath.row)
            {
                [_dataSouceArr[indexPath.row] setObject:@YES forKey:@"isChoice"];
            }
            else
            {
                [_dataSouceArr[i] setObject:@NO forKey:@"isChoice"];
            }
        }
    }
    /**
     多选情况
     **/
//    if ([_dataSouceArr[indexPath.row][@"isChoice"] boolValue] == YES)
//    {
//        [_dataSouceArr[indexPath.row] setObject:@NO forKey:@"isChoice"];
//    }
//    else
//    {
//        [_dataSouceArr[indexPath.row] setObject:@YES forKey:@"isChoice"];
//    }
    
    //根据选中情况提取数据
    for (int i = 0; i<_dataSouceArr.count; i++)
    {
        if ([_dataSouceArr[indexPath.row][@"isChoice"] boolValue] == YES) {

            _typeStr = _dataSouceArr[indexPath.row][@"type"];
            
        }
        
        /**
         多选情况
         **/
//        if ([_dataSouceArr[indexPath.row][@"isChoice"] boolValue] == YES) {
//            
//            NSString * tempStr = _dataSouceArr[indexPath.row][@"type"];
//            if (![_typeArr containsObject:tempStr])
//            {
//                [_typeArr addObject:tempStr];
//            }
//        }
//        else
//        {
//            NSString * tempStr = _dataSouceArr[indexPath.row][@"type"];
//            if ([_typeArr containsObject:tempStr])
//            {
//                [_typeArr removeObject:tempStr];
//            }
//        }
    }
    /**
     多选情况
     **/
    _dataManager.ActivityTypeStr = _typeStr;
    
    [_dataManager isEnableToRelease];
    
    [self reloadData];
}

@end
