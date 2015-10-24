//
//  ActivityReleaseCollectionView.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityReleaseController.h"

typedef enum : NSUInteger {
    POINT1 = 1,
    POINT2 = 2,
    POINT3 = 3,
    POINT4 = 4,
    POINT5 = 5,
    POINT6 = 6,
} MyPointNum;

@interface ActivityReleaseCollectionView : UICollectionView

@property (nonatomic,weak)ActivityReleaseController * myController;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout andIsIdentity:(BOOL) isIdentity;

@end
