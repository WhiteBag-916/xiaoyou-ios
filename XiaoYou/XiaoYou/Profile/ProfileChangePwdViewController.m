





//
//  ProfileChangePwdViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileChangePwdViewController.h"
#import "ProfileMyViewController.h"
#import "YTextField.h"
#import "YTextField+Ext.h"
#import "ProvisionManager.h"
#import "LoginResp.h"
#import "AppDelegate+RootVC.h"

@interface ProfileChangePwdViewController()

@property (nonatomic, strong) YTextField *currentPwdField;

@property (nonatomic, strong) YTextField *pwdField;

@property (nonatomic, strong) YTextField *pwdRepeatField;
@property (nonatomic, strong) UIButton *forget;
@property (nonatomic, assign) ProfileChangePwdType type;
@property (nonatomic, assign) BOOL needLogin;
@end

@implementation ProfileChangePwdViewController

- (id)initWithType:(ProfileChangePwdType)type needLogin:(BOOL)needLogin {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = true;
        _type = type;
        _needLogin = needLogin;
    }
    return self;
}
- (void)viewDidLoad {
    [self initController];
    [self initView];
    
    if (ProfileChangePwdTypeForget == _type) {
        [self initViewByForget];
    }
}
- (void)initViewByForget {
    _currentPwdField.placeholder = @"请输入收到的验证码";
    self.title = @"忘记密码";
    _forget.hidden = YES;
}
- (void)initController {
    [self showCustomNavigationBackButton];
    [self showCustomNavigationConfirmButton];
    self.view.backgroundColor = KCOLORGREEN_f2f2f2;
    self.title = @"修改密码";
    self.navigationRightButton.enabled = false;
}
- (void)initView {
    _currentPwdField = [self createField:0];
    [_currentPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCALE_NUM(28));
    }];
    
    _forget = [[UIButton alloc] init];
    [self.view addSubview:_forget];
    [_forget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-SCALE_NUM(10));
        make.height.mas_equalTo(SCALE_NUM(40));
        make.top.equalTo(_currentPwdField.mas_bottom);
    }];
    [_forget setTitle:@"忘记密码" forState:UIControlStateNormal];
    _forget.titleLabel.font = CONTENT_FONT(10);
    [_forget setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_forget addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    
    _pwdField = [self createField:1];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_forget.mas_bottom);
    }];
    
    _pwdRepeatField = [self createField:2];
    [_pwdRepeatField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdField.mas_bottom).offset(2);
    }];
    
    UILabel *info = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"请设置6位以上包含大小写英文／数字的密码" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [self.view addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_forget);
        make.top.equalTo(_pwdRepeatField.mas_bottom).offset(SCALE_NUM(12));
    }];
    
}
- (YTextField *)createField:(int)type {
    NSArray *names = @[@"请输入当前密码", @"请设置新密码", @"请确认新密码"];
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
    field.secureTextEntry = true;
    [field registerChanged:self action:@selector(checkComplete)];
    field.textColor = KCOLORGREEN_455A64;
    field.placeholder = names[type];
//    [field placeHolderColor:names[type] fontColor:KCOLORGREEN_455A64];
    return field;
}
- (void)forgetPwd {
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil
                                                              message:@"我们将发送验证码至你绑定的手机号上"
                                                         buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        if (index == 1) {
            [alert hide];
            [YUtils showHUDWithTitle];
            [[ProvisionManager sharedInstance] forgotPasswordReq:[[ProvisionManager sharedInstance] getLoginInfo].studentNo block:^(YActionMessage *message) {
                [YUtils hiddenProgressHUD];
                if (message.isSuccess) {
                    [self.navigationController pushViewController:[[ProfileChangePwdViewController alloc] initWithType:ProfileChangePwdTypeForget needLogin:NO] animated:true];
                }
                [YUtils showTitle:message.desc];
            }];
        } else {
            [alert hide];
        }
    }];
    [alert show];
}
- (void)checkComplete {
    if (_currentPwdField.text.length > 0 && _pwdField.text.length >= 6) {
        self.navigationRightButton.enabled = true;
    } else {
        self.navigationRightButton.enabled = false;
    }
}

- (void)onNavigationLeftButtonClicked {
    if (ProfileChangePwdTypeForget == _type) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
            UIViewController *viewController = self.navigationController.viewControllers[i];
            if ([viewController isKindOfClass:[ProfileMyViewController class]]) {
                [self.navigationController popToViewController:viewController animated:true];
                return;
            }
        }
    }
}

- (void)goLogin
{
    [YUtils showHUDWithTitle];
    //login
    [[ProvisionManager sharedInstance] goLogin:[YShareData defaultData][kShareData_StudentNo] password:_pwdField.text block:^(YActionMessage *message) {
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

- (void)onNavigationRightButtonClicked {
    if (![_pwdField.text isEqualToString:_pwdRepeatField.text]) {
        [YUtils showHUDWithTitle:@"密码两遍输入不一致"];
        return;
    }
    if (ProfileChangePwdTypeMod == _type) {
        MBProgressHUD *hud = [YUtils showHUDWithTitle:@"正在修改"];
        [[ProvisionManager sharedInstance] ModifyPassword:_pwdField.text oldPassWord:_currentPwdField.text block:^(YActionMessage *message) {
            [hud removeFromSuperview];
            if (message.isSuccess) {
                [YUtils showTitle:@"修改成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self onNavigationLeftButtonClicked];
                });
            } else {
                [YUtils showTitle:message.desc];
            }
        }];
    } else {
        [YUtils showHUDWithTitle];
        [[ProvisionManager sharedInstance] resetPwd:_currentPwdField.text password:_pwdField.text block:^(YActionMessage *message) {
            if (_needLogin) {
                if (message.isSuccess) {
                    //去登录
                    [self goLogin];
                }
            } else {
                [YUtils hiddenProgressHUD];
                [self.navigationController popViewControllerAnimated:YES];
                [YUtils showTitle:message.desc];
            }
        }];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}
@end
