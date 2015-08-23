





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
@interface ProfileChangePwdViewController()

@property (nonatomic, strong) YTextField *currentPwdField;

@property (nonatomic, strong) YTextField *pwdField;

@property (nonatomic, strong) YTextField *pwdRepeatField;
@end

@implementation ProfileChangePwdViewController

- (id)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = true;
    }
    return self;
}
- (void)viewDidLoad {
    [self initController];
    [self initView];
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
    
    UIButton *forget = [[UIButton alloc] init];
    [self.view addSubview:forget];
    [forget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-SCALE_NUM(10));
        make.height.mas_equalTo(SCALE_NUM(40));
        make.top.equalTo(_currentPwdField.mas_bottom);
    }];
    [forget setTitle:@"忘记密码" forState:UIControlStateNormal];
    forget.titleLabel.font = CONTENT_FONT(10);
    [forget setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forget addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    
    _pwdField = [self createField:1];
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forget.mas_bottom);
    }];
    
    _pwdRepeatField = [self createField:2];
    [_pwdRepeatField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdField.mas_bottom).offset(2);
    }];
    
    UILabel *info = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor blackColor] text:@"请设置6位以上包含大小写英文／数字的密码" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [self.view addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(forget);
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
    [field registerChanged:self action:@selector(checkComplete)];
    [YTextField placeHolderColor:field normalString:names[type] fontColor:KCOLORGREEN_455A64];
    return field;
}
- (void)forgetPwd {
    NSLog(@"忘记密码函数");
}
- (void)checkComplete {
    if (_currentPwdField.text.length > 0 && _pwdField.text.length >= 6 && [_pwdField.text isEqualToString:_pwdRepeatField.text]) {
        self.navigationRightButton.enabled = true;
    } else {
        self.navigationRightButton.enabled = false;
    }
}

- (void)onNavigationLeftButtonClicked {
    for (int i = 0; i < self.navigationController.viewControllers.count; i++) {
        UIViewController *viewController = self.navigationController.viewControllers[i];
        if ([viewController isKindOfClass:[ProfileMyViewController class]]) {
            [self.navigationController popToViewController:viewController animated:true];
            return;
        }
    }
}

- (void)onNavigationRightButtonClicked {
    NSLog(@"修改密码");
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = false;
}
@end
