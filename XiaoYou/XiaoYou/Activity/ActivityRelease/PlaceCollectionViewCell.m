//
//  PlaceCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "PlaceCollectionViewCell.h"
#import "YTextView.h"
#import "ActivityReleaseDataManager.h"

NSString *const kPlaceCollectionViewCell = @"PlaceCollectionViewCellId";

@interface PlaceCollectionViewCell ()<UITextViewDelegate>

@property(nonatomic,strong)YTextView * textView;
@property(nonatomic,strong)ActivityReleaseDataManager * dataManager;

@end

@implementation PlaceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changUI];
        
        _dataManager = [ActivityReleaseDataManager shareActivityReleaseDataManager];
    }
    return self;
}

-(void)changUI
{
    //输入部分
    _textView = [[YTextView alloc] init];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.delegate = self;
    _textView.font = CONTENT_FONT(12);
    _textView.placeholderColor = KCOLORGREEN_B5;
    [self.backView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(80));
        make.left.equalTo(self.numImageView.mas_left);
        make.bottom.right.mas_equalTo(SCALE_NUM(-12));
    }];
    
    //设置每个cell的不同部分
    self.numImageView.image = [UIImage imageNamed:@"img_num4"];
    self.typeLabel.text = @"地点";
    _textView.placeholder = @"在这里填写您的活动地点,\n如：第六教学楼204教室";
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    _dataManager.ActivityPlaceText = textView.text;
    [_dataManager isEnableToRelease];
}


@end
