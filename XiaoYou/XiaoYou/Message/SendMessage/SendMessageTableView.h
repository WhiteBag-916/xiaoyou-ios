//
//  SendMessageTableView.h
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"

@protocol SendMessageTableViewDelegate <NSObject>

-(void)didSelectCell:(NSString *) text;

@end

@interface SendMessageTableView : YTableView

@property(nonatomic,weak)id<SendMessageTableViewDelegate>myDelegate;

@end
