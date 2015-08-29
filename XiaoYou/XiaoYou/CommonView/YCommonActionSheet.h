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
    YCommonActionSheetItemTypeShareFeed,
    YCommonActionSheetItemTypeShareOrganization,
    YCommonActionSheetItemTypeSharePerson,
    YCommonActionSheetItemTypeSwitch,
    YCommonActionSheetItemTypeCenterCommon,
    YCommonActionSheetItemTypeReport,
};

typedef NS_ENUM(NSInteger, YShareType) {
    YShareTypeToWechatSession=100,   //微信好友
    YShareTypeToWechatTimeline,     //微信朋友圈
};

typedef void(^ActionSheetItemBlock)(NSInteger checkNum);

@interface YActionSheetItem : NSObject
+(instancetype)itemWithTitle:(NSString *)title type:(YCommonActionItemSheetType)type block:(ActionSheetItemBlock)block;
/**
 *  @author 李思良, 15-08-19
 *
 *  @brief  特定类型的item调用，不需要block回调，由自身发出通知执行
 *
 *  @param type      目前支持分享，举报待定
 *  @param title     item标题
 *  @param extraData 需要的参数字典,share类型需要提供content键
 *
 *  @return item
 */
+ (instancetype)itemWithType:(YCommonActionItemSheetType)type title:(NSString *)title extraData:(NSDictionary *)extraData;
//传开关
+(instancetype)itemWithTitle:(NSString *)title type:(YCommonActionItemSheetType)type isGroup:(BOOL)isGroup open:(BOOL)isOpen extraData:(NSDictionary *)extraData;
@end

@interface YCommonActionSheet : YView
- (instancetype)initWithType:(NSArray *)items title:(NSString *)title;
- (void)show;
@end