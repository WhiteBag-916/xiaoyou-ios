//
//  GroupInfoCollectionViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDetail.h"
#import "GroupInfoDetailCollectionView.h"

extern NSString *const kGroupInfoCollectionViewCell;

@protocol GroupInfoCollectionViewCellDelegate <NSObject>

@optional
- (void)delCell:(NSString *)uid;
- (void)longPressCell;

@end

@interface GroupInfoCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak) id<GroupInfoCollectionViewCellDelegate> delegate;
@property (nonatomic,strong)NSDictionary * modelDic;

-(void)setCellInfo:(NSDictionary *) groupDic;

@end
