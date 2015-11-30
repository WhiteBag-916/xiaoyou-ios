//
//  YTextView.m
//  YFramework
//
//  Created by mac on 15/4/30.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YTextView.h"
#import "YLabel+Ext.h"

@interface YTextView()
@property (nonatomic, retain) UILabel *placeHolderLabel;

@end

@implementation YTextView

CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.25;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if __has_feature(objc_arc)
#else
    [_placeHolderLabel release]; _placeHolderLabel = nil;
    [_placeholderColor release]; _placeholderColor = nil;
    [_placeholder release]; _placeholder = nil;
    [super dealloc];
#endif
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    
    _lineSpacing = 0;
    
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)init {
    self = [super init];
    if (self) {
        _lineSpacing = 0;
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}


- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if([[self text] length] == 0)
        {
            [[self viewWithTag:999] setAlpha:1];
        }
        else
        {
            [[self viewWithTag:999] setAlpha:0];
        }
    }];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if (_placeHolderLabel == nil )
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        [_placeHolderLabel setText:self.placeholder lineSpacing:_lineSpacing];
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}




-(void)setCustomAttributedText:(NSAttributedString *)attributedText
{
    //if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
    attributedText = [self handleLink:attributedText];
    //}
    self.attributedText = attributedText;
    
    //R106 G140 B179 A100
    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:(106)/255.0 green:(140)/255.0 blue:(179)/255.0 alpha:(1)],
                                     NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    self.linkTextAttributes  = linkAttributes;
}


- (NSMutableAttributedString*)handleLink:(NSAttributedString*)contentAttrString
{
    NSMutableAttributedString *ret = [[NSMutableAttributedString alloc]initWithAttributedString:contentAttrString];
    NSString *string = [contentAttrString string];
    NSError *error;
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex =[NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    for(NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [string substringWithRange:match.range];
        NSRange range = [string rangeOfString:substringForMatch];
//        	[ret removeAttribute:NSFontAttributeName range:range];
//        [ret removeAttribute:NSParagraphStyleAttributeName range:range];
//        [ret removeAttribute:NSLinkAttributeName range:range];
        [ret addAttribute:NSLinkAttributeName value:substringForMatch range:range];
    }
    return ret;
}


/* 选中文字后是否能够呼出菜单 */
- (BOOL)canBecameFirstResponder {
    return YES;
}

/* 选中文字后的菜单响应的选项 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:)) { // 菜单不能响应copy项
        return YES;
    }
    else if (action == @selector(selectAll:)) { // 菜单不能响应select all项
        return YES;
    }
    else if (action == @selector(paste:)) {
        return NO;
    }
    else if (action == @selector(cut:)) {
        return NO;
    }
    else if (action == @selector(select:)) {
        return NO;
    }
    else if (action == @selector(delete:)) {
        return NO;
    }
    
    // 事实上一个return NO就可以将系统的所有菜单项全部关闭了
    return NO;
}

@end
