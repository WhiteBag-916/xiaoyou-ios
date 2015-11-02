//
//  MainAvailableTimeAction.h
//  Component
//
//  Created by sheng on 15/11/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHTTPRequestAction.h"

@interface MainAvailableTimeAction : YHTTPRequestAction<YAction>

@property (nonatomic, strong)   NSString *userID;
@property (nonatomic, assign)   NSInteger limitStart;
@property (nonatomic, assign)   NSInteger limitEnd;
@property (nonatomic, copy)     NSString *name;
@property (nonatomic, assign)   BOOL    isGetScheduling;


//types	活动类型集合	String	否	多个类型","分割，类型详见附录9
//createUserSource	活动创建的用户来源	String	否
//datePeriod	活动日期范围	String	否
//limitStart	活动开始行数	Integer	否
//limitEnd	活动结束行数	Integer	否
//name	活动名称	String	否
//isGetScheduling
@end
