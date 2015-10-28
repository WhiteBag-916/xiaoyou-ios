//
//  AvailableCell.h
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityInfoModel.h"
#import "YTableViewCell.h"
@interface AvailableCell : YTableViewCell

-(void)setData:(ActivityInfoModel*)model;

@end
