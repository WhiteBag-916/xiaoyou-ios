//
//  Alert.m
//  YCPai
//
//  Created by mac on 15/4/30.
//  Copyright (c) 2015年 YCPai. All rights reserved.
//

#import "YAlertView.h"
#import "YString+Ext.h"


@interface YAlertView()
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* contentLabel;
@property (nonatomic, strong)UIButton* cancleButton;
@property (nonatomic, strong)UIButton* otherButton;
@property (nonatomic, strong)UIImageView* line;//一条线罢了
@property(nonatomic,assign) id <YAlertViewDelegate> delegate;
@property (nonatomic, weak)UIViewController *rootViewController;
@property (nonatomic, strong)UIView *mask;

@end

@implementation YAlertView
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content delegate:(id<YAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;
{
    if (self = [super initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 135, [UIScreen mainScreen].bounds.size.height / 2 - 175.f/2, 270, 175)]) {
        [self.layer setCornerRadius:10];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, 250, 21)];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [self.titleLabel setTextColor:[UIColor colorWithRed:80.f/255 green:80.f/255 blue:80.f/255 alpha:1]];
        [self.titleLabel setText:title];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 68, 250, 21)];
        [self.contentLabel setTextAlignment:NSTextAlignmentCenter];
        if ([content isValidPhoneNumber])
        {
            [self.contentLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
//            [self.contentLabel setTextColor:[UIColor colorWithRed:244.f/255 green:69.f/255 blue:60.f/255 alpha:1]];
        }
        else
        {
            [self.contentLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
//            [self.contentLabel setTextColor:[UIColor blackColor]];
        }
        [self.contentLabel setText:content];
        [self.contentLabel setTextColor:[UIColor colorWithRed:244.f/255 green:69.f/255 blue:60.f/255 alpha:1]];

        self.line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 125, 250, 1)];
        [self.line setBackgroundColor:[UIColor lightGrayColor]];
        
        if (nil == otherButtonTitle)
        {//只有一个按钮
            self.cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 125, 270, 50)];
            [self.cancleButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [self.cancleButton setTitleColor:[UIColor colorWithRed:244.f/255 green:69.f/255 blue:60.f/255 alpha:1] forState:UIControlStateNormal];
            [self.cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
            [self.cancleButton.layer setCornerRadius:10];
            [self addSubview:self.otherButton];
            [self addSubview:self.cancleButton];
        }
        else
        {//两个按钮
            self.cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 125, 135, 50)];
            [self.cancleButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [self.cancleButton setTitleColor:[UIColor colorWithRed:120.f/255 green:120.f/255 blue:120.f/255 alpha:1] forState:UIControlStateNormal];
            [self.cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
            [self.cancleButton addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchDown];
            [self.cancleButton addTarget:self action:@selector(unpressed:) forControlEvents:UIControlEventTouchDragExit];
            [self.cancleButton.layer setCornerRadius:10];

            self.otherButton = [[UIButton alloc] initWithFrame:CGRectMake(135, 125, 135, 50)];
            [self.otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
            [self.otherButton setTitleColor:[UIColor colorWithRed:244.f/255 green:69.f/255 blue:60.f/255 alpha:1] forState:UIControlStateNormal];
            [self.otherButton addTarget:self action:@selector(otherClick) forControlEvents:UIControlEventTouchUpInside];
            [self.otherButton addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchDown];
            [self.otherButton addTarget:self action:@selector(unpressed:) forControlEvents:UIControlEventTouchDragExit];
            [self.otherButton.layer setCornerRadius:10];

            [self addSubview:self.otherButton];
            [self addSubview:self.cancleButton];

        }
        
        
        [self setDelegate:delegate];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.line];
        
        return self;
    }
    return nil;
}
- (void)show:(UIViewController *)target;
{
    self.rootViewController = target;
    self.mask = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.mask setBackgroundColor:[UIColor blackColor]];
    [self.mask setAlpha:0.3];
    
    self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    [target.view addSubview:self];
    [target.view insertSubview:self.mask belowSubview:self];
}
- (void)cancle
{
    if (nil != self.delegate)
    {
        [self.delegate clickedButtonAtIndex:0 alertView:self];
    }
    [self.cancleButton setBackgroundColor:[UIColor whiteColor]];
    [self.layer setCornerRadius:10];
    [self.mask removeFromSuperview];
    [self removeFromSuperview];
}
- (void)otherClick
{
    if (nil != self.delegate)
    {
        [self.delegate clickedButtonAtIndex:1 alertView:self];
    }
    [self.otherButton setBackgroundColor:[UIColor whiteColor]];
    [self.layer setCornerRadius:10];

    [self.mask removeFromSuperview];
    [self removeFromSuperview];
}
- (void)pressed: (UIButton *)sender
{
    [sender setBackgroundColor:[UIColor colorWithRed:230.f/255 green:230.f/255 blue:230.f/255 alpha:1]];
    [self.layer setCornerRadius:10];
}
- (void)unpressed: (UIButton *)sender
{
    [sender setBackgroundColor:[UIColor whiteColor]];
    [self.layer setCornerRadius:10];

}

@end
