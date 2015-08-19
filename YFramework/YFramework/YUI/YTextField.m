//
//  YTextField.m
//  YFramework
//
//  Created by 熊宸 on 15/8/19.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YTextField.h"

@implementation YTextField

- (void)registerChanged:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventEditingChanged];
}

@end
