//
//  YAlertView+Ext.m
//  YFramework
//
//  Created by 熊宸 on 15/4/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YAlertView+Ext.h"

#define kOkButtonDefaultTitle     @"确定"
#define kCancelButtonDefaultTitle @"取消"

@implementation UIAlertView(Ext)

+ (void)showWithMessage:(NSString *)message {
    [self showWithTitle:nil message:message];
    return;
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message {
    [self showWithTitle:title message:message delegate:nil];
    return;
}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate {
    [self showWithTitle:title
                message:message
               delegate:delegate
               okButton:kOkButtonDefaultTitle
           cancelButton:kCancelButtonDefaultTitle];
    
    return;
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
             okButton:(NSString *)okButtonTitle
         cancelButton:(NSString *)cancelButtonTitle {
    [self showWithTitle:title
                message:message
               delegate:nil
               okButton:okButtonTitle
           cancelButton:cancelButtonTitle];
    return;
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
             delegate:(id)delegate
             okButton:(NSString *)okButtonTitle
         cancelButton:(NSString *)cancelButtonTitle {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:okButtonTitle, nil];
    [alertView show];
    return;
}

@end
