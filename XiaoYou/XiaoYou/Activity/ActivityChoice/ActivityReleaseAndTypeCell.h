//
//  ActivityReleaseAndTypeCell.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityChoiceController.h"
#import "YTableViewCell.h"

extern NSString *const kActivityReleaseAndTypeCell;

@interface ActivityReleaseAndTypeCell : YTableViewCell

@property (nonatomic,assign)NSInteger myType;

-(void)setCellType:(NSInteger) num;

@end
