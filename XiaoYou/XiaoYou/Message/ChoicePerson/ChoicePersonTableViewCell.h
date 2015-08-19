//
//  ChoicePersonTableViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kChoicePersonTableViewCell;

@interface ChoicePersonTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView * backView;

-(void)setCellInfo:(NSDictionary *) dic;

@end
