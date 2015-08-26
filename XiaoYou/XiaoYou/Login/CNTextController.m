//
//  CNTextController.m
//  CampusNet
//
//  Created by AndLiSoft on 15/6/18.
//  Copyright (c) 2015年 AndLiSoft. All rights reserved.
//

#import "CNTextController.h"
#import "CNSchoolModel.h"
#import "CNUserData.h"
#import "UIColor+HexString.h"
#import "Masonry.h"
#import "NNApiClient.h"
#import "UserInfo.h"
#import "MBProgressHUD+SC.h"
#import "CNUserData.h"
#import "CNUserTool.h"
#import "APService.h"
#import "CNMainController.h"
#import "AppDelegate.h"

@interface CNTextController ()<UIWebViewDelegate>
@property (weak, nonatomic) UITextView *textView;
@property (weak, nonatomic) UIWebView *textWebView;
@property (nonatomic, strong)NNApiClient *loginClient;
@end

@implementation CNTextController

- (void)dealloc
{
    //释放
    if ([self.textWebView isLoading]) {
        [self.textWebView stopLoading];
    }
    self.textWebView.delegate = nil;
    self.textWebView.scrollView.delegate = nil;
    self.textWebView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *textWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0.f, NAV_BAR_HEIGHT, self.view.width, self.view.height - NAV_BAR_HEIGHT)];
    textWebView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textWebView];
    _textWebView = textWebView;
    _textWebView.delegate = self;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"同意并继续" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithHexString:@"23876f"]];
    [button addTarget:self action:@selector(loginRequest) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = YES;
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-14);
        make.left.mas_equalTo(0);
    }];
    
    NSString *contentText = (nil == _strText) ? @"" : _strText;
    if (TextTermsOfAgreementType == _textType)
    {
        self.title = @"服务条款";
        contentText = @"同意并继续";
        button.hidden = NO;
        _textWebView.frame = CGRectMake(0.f, NAV_BAR_HEIGHT, self.view.width, self.view.height - NAV_BAR_HEIGHT-75);
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ServiceTerms" ofType:@"html"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        [_textWebView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
    }
    else
    {
        [_textWebView loadData:[contentText dataUsingEncoding:NSUnicodeStringEncoding] MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//登录请求
-(void)loginRequest{
    if (_loginClient.isExecuting) {
        [_loginClient cancel];
    }
    if (_loginClient == nil) {
        __weak typeof(self) wekSelf = self;
        _loginClient = [[NNApiClient alloc]initWithFinish:^(NNApiClient *apiClient, NSObject *target) {
            UserInfo *response = (UserInfo *)target;
            BOOL success =  YES;
            [wekSelf loginRequestSuccess:success response:response message:nil];
        } bizError:^(NNApiClient *apiClient, NNBizError *bizError) {
            [wekSelf loginRequestSuccess:NO response:nil message:bizError.errorMsg];
        } fail:^(NNApiClient *apiClient, NSError *error, NSString *message) {
            [wekSelf loginRequestSuccess:NO response:nil message:message];
        }];
    }
    
    [self.mbLoadingView show:YES];
    
    UserInfo *info = [CNUserData sharedUserData].userInfo;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"schoolCode"] = [CNUserData sharedUserData].schoolInfo.schoolCode;
    dic[@"studentNo"] = info.studentNo;
    dic[@"password"] = info.password;
    dic[@"deviceId"] = [NSString stringWithFormat:@"%@%@",info.studentNo,[CNUserData sharedUserData].schoolInfo.schoolCode];
    dic[@"platform"] = @(2);//ios
    if ([CNUserData sharedUserData].mobilePhone.length > 0)
    {
        dic[@"mobilePhone"] = [CNUserData sharedUserData].mobilePhone;
    }
    
    [_loginClient sendRequestPost:api_user_login postObject:nil params:dic withMapping:[UserInfo objectMapping]];
    
}
- (void)loginRequestSuccess:(BOOL)success response:(UserInfo *)userInfo message:(NSString *)message{
    [self.mbLoadingView hide:YES];
    if (success) {
        if (![[CNUserData sharedUserData].userInfo.studentNo isEqualToString:userInfo.studentNo]) {
            [CNUserData sharedUserData].localChatList = nil;
            [CNUserData sharedUserData].contactList = nil;
        }
        [CNUserData sharedUserData].userInfo = userInfo;
        [CNUserData sharedUserData].everLogin = YES;
        [CNUserData sharedUserData].logOut = NO;
        //登陆成功后，学号切换，加载聊天记录
        [CNUserTool loadLocalChatMessages];
        [CNUserTool saveUserData];
        NSLog(@"set jpush %@", [NSString stringWithFormat:@"%@%@",userInfo.studentNo,userInfo.schoolCode]);
        [APService setAlias:[NSString stringWithFormat:@"%@%@",userInfo.studentNo,userInfo.schoolCode] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        
        CNMainController *mainVc = [[CNMainController alloc]init];
        UINavigationController *Navc = [[UINavigationController alloc] initWithRootViewController:mainVc];
        AppDelegateAccessor.window.rootViewController = Navc;
    }else{
        ALDebug(@"%@",message);
        [MBProgressHUD showOnlyText:message toView:self.view];
        //        [self showAlertViewWithMessage:@"输入错误，请重新输入哦！"];
    }
}

#pragma mark - 极光推送设置别名回调方法
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"CNTextController rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
    if (iResCode != 0) {
        [APService setAlias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    }
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //字体大小
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '330%'"];
    //字体颜色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
    //页面背景色
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2E2E2E'"];
}
@end
