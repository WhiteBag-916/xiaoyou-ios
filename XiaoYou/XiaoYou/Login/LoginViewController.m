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
#import "ProfileChangePwdViewController.h"

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
    self.view.backgroundColor = KCOLOR_e6ebea;
    
    self.isCheckButton = YES;
    
    [self initView];
    
    _accountTextField.text = [YShareData defaultData][kShareData_StudentNo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    
    //忘记密码
    UIButton *forgotPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgotPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgotPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgotPassword.titleLabel.font = CONTENT_FONT(12);
    [forgotPassword addTarget:self
                       action:@selector(pressForgotPassword)
             forControlEvents:UIControlEventTouchUpInside];
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
    [firstLogin setTitleColor:KCOLOR_009688 forState:UIControlStateNormal];
    firstLogin.titleLabel.font = CONTENT_FONT(12);
    [firstLogin addTarget:self
                   action:@selector(pressFirstLogin)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstLogin];
    [firstLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(_passwordTextField.mas_bottom);
        make.height.mas_equalTo(SCALE_NUM(35));
        make.width.mas_equalTo(SCALE_NUM(87));
    }];
}

//弹出协议条款
- (void)pressShowProtocalButton {
    CNTextController *textController = [[CNTextController alloc] init];
    textController.textType = TextTermsOfAgreementType;
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:textController];
    [self.view.window.rootViewController presentViewController:navigationController
                                                      animated:YES
                                                    completion:nil];
}

//选择协议条款
- (void)checkButton {
    self.isCheckButton = !self.isCheckButton;
    
    if (_isCheckButton) {
        [_protocolCheckButton setImage:[UIImage imageNamed:@"register-frame-agree"]
                              forState:UIControlStateNormal];
    } else {
        [_protocolCheckButton setImage:[UIImage imageNamed:@"register-frame"]
                              forState:UIControlStateNormal];
    }
    
    [self resetRightButton];
}

//首次登录
- (void)pressFirstLogin {
    [YAnalysis trackEvent:@"首次登录_登录" withPara:nil];
    [self.navigationController pushViewController:[[ProfilePhoneChangeViewController alloc]
                                                   initWithType:ProfilePhoneChangeTypeRegister
                                                   hasPhone:NO]
                                         animated:YES];
}

//忘记密码
- (void)pressForgotPassword {
    if ([_accountTextField.text isEmpty]) {
        [YUtils showTitle:@"您还没有输入学号"];
        return;
    }
    [YAnalysis trackEvent:@"忘记密码_登录" withPara:nil];
    [self.view endEditing:YES];
    
    //展示提示
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil
                                                              message:@"我们将发送验证码至你绑定的手机号上"
                                                         buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        if (1 == index) {
            [YAnalysis trackEvent:@"确认_重置密码弹窗" withPara:nil];
            [YUtils showHUDWithTitle];
            [[ProvisionManager sharedInstance] forgotPasswordReq:_accountTextField.text
                                                           block:^(YActionMessage *message) {
                [YUtils hiddenProgressHUD];
                
                if (message.isSuccess) {
                    [YShareData defaultData][kShareData_StudentNo] = _accountTextField.text;
                    
                    [self.navigationController
                     pushViewController:[[ProfileChangePwdViewController alloc]
                                         initWithType:ProfileChangePwdTypeForget
                                         
                                         needLogin:YES]
                                                         animated:true];
                }else if (999+kYYServerErrorBase == message.errorCode) {
                    //提示默认密码
                    [self pressInitialPassword:YES];
                }
                
                [YUtils showTitle:message.desc];
            }];
        } else {
            [YAnalysis trackEvent:@"取消_重置密码弹窗" withPara:nil];
        }
    }];
    [alert show];
}

//初始密码范例,需要消失
- (void)pressInitialPassword:(BOOL)needDissmiss {
    [self pressInitialPassword];
    if (needDissmiss) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC))
                       , dispatch_get_main_queue(), ^{
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
    self.navigationItem.rightBarButtonItem.enabled = ![_accountTextField.text isEmpty];
}

//下一步
- (void)onNavigationRightButtonClicked {
    [self.view endEditing:YES];
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
    [[ProvisionManager sharedInstance] goLogin:_accountTextField.text
                                      password:_passwordTextField.text
                                         block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        if (message.isSuccess) {
            //成功
            //是否需要完善资料
            LoginResp *loginResp = (LoginResp *)message.object;
            [YAnalysis collectUserInfo:message.object];
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
