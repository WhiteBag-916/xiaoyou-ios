//
//  YCommonPickerView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/10/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    PickerView_CalendarRemind,          //日程提醒
}PickerView_Type;

extern NSString *const kPickerViewCalendarRemind;

@interface YCommonPickerView : UIPickerView

- (instancetype)initWithFrame:(PickerView_Type)type;

- (NSDictionary *)getData;


@end
