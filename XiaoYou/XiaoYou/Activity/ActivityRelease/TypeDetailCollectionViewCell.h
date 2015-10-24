//
//  TypeDetailCollectionViewCell.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/14.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeDetailCollectionView.h"

extern NSString *const kTypeDetailCollectionViewCell;

@interface TypeDetailCollectionViewCell : UICollectionViewCell

-(void)setCellInfo:(NSDictionary *) dic;

@end
