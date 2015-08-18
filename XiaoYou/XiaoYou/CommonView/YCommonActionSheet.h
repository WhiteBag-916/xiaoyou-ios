//
//  YCommonActionSheet.h
//  YCPai
//
//  Created by abc on 15/6/18.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YView.h"

typedef NS_ENUM(NSInteger, YCommonActionItemSheetType) {
    YCommonActionSheetItemTypeCommon,
    YCommonActionSheetItemTypeShare,
    YCommonActionSheetItemTypeSwitch,
};

typedef void(^ActionSheetItemBlock)(NSInteger checkNum);

@interface YActionSheetItem : NSObject
+(instancetype)itemWithTitle:(NSString *)title type:(YCommonActionItemSheetType)type block:(ActionSheetItemBlock)block;
//传开关
+(instancetype)itemWithTitle:(NSString *)title type:(YCommonActionItemSheetType)type open:(BOOL)isOpen block:(ActionSheetItemBlock)block;
@end

@interface YCommonActionSheet : YView
- (instancetype)initWithType:(NSArray *)items title:(NSString *)title;
- (void)show;
@end