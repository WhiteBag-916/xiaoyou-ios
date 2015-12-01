//
//  YTextView.h
//  YFramework
//
//  Created by mac on 15/4/30.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DEFAULT_NONTYPE,
    DISANBLE_PASTE
} TEXTVIEWTYPE;


@interface YTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;
@property (nonatomic,assign)float lineSpacing;

-(void)textChanged:(NSNotification*)notification;

-(void)setCustomAttributedText:(NSAttributedString *)attributedText;

-(instancetype)initWithTextViewType:(TEXTVIEWTYPE)type;

@property (nonatomic, assign) TEXTVIEWTYPE type;

@end
