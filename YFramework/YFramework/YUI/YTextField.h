//
//  YTextField.h
//  YFramework
//
//  Created by 熊宸 on 15/8/19.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTextField : UITextField

- (void)registerChanged:(id)target action:(SEL)action;

@end
