//
//  ActivityReleaseAndTypeCell.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityChoiceController.h"

extern NSString *const kActivityReleaseAndTypeCell;

@interface ActivityReleaseAndTypeCell : UITableViewCell

@property (nonatomic,assign)NSInteger myType;

-(void)setCellType:(NSInteger) num;

@end
