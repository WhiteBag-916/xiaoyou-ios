//
//  YWebViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface YWebViewController () <NJKWebViewProgressDelegate, UIWebViewDelegate>
@property (copy,    nonatomic)  NSString *url;
@property (assign,  nonatomic)  BOOL canClick;
@property (strong,  nonatomic)  NJKWebViewProgressView *progressView;
@property (strong,  nonatomic)  NJKWebViewProgress *progressProxy;
@property (strong,  nonatomic)  UIWebView *webView;

@property (strong,  nonatomic)  UIView *contentView;

@end

@implementation YWebViewController

- (id)initWithUrl:(NSString *)url andTitle:(NSString *)title canClick:(BOOL)canClick {
    if (self = [super init]) {
        _url = url;
        if (![[_url substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"t"]) {
            _url = [@"http://" stringByAppendingString:_url];
        }
        self.title = title;
        _canClick = canClick;
        self.hidesBottomBarWhenPushed = true;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showCustomNavigationBackButton];
    [self IsShowCustomNavigationMoreButton:NO];
    [self initWebView];
    [self initProgress];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    [self loadUrl];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (void)initWebView {
    
//    UIScrollView *scroll = [[UIScrollView alloc] init];
//    [self.view addSubview:scroll];
//    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
//    
//    
//    _contentView = [[UIView alloc] init];
//    [scroll addSubview:_contentView];
//    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(scroll);
//        make.width.equalTo(scroll);
//    }];
    _webView = [[UIWebView alloc] init];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _webView.backgroundColor = [UIColor whiteColor];
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    _webView.userInteractionEnabled = true;
}

- (void)initProgress {
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    
    _progressView.progressBarView.backgroundColor = KCOLOR_009688;
    
    
}
- (void)loadUrl {
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:req];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType != UIWebViewNavigationTypeOther) {
        return NO || _canClick;
    }
    return YES;
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
//    if (!_canClick && progress == 1.0) {
//        CGFloat height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"] floatValue];
//        [_webView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(height);
//        }];
//    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressView setProgress:1 animated:true];
    if([error code] == NSURLErrorCancelled) {
        return;
    }
    
    UIView *infoView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:infoView];
    infoView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [infoView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(90));
        make.top.mas_equalTo(135);
    }];
    imgView.image = [UIImage imageNamed:@"news_pic_beautiful"];
    
    
}
@end
