//
//  ChoicePersonTableView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@interface ChoicePersonTableView : YTableView

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

-(void)refreshTableView:(NSMutableArray *) dataSouceArr;

@end
