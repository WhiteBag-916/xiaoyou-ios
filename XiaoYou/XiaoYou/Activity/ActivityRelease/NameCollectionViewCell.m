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
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = CONTENT_FONT(12);
    _textView.placeholderColor = KCOLORGREEN_B5;
    [self.backView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(80));
        make.left.equalTo(self.numImageView.mas_left);
        make.bottom.right.mas_equalTo(SCALE_NUM(-12));
    }];
    
    self.numImageView.image = [UIImage imageNamed:@"img_num1"];
    self.typeLabel.text = @"活动名称(0-30字)";
    _textView.placeholder = @"例如：\n怀旧活动:一起擦雪花膏\n怀旧活动:一起擦雪花膏";
    
}

@end
