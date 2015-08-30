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
#import "CNTextController.h"
#import "LoginResp.h"
#import "AppDelegate+RootVC.h"

#define KBUTTONWIDTH SCALE_NUM(80)
#define KBUTTONHEIGHT SCALE_NUM(25)
#define KWAITWIDTH SCALE_NUM(50)

@interface ProfilePhoneChangeViewController()
@property (nonatomic, strong) YTextField *phoneField;
@property (nonatomic, strong) YTextField *codeField;
@property (nonatomic, strong) YTextField *accountTextField;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIButton *protocolCheckButton;
@property (nonatomic, strong) UIButton *showProtocalButton;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, assign) BOOL isCheckButton;//是否同意协议
@property (nonatomic, strong) UILabel *waitLabel;
@property (nonatomic, assign) BOOL hasPhone;
@property (nonatomic, assign) ProfilePhoneChangeType type;

@property (nonatomic, strong) YTextField *pwdField;
@property (nonatomic, strong) UIView *pwdView;
@end

@implementation ProfilePhoneChangeViewController
- (id)initWithType:(ProfilePhoneChangeType)type hasPhone:(BOOL)hasPhone {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = true;
        _hasPhone = hasPhone;
        _type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [self initController];
    [self initView];
    if (_hasPhone) {
        [self initPwdView];
    }
    [self checkComplete];
    
    if (ProfilePhoneChangeTypeRegister == _type) {
        [self initViewByRegister];
    } else {
        [self showCustomNavigationConfirmButton];
    }
}
- (void)initViewByRegister {
    self.title = @"首次登录";
    [_sendBtn setTitle:@"获取初始密码" forState:UIControlStateNormal];
    [_sendBtn setTitle:@"获取初始密码" forState:UIControlStateDisabled];
    _phoneField.placeholder = @"输入手机号";
    _codeField.placeholder = @"输入获取的初始密码";
    
    //label
    UILabel *accountLabel = [YUtils initLabel:CONTENT_FONT(10)
                                     color:[UIColor blackColor]
                                      text:@"学号"
                                     frame:CGRectZero
                                 alignment:NSTextAlignmentCenter];
    [self.view addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(12));
        make.top.mas_equalTo(SCALE_NUM(14));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    //accountView
    UIView *accountView = [YUtils initLoginCommonView:@"register-number"];
    [self.view addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(accountLabel.mas_bottom).offset(SCALE_NUM(10));
        make.height.mas_equalTo(SCALE_NUM(49));
    }];
    
    UILabel *phoneLabel = [YUtils initLabel:CONTENT_FONT(10)
                                      color:[UIColor blackColor]
                                      text:@"手机号 "
                                     frame:CGRectZero
                                 alignment:NSTextAlignmentCenter];
    
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(12));
        make.top.equalTo(accountView.mas_bottom).offset(SCALE_NUM(15));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    [_phoneField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel.mas_bottom).offset(SCALE_NUM(10));
    }];
    
    [_codeField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneField.mas_bottom).offset(SCALE_NUM(5));
    }];
    
    //accountTextField
    _accountTextField = (YTextField *)[accountView viewWithTag:kLoginCommonTextFieldTag];
    [_accountTextField registerChanged:self action:@selector(checkComplete)];
    _accountTextField.placeholder = @"输入学号";
    _accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    //protocolCheckButton
    _protocolCheckButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_protocolCheckButton setImage:[UIImage imageNamed:@"register-frame-agree"] forState:UIControlStateNormal];
    [_protocolCheckButton addTarget:self action:@selector(registerDefaults:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_protocolCheckButton];
    [_protocolCheckButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_codeField.mas_bottom);
        make.height.mas_equalTo(SCALE_NUM(35));
        make.width.mas_equalTo(SCALE_NUM(36));
    }];
    
    //显示协议条款
    _showProtocalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_showProtocalButton setTitle:@"同意用户条款" forState:UIControlStateNormal];
    _showProtocalButton.titleLabel.font = CONTENT_FONT(12);
    [_showProtocalButton setTitleColor:KCOLORGREEN_009688 forState:UIControlStateNormal];
    [_showProtocalButton addTarget:self action:@selector(pressShowProtocalButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_showProtocalButton];
    [_showProtocalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_protocolCheckButton.mas_right);
        make.top.height.equalTo(_protocolCheckButton);
    }];
    
    //登录按钮
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = CONTENT_FONT(12);
    [_loginButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 3;
    [_loginButton setTitleColor:KCOLORWHITE forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.enabled = NO;
    [self.view addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(36));
        make.right.mas_equalTo(SCALE_NUM(-36));
        make.top.equalTo(_showProtocalButton.mas_bottom).offset(SCALE_NUM(15));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    
    //文案
    UILabel *textLabel = [YUtils initLabel:CONTENT_FONT(10)
                                     color:KCOLORGREEN_455A64
                                      text:@"校友网是实名社交，请填写本人真实手机号，管理员将于24h内审核您的信息，不真实的账号可能会被删除；\
                          如有登录异常等问题，请联系所在院系辅导员。"
                                     frame:CGRectZero
                                 alignment:NSTextAlignmentCenter];
    textLabel.numberOfLines = 3;
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_loginButton);
        make.top.equalTo(_loginButton.mas_bottom).offset(SCALE_NUM(5));
    }];
    
    _isCheckButton = YES;
}
- (void)initController {
    self.navigationController.navigationBarHidden = false;
    [self showCustomNavigationBackButton];
    self.view.backgroundColor = KCOLORGREEN_f2f2f2;
    self.title = @"验证手机号";
}
- (void)initPwdView {
    self.title = @"输入密码";
    _pwdView = [[UIView alloc] init];
    [self.view addSubview:_pwdView];
    _pwdView.backgroundColor = KCOLORGREEN_f2f2f2;
    [_pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _pwdField = [self createField:2];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCALE_NUM(28));
    }];
    _pwdField.secureTextEntry = true;
}
- (void)initView {
    _phoneField = [self createField:0];
    if (ProfilePhoneChangeTypeRegister != _type) {
        [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(SCALE_NUM(28));
        }];
    }
    _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    
    _sendBtn = [[UIButton alloc] init];
    [self.view addSubview:_sendBtn];
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneField.mas_right).offset(3);
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
    [self.view addSubview:_waitLabel];
    [_waitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(_sendBtn);
        make.width.mas_equalTo(KWAITWIDTH);
    }];
    _waitLabel.backgroundColor = KCOLORGREEN_e5e5e5;
    _waitLabel.hidden = true;

    _codeField = [self createField:1];
    _codeField.keyboardType = UIKeyboardTypeNumberPad;
    [_codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneField.mas_bottom).offset(2);
    }];
    
    
}
- (YTextField *)createField:(int)type {
    NSArray *names = @[@"请输入新手机号", @"输入获取的验证码", @"请输入当前密码"];
    UIView *whiteBack = [[UIView alloc] init];
    if (type == 2) {
        [_pwdView addSubview:whiteBack];
    } else {
        [self.view addSubview:whiteBack];
    }
    [whiteBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
    }];
    whiteBack.backgroundColor = KCOLORWHITE;
    YTextField *field = [[YTextField alloc] init];
    [whiteBack addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(whiteBack).offset(-15-KBUTTONWIDTH);
        make.height.mas_equalTo(SCALE_NUM(50));
        make.top.bottom.equalTo(whiteBack);
        make.left.equalTo(whiteBack).offset(SCALE_NUM(10));
    }];
    field.font = CONTENT_FONT(12);
    [field registerChanged:self action:@selector(checkComplete)];
    field.textColor = KCOLORGREEN_455A64;
    field.placeholder = names[type];
