//
//  FunnyDetailCell.h
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@interface ActivityDetailCell : UITableViewCell

+(ActivityDetailCell*)cellWithTableView:(UITableView*)tableView;

-(void)setData:(ActivityModel*)model;

@end
