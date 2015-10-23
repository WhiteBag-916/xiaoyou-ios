//
//  AvailableCell.h
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModelTest.h"

@interface AvailableCell : UITableViewCell

+(AvailableCell*)cellWithTableView:(UITableView*)tableView;

-(void)setData:(ActivityModelTest*)model;

@end
