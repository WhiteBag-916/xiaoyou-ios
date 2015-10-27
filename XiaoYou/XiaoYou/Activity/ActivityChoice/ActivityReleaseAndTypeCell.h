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
#import "GetFilterConditionsModel.h"
#import "Tags.h"

extern NSString *const kActivityReleaseAndTypeCell;

@protocol ActivityReleaseAndTypeCellDelegate <NSObject>

-(void)didSelectRow:(Tags *) tag andType:(NSString *) type;

@end

@interface ActivityReleaseAndTypeCell : YTableViewCell

@property (nonatomic,weak)id<ActivityReleaseAndTypeCellDelegate>delegate;
@property (nonatomic,assign)NSInteger myType;

-(void)setCellType:(GetFilterConditionsModel *) model;

@end
