//
//  CNTextController.m
//  CampusNet
//
//  Created by AndLiSoft on 15/6/18.
//  Copyright (c) 2015年 AndLiSoft. All rights reserved.
//

#import "CNTextController.h"
#import "Masonry.h"

@interface CNTextController ()
@property (strong, nonatomic) UIWebView *textWebView;
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
    
    _textWebView = [[UIWebView alloc]init];
    _textWebView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_textWebView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"OK" forState:UIControlStateNormal];
    [button setBackgroundColor:KCOLORGREEN_009688];
    [button addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = YES;
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-14);
        make.left.mas_equalTo(0);
    }];
    
    if (TextTermsOfAgreementType == _textType)
    {
        self.title = @"用户条款";
        button.hidden = NO;
        [_textWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.mas_equalTo(SCALE_NUM(-75));
        }];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ServiceTerms" ofType:@"html"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        [_textWebView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
    }
    else
    {
        [_textWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [_textWebView loadData:[SStr(_strText) dataUsingEncoding:NSUnicodeStringEncoding] MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
    }
}

- (void)dissmiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
