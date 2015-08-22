//
//  YCommonEditViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YCommonEditViewController.h"
#import "YTextView.h"

@interface YCommonEditViewController()<UITextViewDelegate>

@property (nonatomic, assign) YCommonEditType type;
@property (nonatomic, strong) NSString *preText;
@property (nonatomic, strong) YTextView *textView;
@end

@implementation YCommonEditViewController

- (id)initWithType:(YCommonEditType)type preText:(NSString *)preText {
    self = [super init];
    if (self) {
        _type = type;
        _preText = preText;
        self.hidesBottomBarWhenPushed = true;
        
    }
    return self;
}
- (void)viewDidLoad {
    [self initController];
    [self initView];
}
- (void)initController {
    self.view.backgroundColor = KCOLORWHITE;
    [self showCustomNavigationBackButton];
    [self showCustomNavigationConfirmButton];
    if (_type == YCommonEditAttitude) {
        self.title = @"我的态度";
    }
    if (_preText.length == 0) {
        self.navigationRightButton.enabled = false;
    }
    
}
- (void)initView {
    _textView = [[YTextView alloc] init];
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(20));
        make.left.mas_equalTo(SCALE_NUM(10));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _textView.text = _preText;
    if (_type == YCommonEditAttitude) {
        _textView.placeholder = @"你是一个没有态度的人";
    }
    _textView.placeholderColor = KCOLORGREEN_455A64;
    _textView.font = CONTENT_FONT(12);
    _textView.delegate = self;
}
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.navigationRightButton.enabled = true;
    } else {
        self.navigationRightButton.enabled = false;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = false;
}
@end
