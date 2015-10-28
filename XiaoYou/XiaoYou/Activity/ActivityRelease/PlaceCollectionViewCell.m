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
    _textView.placeholderColor = KCOLOR_B5;
    [self.backView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(80));
        make.left.equalTo(self.numImageView.mas_left);
        make.bottom.right.mas_equalTo(SCALE_NUM(-12));
    }];
    
    //设置每个cell的不同部分
    self.numImageView.image = [UIImage imageNamed:@"img_num4"];
    self.typeLabel.text = @"地点";
    _textView.placeholder = @"在这里填写您的活动地点。\n例如：\n增城宁西茶园基地";
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    _dataManager.ActivityPlaceText = textView.text;
    [_dataManager isEnableToRelease];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    NSDictionary * dic = @{@"position":@4};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (range.location>=100)
    {
        if ([self isBlankString:text])
        {
            [YUtils showTitle:@"地点不能为空"];
            return NO;
        }
        else
        {
            [YUtils showTitle:@"地点字数不能大于100字"];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}
//判断字符串为空和只为空格解决办法
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
