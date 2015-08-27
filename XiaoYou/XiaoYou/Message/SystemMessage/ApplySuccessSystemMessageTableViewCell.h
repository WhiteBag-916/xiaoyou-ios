//
//  ApplySuccessSystemMessageTableViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

extern NSString *const kApplySuccessSystemMessageTableViewCell;

@protocol ApplySuccessSystemMessageTableViewCellDelegat <NSObject>

-(void)turnToGroupChat:(NSDictionary *) groupDic;

@end

@interface ApplySuccessSystemMessageTableViewCell : YTableViewCell

@property (nonatomic,weak)id<ApplySuccessSystemMessageTableViewCellDelegat>delegat;

-(void)setCellInfo:(NSDictionary *) dic;


@end
