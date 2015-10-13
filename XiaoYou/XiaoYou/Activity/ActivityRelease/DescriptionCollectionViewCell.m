//
//  DescriptionCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "DescriptionCollectionViewCell.h"
#import "YTextView.h"

NSString *const kDescriptionCollectionViewCell = @"DescriptionCollectionViewCellId";

@interface DescriptionCollectionViewCell ()

@property (nonatomic,strong) UIButton * picButton;
@property (nonatomic,strong) YTextView * textView;

@end

@implementation DescriptionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changUI];
    }
    return self;
}

-(void)changUI
{
    _picButton = [[UIButton alloc] init];
    [_picButton setImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
    [self.backView addSubview:_picButton];
    [_picButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.equalTo(self.numImageView.mas_left);
        make.height.width.mas_equalTo(72);
    }];
    
    _textView = [[YTextView alloc] init];
    _textView.backgroundColor = [UIColor yellowColor];
    _textView.font = CONTENT_FONT(15);
    _textView.placeholderColor = KCOLORGREEN_B5;
    [self.backView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_picButton.mas_bottom).offset(12);
        make.left.equalTo(self.numImageView.mas_left);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-12);
    }];
    
    self.numImageView.image = [UIImage imageNamed:@"img_num2"];
    self.typeLabel.text = @"活动描述";
    _textView.placeholder = @"例如：\n我觉得要阐明举办此次活动的背景,表述活动举办的意义以及目的,最后将活动所取得的效果加以描述并且稍稍夸大一点.再用几句话总结一下就可以了.比如：此次活动是在某某某单位的大力支持下举办的,通过我们主办人员的通力合作,克服了重重困难.最后这场精彩纷呈的什么什么（就是你们活动的主题）活动呈现在大家面前,活动的效果是明显的,证明我们一切的努力都没有白费.等等";
    
}

@end
