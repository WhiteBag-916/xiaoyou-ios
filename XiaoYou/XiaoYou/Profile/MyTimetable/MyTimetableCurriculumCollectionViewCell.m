//
//  MyTimetableCurriculumCollectionViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/27.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "MyTimetableCurriculumCollectionViewCell.h"

NSString *const kMyTimetableCurriculumCollectionViewCell = @"MyTimetableCurriculumCollectionViewCellId";

@interface MyTimetableCurriculumCollectionViewCell ()

@end

@implementation MyTimetableCurriculumCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

@end
