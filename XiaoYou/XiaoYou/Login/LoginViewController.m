//
//  LoginViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "LoginViewController.h"
#import "YTextField.h"
#import "ProvisionManager.h"
#import "AppDelegate+RootVC.h"
#import "LoginResp.h"
#import "CNTextController.h"
#import "ProfilePhoneChangeViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) YTextField *accountTextField;
@property (nonatomic, strong) YTextField *passwordTextField;
@property (nonatomic, strong) UIButton *protocolCheckButton;
@property (nonatomic, strong) UIButton *showProtocalButton;
@property (nonatomic, assign) BOOL isCheckButton;//是否同意协议
@property (nonatomic, strong) UIImageView *protocolImageView;//提示蒙层

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    [self showCustomNavigationBackButton];
    [self showCustomNavigationNextButton];
    self.view.backgroundColor = KCOLORGREEN_e6ebea;
    
    _isCheckButton = YES;
    
    [self initView];
    
    _accountTextField.text = [YShareData defaultData][kShareData_StudentNo];
}

- (void)viewWillAppear:(BOOL)animated {
    [self resetRightButton];
}

- (void)initView {
    //accountView
    UIView *accountView = [YUtils initLoginCommonView:@"register-number"];
    [self.view addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(SCALE_NUM(28));
        make.height.mas_equalTo(SCALE_NUM(49));
    }];
    
    //passwordView
    UIView *passwordView = [YUtils initLoginCommonView:@"register-password"];
    [self.view addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(accountView.mas_bottom).offset(1);
        make.height.mas_equalTo(SCALE_NUM(49));
    }];
    
    //accountTextField
    _accountTextField = (YTextField *)[accountView viewWithTag:kLoginCommonTextFieldTag];
    [_accountTextField registerChanged:self action:@selector(textFieldValueChanged:)];
    _accountTextField.placeholder = @"学号";
    _accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    //passwordTextField
    _passwordTextField = (YTextField *)[passwordView viewWithTag:kLoginCommonTextFieldTag];
    [_passwordTextField registerChanged:self action:@selector(textFieldValueChanged:)];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.placeholder = @"密码";
    
//    //protocolCheckButton
//    _protocolCheckButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_protocolCheckButton setImage:[UIImage imageNamed:@"register-frame-agree"] forState:UIControlStateNormal];
//    [_protocolCheckButton addTarget:self action:@selector(checkButton) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_protocolCheckButton];
//    [_protocolCheckButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.top.equalTo(_passwordTextField.mas_bottom);
//        make.height.mas_equalTo(SCALE_NUM(35));
//        make.width.mas_equalTo(SCALE_NUM(36));
//    }];
//    
//    //显示协议条款
//    _showProtocalButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_showProtocalButton setTitle:@"同意用户条款" forState:UIControlStateNormal];
//    _showProtocalButton.titleLabel.font = CONTENT_FONT(12);
//    [_showProtocalButton setTitleColor:KCOLORGREEN_009688 forState:UIControlStateNormal];
//    [_showProtocalButton addTarget:self action:@selector(pressShowProtocalButton) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_showProtocalButton];
//    [_showProtocalButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_protocolCheckButton.mas_right);
//        make.top.height.equalTo(_protocolCheckButton);
//    }];
    
    //忘记密码
    UIButton *forgotPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgotPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgotPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgotPassword.titleLabel.font = CONTENT_FONT(12);
    [forgotPassword addTarget:self action:@selector(pressForgotPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPassword];
    [forgotPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_passwordTextField.mas_bottom);
        make.height.mas_equalTo(SCALE_NUM(35));
        make.width.mas_equalTo(SCALE_NUM(87));
    }];
    
    //首次登陆
    UIButton *firstLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstLogin setTitle:@"首次登录>" forState:UIControlStateNormal];
    [firstLogin setTitleColor:KCOLORGREEN_009688 forState:UIControlStateNormal];
    firstLogin.titleLabel.font = CONTENT_FONT(12);
    [firstLogin addTarget:self action:@selector(pressFirstLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstLogin];
    [firstLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(_passwordTextField.mas_bottom);
        make.height.mas_equalTo(SCALE_NUM(35));
        make.width.mas_equalTo(SCALE_NUM(87));
    }];
    
    //初始密码
