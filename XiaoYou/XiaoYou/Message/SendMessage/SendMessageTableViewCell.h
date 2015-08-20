//
//  SendMessageTableViewCell.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kSendMessageTableViewCell;

@interface SendMessageTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * infoLabel;

-(void)setCellInfo:(NSString *) text;

@end
