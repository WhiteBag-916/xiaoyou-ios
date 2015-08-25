//
//  YFlatSwitchView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YView.h"

typedef void(^ChangeSwitchState)(int index);

@interface YFlatSwitchView : YView

- (instancetype)initWithText:(NSArray *)textArray;

- (void)changedState:(ChangeSwitchState)state;

@end
