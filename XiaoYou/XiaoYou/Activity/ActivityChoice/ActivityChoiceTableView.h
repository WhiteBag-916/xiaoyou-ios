//
//  ActivityChoiceTableView.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "ActivityChoiceController.h"

@interface ActivityChoiceTableView : YTableView

@property (nonatomic,strong)ActivityChoiceController * myController;
@property (nonatomic,assign)NSInteger myType;

@end
