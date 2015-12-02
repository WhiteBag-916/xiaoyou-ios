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
    self.textView = [[YTextView alloc] init];
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
    self.textView.placeholder = @"在这里填写您的活动地点。\n例如：\n增城宁西茶园基地";
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger fieldLen = [textView.text length];
    NSInteger rangeLen = range.length;
    NSInteger strLen = text.length;
    if (![text isEqualToString:@"\n"])
    {
        if (fieldLen - rangeLen + strLen > 100)
        {
            [YUtils showTitle:@"地点字数不能大于100字"];
            return NO;
        }
    } else {
        //在这里做你响应return键的代码
        [self endEditing:YES];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    _dataManager.ActivityPlaceText = textView.text;
    [_dataManager isEnableToRelease];
    
    if (textView.text.length>100)
    {
        if ([self isBlankString:textView.text])
        {
            [self.viewController.view endEditing:YES];
            [YUtils showTitle:@"地点不能为空"];
        }
        else
        {
            [self.viewController.view endEditing:YES];
            
        }
        if (textView.text.length >= 100)
        {
            [YUtils showTitle:@"地点字数不能大于100字"];
            [textView setText:[textView.text substringWithRange:NSMakeRange(0, 100)]];
            _dataManager.ActivityPlaceText = textView.text;
        }
        else
        {
            return;
        }
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSDictionary * dic = @{@"position":@4};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
    return YES;
}

#pragma mark - 判断字符串为空和只为空格解决办法
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:
          [NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
