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
#import "ActivityManager.h"
#import "Tags.h"

@interface TypeDetailCollectionView ()
<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

@property(nonatomic,strong)ActivityReleaseDataManager * dataManager;
@property(nonatomic,strong)NSString * typeStr;

@end

@implementation TypeDetailCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        self.pagingEnabled = NO;
        [self registerClass:[TypeDetailCollectionViewCell class]
 forCellWithReuseIdentifier:kTypeDetailCollectionViewCell];
        
        _dataSouceArr = [[NSMutableArray alloc] init];
        [[ActivityManager sharedInstance] findActivityTypes:^(YActionMessage *message) {
            
            [self transformData:message.object];
            
        }];
        
        _dataManager = [ActivityReleaseDataManager shareActivityReleaseDataManager];
        
    }
    return self;
}

-(void)transformData:(NSArray *) dataArr
{
    NSMutableArray * temepArr = [[NSMutableArray alloc] initWithArray:dataArr];
    for (int i = 0; i < temepArr.count; i++)
    {
        Tags * tag = temepArr[i];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]
                                     initWithDictionary:[tag dictionaryRepresentation]];
        if (i == temepArr.count - 1)
        {
            [dic setObject:@YES forKey:@"isChoice"];
            _dataManager.ActivityTypeStr = dic[@"code"];
            [self reloadData];
        }
        else
        {
            [dic setObject:@NO forKey:@"isChoice"];
        }
        [_dataSouceArr addObject:dic];
    }
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
    TypeDetailCollectionViewCell * cell = [collectionView
                                           dequeueReusableCellWithReuseIdentifier:kTypeDetailCollectionViewCell
                                           forIndexPath:indexPath];
    [cell setCellInfo:_dataSouceArr[indexPath.row]];
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = {SCALE_NUM(90),SCALE_NUM(28)};
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = @{@"position":@5};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:KNotification_Activity_Release_ScrollTo
     object:dic];
    
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

            self.typeStr = _dataSouceArr[indexPath.row][@"code"];
            
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