//    [field placeHolderColor:names[type] fontColor:KCOLORGREEN_455A64];
    return field;
}

//登录
- (void)pressLogin {
    [YUtils showHUDWithTitle];
    //reg
    [[ProvisionManager sharedInstance] reg:_accountTextField.text password:_codeField.text mobilePhone:_phoneField.text block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        if (message.isSuccess) {
            //成功
            //是否需要完善资料
            LoginResp *loginResp = (LoginResp *)message.object;
            if (loginResp.firstLogin) {
                [kAppDelegateAccessor initPerfectNC];
            } else {
                [kAppDelegateAccessor initTabBarNC];
            }
            
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}

//弹出协议条款
- (void)pressShowProtocalButton {
    CNTextController *textController = [[CNTextController alloc] init];
    textController.textType = TextTermsOfAgreementType;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:textController];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

//选择协议条款
- (void)checkButton {
    _isCheckButton = !_isCheckButton;
    
    if (_isCheckButton) {
        [_protocolCheckButton setImage:[UIImage imageNamed:@"register-frame-agree"] forState:UIControlStateNormal];
    } else {
        [_protocolCheckButton setImage:[UIImage imageNamed:@"register-frame"] forState:UIControlStateNormal];
    }
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
    [[ProvisionManager sharedInstance] receiveAuthCode:_phoneField.text needUserToken:(_type != ProfilePhoneChangeTypeRegister) block:^(YActionMessage *message) {
        [YUtils showTitle:message.desc];
    }];
}
- (void)checkComplete {
    //mod by xiongchen
    //add || nil == _pwdView
    if (nil == _pwdView || _pwdView.hidden) {
        if (_phoneField.text.length > 0) {
            [self changeBtn:true];
        } else {
            [self changeBtn:false];
        }
        if (_phoneField.text.length > 0 && _codeField.text.length > 0 && (nil == _accountTextField || _accountTextField.text.length > 0)) {
            self.navigationRightButton.enabled = true;
            _loginButton.enabled = true;
        } else {
            self.navigationRightButton.enabled = false;
            _loginButton.enabled = false;
        }
    } else {
        if (_pwdField.text.length == 0) {
            self.navigationRightButton.enabled = false;
        } else {
            self.navigationRightButton.enabled = true;
        }
    }
}
- (void)onNavigationRightButtonClicked {
    //mod by xiongchen
    //add || nil == _pwdView
    if (nil == _pwdView || _pwdView.hidden) {
        MBProgressHUD *hud = [YUtils showHUDWithTitle:@"正在加载"];
        [[ProvisionManager sharedInstance] receiveMobileAuthCode:_phoneField.text authCode:_codeField.text block:^(YActionMessage *message) {
            [hud removeFromSuperview];
            if (message.isSuccess) {
                [hud removeFromSuperview];
                if (_hasPhone) {
                    [YUtils showTitle:@"绑定成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:true];
                    });
                } else {
                    [self.navigationController pushViewController:[[ProfileChangePwdViewController alloc] init] animated:true];
                }
            } else {
                [YUtils showTitle:message.desc];
            }
        }];
    } else {
        if([_pwdField.text isEqualToString:[YShareData defaultData][kShareData_LoginPassword]]) {
            self.title = @"验证手机号";
            _pwdView.hidden = true;
            [self.view endEditing:true];
            [self checkComplete];
        } else {
            [YUtils showTitle:@"密码错误"];
        }
    }
}
@end
