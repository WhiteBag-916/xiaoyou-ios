//
//  NameAndPlaceCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NameCollectionViewCell.h"
#import "YTextView.h"

NSString *const kNameCollectionViewCell = @"NameCollectionViewCellId";

@interface NameCollectionViewCell ()

@property(nonatomic,strong)YTextView * textView;

@end

@implementation NameCollectionViewCell

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
    _textView = [[YTextView alloc] init];
    _textView.backgroundColor = [UIColor yellowColor];
    _textView.font = CONTENT_FONT(15);
    _textView.placeholderColor = KCOLORGREEN_B5;
    [self.backView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.equalTo(self.numImageView.mas_left);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-12);
    }];
    
}

-(void)setCellInfo:(NSInteger) index
{
    if (index == 0)
    {
        self.numImageView.image = [UIImage imageNamed:@"img_num1"];
        self.typeLabel.text = @"活动名称(0-30字)";
        _textView.placeholder = @"例如：\n怀旧活动:一起擦雪花膏\n怀旧活动:一起擦雪花膏";
    }
    else
    {
        self.numImageView.image = [UIImage imageNamed:@"img_num4"];
        self.typeLabel.text = @"地点";
        _textView.placeholder = @"在这里填写您的活动地点,\n如：第六教学楼204教室";
    }
    
}

@end
