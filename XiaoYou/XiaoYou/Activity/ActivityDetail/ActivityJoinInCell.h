//
//  ActivityJoinInCell.h
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    IS_TOPVIEW,
    NOT_TOPVIEW
} CELLTYPE;

@interface ActivityJoinInCell : UITableViewCell

+(ActivityJoinInCell*)cellWithTableView:(UITableView*)tableView cellType:(CELLTYPE)type;

-(void)setCellInfo;

@end
