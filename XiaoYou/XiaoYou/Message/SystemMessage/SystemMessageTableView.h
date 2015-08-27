//
//  SystemMessageTableView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "XYSystemMessageViewController.h"

@interface SystemMessageTableView : YTableView

@property(nonatomic,weak)XYSystemMessageViewController * myController;
-(void)refreshTableView:(NSMutableArray *) dataSouceArr;

@end
