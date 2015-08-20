//
//  FeedImageGroup.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/15.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedImageGroup : UIView

- (id)initWithCamera;
- (void)updateWithImgs:(NSArray *)smallPics bigPics:(NSArray *)bigPics;
@end
