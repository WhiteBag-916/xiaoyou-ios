//
//  YCommonEditViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "YCommonEditViewController.h"
#import "YTextView.h"
#import "ProvisionManager.h"
#import "LoginResp.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "YModel+ActionMessage.h"

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
    [super viewDidLoad];
    
    
    [self initController];
    [self initView];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)initController {
    self.view.backgroundColor = KCOLORWHITE;
    [self showCustomNavigationCancelButton];
    [self showCustomNavigationConfirmButton];
    if (_type == YCommonEditAttitude) {
        self.title = @"我的态度";
    }
    if (_preText.length == 0) {
        self.navigationRightButton.enabled = false;
    }
    if (_type == YCommonEditAddFriend) {
        self.title = @"添加好友";
        self.navigationRightButton.enabled = true;
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
    if ([_preText isEqualToString:@"你是一个没有态度的人"]) {
        _preText = nil;
    }
    _textView.text = _preText;
    if (_type == YCommonEditAttitude) {
        _textView.placeholder = @"你是一个没有态度的人";
    }
    if (_type == YCommonEditAddFriend) {
        _textView.text = @"";
        LoginResp *resp = [[ProvisionManager sharedInstance] getLoginInfo];
        _textView.placeholder = [NSString stringWithFormat:@"我是%@级%@的%@", resp.grad, resp.college, resp.studentName];
    }
    _textView.placeholderColor = KCOLOR_455A64;
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
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
    [self showEditMode];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showOrignMode];
}
- (void)onNavigationRightButtonClicked {
    [self.view endEditing:true];
    if (_type == YCommonEditAttitude) {
        MBProgressHUD *hud = [YUtils showHUDAddedTo:self.view title:@"正在保存"];
        [[ProvisionManager sharedInstance] UpdateSelfIntro:[ConvertToCommonEmoticonsHelper convertToCommonEmoticons:_textView.text] block:^(YActionMessage *message) {
            [hud removeFromSuperview];
            if (message.isSuccess) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            } else {
                [YUtils showTitle:message.desc];
            }
        }];
    }
}
- (void)onNavigationLeftButtonClicked {
    [self.view endEditing:true];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
