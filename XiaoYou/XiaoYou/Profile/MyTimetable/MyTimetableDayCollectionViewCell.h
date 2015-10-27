//
//  MyTimetableDayCollectionViewCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kMyTimetableDayCollectionViewCell;

@interface MyTimetableDayCollectionViewCell : UICollectionViewCell

- (void)initData:(NSString *)numText timeText:(NSString *)timeText showRightLine:(BOOL)showRightLine showBottomLine:(BOOL)showBottomLine;

@end
