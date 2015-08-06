//
//  CommonSwitchView.h
//  XiaoYou
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YView.h"

typedef NS_ENUM(NSUInteger, CommonSwitchType) {
    CommonSwitchTypeFir = 0,
    CommonSwitchTypeSec
};

typedef void(^ChangeCommonSwitchType)(CommonSwitchType type);

@interface CommonSwitchView : YView

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray;

- (void)changedType:(ChangeCommonSwitchType)type;

@end
