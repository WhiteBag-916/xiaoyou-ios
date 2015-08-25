//
//  CommonSwitchView.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "CommonSwitchView.h"
#import "YUtils+Component.h"

@interface CommonSwitchView ()

@property (strong, nonatomic) UIImageView *redBgImageView;//红色背景
@property (assign, nonatomic) CommonSwitchType switchType;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UILabel *notificationLabel;
@property (copy, nonatomic) ChangeCommonSwitchType changeTypeBlock;

@end

@implementation CommonSwitchView

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray
{
    if (self = [super initWithFrame:frame])
    {
        //背景
        UIImageView *bgImageView = [YUtils initImageView:[UIImage imageNamed:@"message_tab_background"] frame:self.bounds];
        [self addSubview:bgImageView];
        
        //红色背景
        _redBgImageView = [YUtils initImageView:[UIImage imageNamed:@"message_tab_green"] frame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        [self addSubview:_redBgImageView];
        
        //label
        _messageLabel = [YUtils initLabel:CONTENT_FONT(frame.size.height/2) color:[UIColor whiteColor] text:[textArray objectAtIndex:CommonSwitchTypeFir] frame:CGRectMake(0, 0, frame.size.width/2, frame.size.height) alignment:NSTextAlignmentCenter];
        [self addSubview:_messageLabel];
        
        _notificationLabel = [YUtils initLabel:CONTENT_FONT(frame.size.height/2) color:KCOLORGREEN_009688 text:[textArray objectAtIndex:CommonSwitchTypeSec] frame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height) alignment:NSTextAlignmentCenter];
        [self addSubview:_notificationLabel];
        
        _switchType = CommonSwitchTypeFir;
    }
    
    return self;
}

- (void)changedType:(ChangeCommonSwitchType)type
{
    _changeTypeBlock = type;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    BOOL needChange = NO;
    
    //一半
    if (touchPoint.x < self.width/2)
    {
        //左边
        if (_switchType != CommonSwitchTypeFir)
        {
            _switchType = CommonSwitchTypeFir;
            needChange = YES;
        }
    }
    else
    {
        //右边
        if (_switchType != CommonSwitchTypeSec)
        {
            _switchType = CommonSwitchTypeSec;
            needChange = YES;
        }
    }
    
    if (needChange)
    {
        //移动
        [UIView animateWithDuration:0.25 animations:^{
            if (CommonSwitchTypeFir == _switchType)
            {
                _redBgImageView.originX = 0;
                
                _messageLabel.textColor = [UIColor whiteColor];
                _notificationLabel.textColor = KCOLORGREEN_009688;
            }
            else
            {
                _redBgImageView.rightX = self.width;
                
                _messageLabel.textColor = KCOLORGREEN_009688;
                _notificationLabel.textColor = [UIColor whiteColor];
            }
        }];
        
        _changeTypeBlock(_switchType);
    }
    
}

@end
