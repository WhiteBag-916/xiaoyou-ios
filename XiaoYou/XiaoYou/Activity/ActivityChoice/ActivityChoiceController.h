//
//  ActivityChoiceController.h
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YViewController.h"
#import "AvailableViewController.h"
#import "AvailableSimpleViewController.h"

typedef enum : NSUInteger {
    ACTIVITY_CHOICE_TYPE,
    CLASS_CHOICE_TYPE,
} CHOICE_TYPE;

@interface ActivityChoiceController : YViewController

@property(nonatomic,strong)AvailableViewController * activityViewController;
@property(nonatomic,strong)AvailableSimpleViewController * classViewController;

-(instancetype)initWithType:(CHOICE_TYPE) type;

@end
