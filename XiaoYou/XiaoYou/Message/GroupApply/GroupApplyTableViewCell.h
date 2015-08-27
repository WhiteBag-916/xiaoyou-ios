//
//  GroupApplyTableViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

@class ApplicantList;

typedef enum : NSUInteger {
    BIG_BUTTON,
    REFUSE_BUTTON,
    PASS_BUTTON,
    SEND_BUTTON,
} BOTTOM_BUTTON_TYPE;

extern NSString *const kGroupApplyTableViewCell;

@interface GroupApplyTableViewCell : YTableViewCell

-(void)setCellInfo:(ApplicantList *)applicantList;

@end
