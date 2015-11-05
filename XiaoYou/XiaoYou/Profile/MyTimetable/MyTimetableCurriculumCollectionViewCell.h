//
//  MyTimetableCurriculumCollectionViewCell.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FindMyCourseViewModel;

extern NSString *const kMyTimetableCurriculumCollectionViewCell;

@interface MyTimetableCurriculumCollectionViewCell : UICollectionViewCell

- (void)initData:(FindMyCourseViewModel *)model;

@end
