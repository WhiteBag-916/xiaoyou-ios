//
//  ContactsInfoDetailTableView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYContactsInfoDetailViewController.h"
#import "YTableView.h"
#import "ProfileInfo.h"

@interface ContactsInfoDetailTableView : YTableView

@property(nonatomic,weak)XYContactsInfoDetailViewController * myController;

-(void)refreshTableView:(ProfileInfo *) model;

@end
