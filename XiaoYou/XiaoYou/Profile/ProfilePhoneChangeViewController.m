//
//  ProfilePhoneChangeViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfilePhoneChangeViewController.h"
#import "YTextField.h"
#import "YTextField+Ext.h"
#import "ProvisionManager.h"
#import "ProfileChangePwdViewController.h"

#define KBUTTONWIDTH SCALE_NUM(80)
#define KBUTTONHEIGHT SCALE_NUM(25)
#define KWAITWIDTH SCALE_NUM(50)

@interface ProfilePhoneChangeViewController()
@property (nonatomic, strong) YTextField *phoneField;
@property (nonatomic, strong) YTextField *codeField;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UILabel *waitLabel;
@property (nonatomic, assign) BOOL hasPhone;
@end

@implementation ProfilePhoneChangeViewController
- (id)initWithType:(BOOL)hasPhone {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = true;
        _hasPhone = hasPhone;
    }
    return self;
}
- (void)viewDidLoad {
    [self initController];
    [self initView];
}
- (void)initController {
    self.navigationController.navigationBarHidden = false;
    [self showCustomNavigationBackButton];
    [self showCustomNavigationConfirmButton];
    self.view.backgroundColor = KCOLORGREEN_f2f2f2;
    self.title = @"手机号验证";
    self.navigationRightButton.enabled = false;
}
- (void)initView {
    _phoneField = [self createField:0];
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCALE_NUM(28));
    }];
    _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    
    _sendBtn = [[UIButton alloc] init];
    [self.view addSubview:_sendBtn];
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_phoneField).offset(-SCALE_NUM(12));
        make.centerY.equalTo(_phoneField);
        make.width.mas_equalTo(KBUTTONWIDTH);
        make.height.mas_equalTo(KBUTTONHEIGHT);
    }];
    _sendBtn.layer.borderWidth = 1;
    [_sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendBtn setTitle:@"获取验证码" forState:UIControlStateDisabled];
    [_sendBtn setTitleColor:KCOLORGREEN_009688 forState:UIControlStateNormal];
    [_sendBtn setTitleColor:KCOLORGREEN_455A64 forState:UIControlStateDisabled];
    _sendBtn.enabled = false;
    _sendBtn.titleLabel.font = CONTENT_FONT(12);
    [_sendBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    _waitLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLORWHITE text:@"60s" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [_phoneField addSubview:_waitLabel];
    [_waitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(_sendBtn);
        make.width.mas_equalTo(KWAITWIDTH);
    }];
    _waitLabel.backgroundColor = KCOLORGREEN_e5e5e5;
    _waitLabel.hidden = true;
    
    _codeField = [self createField:1];
    [_codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneField.mas_bottom).offset(2);
    }];
    
    
}
- (YTextField *)createField:(int)type {
    NSArray *names = @[@"请输入新手机号", @"输入获取的验证码"];
    UIView *whiteBack = [[UIView alloc] init];
    [self.view addSubview:whiteBack];
    [whiteBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
    }];
    whiteBack.backgroundColor = KCOLORWHITE;
    YTextField *field = [[YTextField alloc] init];
    [whiteBack addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(whiteBack);
        make.height.mas_equalTo(SCALE_NUM(50));
        make.top.bottom.equalTo(whiteBack);
        make.left.equalTo(whiteBack).offset(SCALE_NUM(10));
    }];
    field.font = CONTENT_FONT(12);
    [field registerChanged:self action:@selector(checkComplete)];
    [YTextField placeHolderColor:field normalString:names[type] fontColor:KCOLORGREEN_e5e5e5];
    return field;
}
- (void)changeWait:(BOOL)isWaiting {
    if (isWaiting) {
        _sendBtn.hidden = true;
        _waitLabel.text = @"60s";
        _waitLabel.hidden = false;
        [self startCal];
    } else {
        _sendBtn.hidden = false;
        _waitLabel.hidden = true;
    }
}
- (void)changeBtn:(BOOL)isValid {
    if (isValid) {
        _sendBtn.enabled = true;
        _sendBtn.layer.borderColor = [KCOLORGREEN_009688 CGColor];
    } else {
        _sendBtn.enabled = false;
        _sendBtn.layer.borderColor = [KCOLORGREEN_455A64 CGColor];
    }
}
- (void)startCal {
    __block int timeout = 60;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self changeWait:false];
            });
        }else{
            NSString *strTime = [NSString stringWithFormat:@"%.2ds", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                _waitLabel.text = strTime;
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}
- (void)getCode {
    [self.view endEditing:true];
    [self changeWait:true];
    [self startCal];
    [[ProvisionManager sharedInstance] receiveAuthCode:_phoneField.text block:^(YActionMessage *message) {
        if (message.isSuccess) {
            [YUtils showTitle:@"验证码发送成功"];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}
- (void)checkComplete {
    if (_phoneField.text.length > 0) {
        [self changeBtn:true];
    } else {
        [self changeBtn:false];
    }
    if (_phoneField.text.length > 0 && _codeField.text.length > 0) {
        self.navigationRightButton.enabled = true;
    } else {
        self.navigationRightButton.enabled = false;
    }
}
- (void)onNavigationRightButtonClicked {
    MBProgressHUD *hud = [YUtils showHUDWithTitle:@"正在加载"];
    [[ProvisionManager sharedInstance] receiveMobileAuthCode:_phoneField.text authCode:_codeField.text block:^(YActionMessage *message) {
        if (message.isSuccess) {
            [hud removeFromSuperview];
            if (_hasPhone) {
                
            } else {
                [self.navigationController pushViewController:[[ProfileChangePwdViewController alloc] init] animated:true];
            }
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}
@end
