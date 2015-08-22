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

@interface LoginViewController ()

@property (nonatomic, strong) YTextField *accountTextField;
@property (nonatomic, strong) YTextField *passwordTextField;
@property (nonatomic, strong) UIButton *protocolCheckButton;
@property (nonatomic, assign) BOOL isCheckButton;//是否同意协议
@property (nonatomic, strong) UIImageView *protocolImageView;//提示蒙层

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    [self showCustomNavigationNextButton];
    self.view.backgroundColor = KCOLORGREEN_e6eae9;
    
    _isCheckButton = YES;
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    _accountTextField.text = [YShareData defaultData][kShareData_LoginAccount];
#if DEBUG    
    if (_accountTextField.text.length <= 0) {
        _accountTextField.text = @"15140080000";
    }
    _passwordTextField.text = @"123456";
#endif
    
    [self resetRightButton];
}

- (void)initView {
    //accountView
    UIView *accountView = [YUtils initLoginCommonView:@"login_school"];
    [self.view addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(SCALE_NUM(28));
        make.height.mas_equalTo(SCALE_NUM(49));
    }];
    
    //passwordView
    UIView *passwordView = [YUtils initLoginCommonView:@"login_school"];
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
    
    //passwordTextField
    _passwordTextField = (YTextField *)[passwordView viewWithTag:kLoginCommonTextFieldTag];
    [_passwordTextField registerChanged:self action:@selector(textFieldValueChanged:)];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.placeholder = @"密码 ";
    
    //protocolCheckButton
    _protocolCheckButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_protocolCheckButton setTitle:@"同意用户条款" forState:UIControlStateNormal];
    _protocolCheckButton.titleLabel.font = CONTENT_FONT(12);
    [_protocolCheckButton setTitleColor:KCOLORGREEN_009688 forState:UIControlStateNormal];
    [_protocolCheckButton setImage:[UIImage imageNamed:@"toggle-on"] forState:UIControlStateNormal];
    [_protocolCheckButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_protocolCheckButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [_protocolCheckButton addTarget:self action:@selector(checkButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_protocolCheckButton];
    [_protocolCheckButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_passwordTextField.mas_bottom);
        make.height.mas_equalTo(SCALE_NUM(35));
        make.width.mas_equalTo(SCALE_NUM(119));
    }];
    
    //忘记密码
    UIButton *forgotPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgotPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgotPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgotPassword.titleLabel.font = CONTENT_FONT(12);
    [forgotPassword addTarget:self action:@selector(pressForgotPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPassword];
    [forgotPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(_passwordTextField.mas_bottom);
        make.height.mas_equalTo(SCALE_NUM(35));
        make.width.mas_equalTo(SCALE_NUM(87));
    }];
    
    //初始密码
    UIButton *initialPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [initialPassword setTitle:@"初始密码范例" forState:UIControlStateNormal];
    [initialPassword setTitleColor:KCOLORGREEN_009688 forState:UIControlStateNormal];
    initialPassword.titleLabel.font = CONTENT_FONT(12);
    initialPassword.layer.borderWidth = .5;
    initialPassword.layer.cornerRadius = 3;
    initialPassword.layer.borderColor = KCOLORGREEN_009688.CGColor;
    [initialPassword addTarget:self action:@selector(pressInitialPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:initialPassword];
    [initialPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(SCALE_NUM(-113));
        make.height.mas_equalTo(SCALE_NUM(36));
        make.width.mas_equalTo(SCALE_NUM(118));
    }];
    
    //蒙层
    _protocolImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_tip"]];
    [self.view addSubview:_protocolImageView];
    _protocolImageView.hidden = YES;
    [_protocolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissProtocol)];
    _protocolImageView.userInteractionEnabled = YES;
    [_protocolImageView addGestureRecognizer:tap];
}

//选择协议条款
- (void)checkButton {
    _isCheckButton = !_isCheckButton;
    
    if (_isCheckButton) {
        [_protocolCheckButton setImage:[UIImage imageNamed:@"toggle-on"] forState:UIControlStateNormal];
    } else {
        [_protocolCheckButton setImage:[UIImage imageNamed:@"toggle-off"] forState:UIControlStateNormal];
    }
    
    [self resetRightButton];
}

//忘记密码
- (void)pressForgotPassword {
    if ([_accountTextField.text isEmpty]) {
        [YUtils showTitle:@"您还没有输入学校和学号"];
        return;
    }
    
    //展示提示
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil
                                                              message:@"需要重置密码吗"
                                                         buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        if (1 == index) {
            [[ProvisionManager sharedInstance] forgotPasswordReq:_accountTextField.text block:^(YActionMessage *message) {
                if (999+kYYServerErrorBase == message.errorCode) {
                    //提示默认密码
                }
                
                [YUtils showTitle:message.desc];
                
            }];
        }
    }];
    [alert show];
}

//初始密码范例
- (void)pressInitialPassword {
    _protocolImageView.hidden = NO;
}

- (void)dissmissProtocol {
    _protocolImageView.hidden = YES;
}

- (void)resetRightButton {
    if ([_accountTextField.text isEmpty] || [_accountTextField.text isEmpty] || !_isCheckButton) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

//下一步
- (void)onNavigationRightButtonClicked {
    [self goLogin];
}

- (void)goLogin
{
    //login
    [[ProvisionManager sharedInstance] goLogin:_accountTextField.text password:_passwordTextField.text block:^(YActionMessage *message) {
        if (message.isSuccess) {
            //成功
            [kAppDelegateAccessor initTabBarNC];
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
