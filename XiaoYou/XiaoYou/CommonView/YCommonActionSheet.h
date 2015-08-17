//
//  YCommonActionSheet.h
//  YCPai
//
//  Created by abc on 15/6/18.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YView.h"

typedef NS_ENUM(NSInteger, YCommonActionSheetType) {
    YCommonActionSheetTypeCommon,
    YCommonActionSheetTypeShare,
};

@interface YActionSheetItem : NSObject
+(instancetype)itemWithTitle:(NSString *)title block:(void(^)(void))block;
+(instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image block:(void(^)(void))block;
@end

@interface YCommonActionSheet : YView
- (instancetype)initWithType:(YCommonActionSheetType)type items:(NSArray *)items title:(NSString *)title;
- (void)show;
@end