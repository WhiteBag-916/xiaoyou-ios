//
//  YTableView.m
//  YFramework
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTableView.h"
#import "MJRefresh.h"

@implementation YTableView

- (instancetype)init
{
    if (self = [super init])
    {
        if ([self showHeaderRefresh])
        {
            
        }
    }
    
    return self;
}

#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return NO;
}

- (BOOL)showFooterRefresh
{
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
