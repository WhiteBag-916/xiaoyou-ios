//
//  FunnyDetailCell.h
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailModel.h"
#import "YTableViewCell.h"


typedef enum : NSUInteger {
    SHORT_BRIEF,
    DETAIL_INFO
} TOPVIEWTYPE;

@interface ActivityDetailCell : YTableViewCell

-(void)setData:(ActivityDetailModel*)model;

@end
