//
//  SendMessageTableViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableViewCell.h"

extern NSString *const kSendMessageTableViewCell;

@interface SendMessageTableViewCell : YTableViewCell

@property(nonatomic,strong)UILabel * infoLabel;

-(void)setCellInfo:(NSString *) text;

@end
