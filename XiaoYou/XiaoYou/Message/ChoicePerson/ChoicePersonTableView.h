//
//  ChoicePersonTableView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "XYChoicePersonViewController.h"

@interface ChoicePersonTableView : YTableView

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

@property(nonatomic,weak)XYChoicePersonViewController * superVC;

-(void)refreshTableView:(NSMutableArray *) dataSouceArr;

@end
