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
@property (nonatomic,strong)NSMutableArray * dataSourceArr;
@property (nonatomic,strong)NSString * studyRoomDefautStr;//自习室默认选中值

-(instancetype)initWithType:(CHOICE_TYPE) type;

@end
