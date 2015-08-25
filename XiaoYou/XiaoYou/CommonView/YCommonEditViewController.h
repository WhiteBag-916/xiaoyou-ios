//
//  YCommonEditViewController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"

typedef NS_ENUM(NSInteger, YCommonEditType) {
    /**
     *  @author 李思良, 15-08-22
     *
     *  @brief  编辑态度
     */
    YCommonEditAttitude,
    /**
     *  @author 李思良, 15-08-25
     *
     *  @brief  添加好友
     */
    YCommonEditAddFriend,
};

@interface YCommonEditViewController : YViewController

- (id)initWithType:(YCommonEditType)type preText:(NSString *)preText;

@end
