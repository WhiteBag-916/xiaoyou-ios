//
//  NameAndPlaceCollectionViewCell.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityBaseCollectionViewCell.h"
#import "ActivityReleaseCollectionView.h"

extern NSString *const kNameCollectionViewCell;

@interface NameCollectionViewCell : ActivityBaseCollectionViewCell

@property (nonatomic,weak)ActivityReleaseCollectionView * myCollectionView;

@end
