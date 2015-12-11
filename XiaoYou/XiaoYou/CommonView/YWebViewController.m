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
@property (strong,  nonatomic)  UIBarButtonItem *closeItem;
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
        _canClick = true;
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
    [self initNavigation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_canClick) {
        [self.webView.scrollView addObserver:self forKeyPath:@"contentSize"
                                     options:0 context:NULL];
    }
    [self.navigationController.navigationBar addSubview:_progressView];
    [self loadUrl];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!_canClick) {
        [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    }
    [_progressView removeFromSuperview];
}

- (void)initWebView {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _contentView = [[UIView alloc] init];
    [scroll addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
        make.width.equalTo(scroll);
    }];
    
    _webView = [[UIWebView alloc] init];
    [_contentView addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentView);
        if (_canClick) {
            make.height.equalTo(self.view);
        } else {
            make.height.mas_equalTo(100);
        }
    }];
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _webView.backgroundColor = [UIColor whiteColor];
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    _webView.userInteractionEnabled = _canClick;
    _webView.scalesPageToFit = true;
}

- (void)initProgress {
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    
    _progressView.progressBarView.backgroundColor = KCOLOR_009688;
    
}
- (void)initNavigation {
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 48, 34)];
    [backItem setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(10, 5, 10, 33)];
    [backItem setTitle:@"返回" forState:UIControlStateNormal];
    [backItem setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [backItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backItem setTitleColor:[UIColor hexChangeFloat:@"c3c9c9"] forState:UIControlStateDisabled];
    [backItem addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    backItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    
    
    UIButton * closeItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 29, 30)];
    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    [closeItem setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [closeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeItem setTitleColor:[UIColor hexChangeFloat:@"c3c9c9"] forState:UIControlStateDisabled];
    [closeItem addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    closeItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
    _closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeItem];
    self.navigationItem.leftBarButtonItems = @[item, _closeItem];
    _closeItem.customView.hidden = true;

}
- (void)close {
    [self.navigationController popViewControllerAnimated:true];
}
- (void)goBack {
    if (_webView.canGoBack) {
        [_webView goBack];
        _closeItem.customView.hidden = false;
    } else {
        [self close];
    }
}
- (void)loadUrl {
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:req];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"] && [object isEqual:self.webView.scrollView]) {
        [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.webView.scrollView.contentSize.height);
        }];
    }
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.title.length == 0) {
        self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
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
