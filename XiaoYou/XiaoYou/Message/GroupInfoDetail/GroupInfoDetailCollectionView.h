//
//  GroupInfoDetailCollectionView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDetail.h"
#import "XYGroupInfoDetailViewController.h"

@interface GroupInfoDetailCollectionView : UICollectionView

@property(nonatomic,weak)XYGroupInfoDetailViewController * myController;

-(void)refreshTableView:(GroupDetail *) model;

@end
