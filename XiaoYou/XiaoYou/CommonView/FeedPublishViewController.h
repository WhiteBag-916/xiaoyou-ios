//
//  FeedPublishViewController.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YViewController.h"
#import "YYTextParser.h"

@interface FeedPublishViewController : YViewController

@end

@interface YYTextTopicAndAtBindingParser :NSObject <YYTextParser>
@property (nonatomic, strong) NSRegularExpression *regex;
@end