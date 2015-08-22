//
//  MessageTableViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

extern NSString *const kMessageTableViewCell;

@interface MessageTableViewCell : YTableViewCell

@property(nonatomic,strong)NSString * studentNum;

-(void)setCellInfo:(id) dic;

@end
