//
//  NameAndPlaceCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NameCollectionViewCell.h"
#import "YTextView.h"
#import "ActivityReleaseDataManager.h"

NSString *const kNameCollectionViewCell = @"NameCollectionViewCellId";

@interface NameCollectionViewCell ()<UITextViewDelegate>

@property(nonatomic,strong)YTextView * textView;

@property(nonatomic,strong)ActivityReleaseDataManager * dataManager;

@end

@implementation NameCollectionViewCell

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
    self.numImageView.image = [UIImage imageNamed:@"img_num1"];
    self.typeLabel.text = @"活动名称(1-30字)";
    _textView.placeholder = @"例如：\n2015秋游采茶之旅";
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    _dataManager.ActivityNameText = textView.text;
    [_dataManager isEnableToRelease];
}

@end
