//
//  ChooseWeekView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YCommonDialogView.h"

typedef void(^ChooseWeekBlock)(NSInteger checkNum);

@interface ChooseWeekView : YCommonDialogView

- (id)initWithBlock:(NSInteger)selectNum weekNum:(NSInteger)weekNum nowWeek:(NSInteger)nowWeek block:(ChooseWeekBlock)block;

@end
