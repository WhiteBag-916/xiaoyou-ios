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

@property(nonatomic,strong)NSDictionary * studentDic;

-(void)setCellInfo:(id) dic;

@end
