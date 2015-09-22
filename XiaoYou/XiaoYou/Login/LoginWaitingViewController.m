//
//  LoginWaitingViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/9/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "LoginWaitingViewController.h"
#import "ProvisionManager.h"
#import "AppDelegate+RootVC.h"
#import "YSystemDefine.h"
#import "YModel+ActionMessage.h"

@interface LoginWaitingViewController ()

@end

@implementation LoginWaitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    if (isScreen3_5Inch) {
        bgImageView.image = [UIImage imageNamed:@"background-start"];
    } else if (isScreen4Inch) {
        bgImageView.image = [UIImage imageNamed:@"background-start-568h"];
    } else if (isScreen4_7Inch) {
        bgImageView.image = [UIImage imageNamed:@"background-start-6"];
    } else {
        bgImageView.image = [UIImage imageNamed:@"background-start-6p"];
    }
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self toLogin];
}

- (void)toLogin {
    //用userDefaults里的值登录
    NSString *studentNo = [[NSUserDefaults standardUserDefaults] objectForKey:kShareData_StudentNo];
    NSString *loginPassword = [[NSUserDefaults standardUserDefaults] objectForKey:kShareData_LoginPassword];
    [YShareData defaultData][kShareData_SchoolCode] = [[NSUserDefaults standardUserDefaults] objectForKey:kShareData_SchoolCode];
    
    if (nil == studentNo || nil == loginPassword) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Server_Token_Fail object:@{@"des":@"您的账号已在别的地方登录"}];
    } else {
        [YUtils showHUDWithTitle:@""];
        [[ProvisionManager sharedInstance] goLogin:studentNo
                                          password:loginPassword
                                             block:^(YActionMessage *message) {
                                                 [YUtils hiddenProgressHUD];
                                                 if (message.isSuccess) {
                                                     //成功
                                                     [kAppDelegateAccessor initTabBarNC];
                                                 } else {
                                                     [kAppDelegateAccessor initChooseSchoolNC];
                                                     [YUtils showTitle:message.desc];
                                                 }
                                             }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
