//
//  MessageTableView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "XYMessageAndContactsViewController.h"

@interface MessageTableView : YTableView

@property(nonatomic,strong)XYMessageAndContactsViewController * myController;

-(void)refreshTableView:(NSMutableArray *) dataSouceArr;

@end
