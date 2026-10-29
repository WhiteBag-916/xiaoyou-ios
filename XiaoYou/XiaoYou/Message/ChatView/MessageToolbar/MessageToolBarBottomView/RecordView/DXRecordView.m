/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "DXRecordView.h"
#import "EMCDDeviceManager.h"
@interface DXRecordView ()
{
    NSTimer *_timer;
    // 显示动画的ImageView
    UIImageView *_recordAnimationView;
    // 提示文字
    UILabel *_textLabel;
}

@end

@implementation DXRecordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
//        bgView.backgroundColor = [UIColor grayColor];
//        bgView.layer.cornerRadius = 80;
//        bgView.layer.masksToBounds = YES;
//        bgView.clipsToBounds = YES;
//        bgView.alpha = 0.6;
        UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        bgImageView.layer.cornerRadius = 80;
//        bgImageView.layer.masksToBounds = YES;
//        bgImageView.clipsToBounds = YES;
//        bgImageView.alpha = 0.8;
        bgImageView.image = [UIImage imageNamed:@"chat_voice_bg"];
        [self addSubview:bgImageView];
        
        _recordAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake((bgImageView.width-34)/2, 22, 34, 10)];
        NSMutableArray *imageArr = [NSMutableArray array];
        for (int i=1;i<=9;++i) {
            NSString *imageStr = [NSString stringWithFormat:@"sound_%d", i];
            [imageArr addObject:[UIImage imageNamed:imageStr]];
        }
//        _recordAnimationView.image = [UIImage imageNamed:@"VoiceSearchFeedback000"];
        _recordAnimationView.animationImages = [NSArray arrayWithArray:imageArr];
        [self addSubview:_recordAnimationView];
        
        
//        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,
//                                                               self.bounds.size.height - 30,
//                                                               self.bounds.size.width - 10,
//                                                               25)];
        
//        _textLabel.textAlignment = NSTextAlignmentCenter;
//        _textLabel.backgroundColor = [UIColor clearColor];
//        _textLabel.text = NSLocalizedString(@"上滑取消发送", @"Fingers up slide, cancel sending");
//        [self addSubview:_textLabel];
//        _textLabel.font = [UIFont systemFontOfSize:13];
//        _textLabel.textColor = [UIColor whiteColor];
//        _textLabel.layer.cornerRadius = 5;
//        _textLabel.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
//        _textLabel.layer.masksToBounds = YES;
    }
    return self;
}

// 录音按钮按下
-(void)recordButtonTouchDown
{
    // 需要根据声音大小切换recordView动画
//    _textLabel.text = NSLocalizedString(@"上滑取消发送", @"Fingers up slide, cancel sending");
//    _textLabel.backgroundColor = [UIColor clearColor];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05
//                                              target:self
//                                            selector:@selector(setVoiceImage)
//                                            userInfo:nil
//                                             repeats:YES];
    [_recordAnimationView startAnimating];
}
// 手指在录音按钮内部时离开
-(void)recordButtonTouchUpInside
{
    [_timer invalidate];
    [_recordAnimationView stopAnimating];
}
// 手指在录音按钮外部时离开
-(void)recordButtonTouchUpOutside
{
    [_timer invalidate];
    [_recordAnimationView stopAnimating];
}
// 手指移动到录音按钮内部
-(void)recordButtonDragInside
{
//    _textLabel.text = NSLocalizedString(@"上滑取消发送", @"Fingers up slide, cancel sending");
//    _textLabel.backgroundColor = [UIColor clearColor];
}

// 手指移动到录音按钮外部
-(void)recordButtonDragOutside
{
//    _textLabel.text = NSLocalizedString(@"松开取消发送", @"loosen the fingers, to cancel sending");
//    _textLabel.backgroundColor = KCOLOR_009688;
}

-(void)setVoiceImage {
    _recordAnimationView.image = [UIImage imageNamed:@"VoiceSearchFeedback000"];
    double voiceSound = 0;
    voiceSound = [[EMCDDeviceManager sharedInstance] emPeekRecorderVoiceMeter];

    if (0 < voiceSound <= 0.05) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback000"]];
    }else if (0.05<voiceSound<=0.20) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback001"]];
    }else if (0.20<voiceSound<=0.40) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback002"]];
    }else if (0.40<voiceSound<=0.60) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback003"]];
    }else if (0.60<voiceSound<=0.80) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback004"]];
    }else if (0.80<voiceSound<=0.95) {
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback005"]];
    }else {
        
        [_recordAnimationView setImage:[UIImage imageNamed:@"VoiceSearchFeedback006"]];
    }
}
@end
