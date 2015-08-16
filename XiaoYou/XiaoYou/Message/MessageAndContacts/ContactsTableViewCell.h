//
//  ContactsTableViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kContactsTableViewCell;

@interface ContactsTableViewCell : UITableViewCell

@property(nonatomic,strong)NSString * linkStudentNo;

-(void)setCellInfo:(NSDictionary *) dic;

@end