//    UIButton *initialPassword = [UIButton buttonWithType:UIButtonTypeCustom];
//    [initialPassword setTitle:@"初始密码范例" forState:UIControlStateNormal];
//    [initialPassword setTitleColor:KCOLORGREEN_009688 forState:UIControlStateNormal];
//    initialPassword.titleLabel.font = CONTENT_FONT(12);
//    initialPassword.layer.borderWidth = .5;
//    initialPassword.layer.cornerRadius = 3;
//    initialPassword.layer.borderColor = KCOLORGREEN_009688.CGColor;
//    [initialPassword addTarget:self action:@selector(pressInitialPassword) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:initialPassword];
//    [initialPassword mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.bottom.mas_equalTo(SCALE_NUM(-113));
//        make.height.mas_equalTo(SCALE_NUM(36));
//        make.width.mas_equalTo(SCALE_NUM(118));
//    }];
    
    //蒙层
//    _protocolImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_tip"]];
//    _protocolImageView.hidden = YES;
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:_protocolImageView];
//    [_protocolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo([[[UIApplication sharedApplication] delegate] window]);
//    }];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissProtocol)];
//    _protocolImageView.userInteractionEnabled = YES;
//    [_protocolImageView addGestureRecognizer:tap];
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
    
    [self resetRightButton];
}

//首次登录
- (void)pressFirstLogin {
    [self.navigationController pushViewController:[[ProfilePhoneChangeViewController alloc] initWithType:ProfilePhoneChangeTypeRegister hasPhone:NO] animated:YES];
}

//忘记密码
- (void)pressForgotPassword {
    if ([_accountTextField.text isEmpty]) {
        [YUtils showTitle:@"您还没有输入学号"];
        return;
    }
    
    [self.view endEditing:YES];
    
    //展示提示
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil
                                                              message:@"我们将发送验证码至你绑定的手机号上，请及时修改"
                                                         buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        if (1 == index) {
            [YUtils showHUDWithTitle];
            [[ProvisionManager sharedInstance] forgotPasswordReq:_accountTextField.text block:^(YActionMessage *message) {
                [YUtils hiddenProgressHUD];
                if (999+kYYServerErrorBase == message.errorCode) {
                    //提示默认密码
                    [self pressInitialPassword:YES];
                } else {
                    [YUtils showTitle:message.desc];
                }
            }];
        }
    }];
    [alert show];
}

//初始密码范例,需要消失
- (void)pressInitialPassword:(BOOL)needDissmiss {
    [self pressInitialPassword];
    if (needDissmiss) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dissmissProtocol];
        });
    }
}

//初始密码范例
- (void)pressInitialPassword {
    _protocolImageView.hidden = NO;
}

- (void)dissmissProtocol {
    _protocolImageView.hidden = YES;
}

- (void)resetRightButton {
    if ([_accountTextField.text isEmpty]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

//下一步
- (void)onNavigationRightButtonClicked {
    if ([_passwordTextField.text isEmpty]) {
        //密码不能为空
        [YUtils showTitle:@"密码不能为空"];
    }
    else if (!_isCheckButton) {
        //没有同意条款
        [YUtils showTitle:@"你必须同意用户条款才能进入下一步"];
    } else {
        [self goLogin];
    }
}

- (void)goLogin
{
    [YUtils showHUDWithTitle];
    //login
    [[ProvisionManager sharedInstance] goLogin:_accountTextField.text password:_passwordTextField.text block:^(YActionMessage *message) {
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldValueChanged:(UITextField *)sender{
    [self resetRightButton];
}

@end
