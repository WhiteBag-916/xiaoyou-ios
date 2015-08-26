//
//  GroupInfoDetailCollectionView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDetail.h"

@interface GroupInfoDetailCollectionView : UICollectionView

-(void)refreshTableView:(GroupDetail *) model;

@end
