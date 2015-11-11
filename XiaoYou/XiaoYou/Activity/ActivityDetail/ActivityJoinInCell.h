//
//  ActivityJoinInCell.h
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Author.h"
#import "YTableViewCell.h"

typedef enum : NSUInteger {
    IS_TOPVIEW,
    NOT_TOPVIEW
} CELLTYPE;

@interface ActivityJoinInCell : YTableViewCell

-(void)setData:(Author*)joinModel;

@property (nonatomic,assign) CELLTYPE type;

@end
