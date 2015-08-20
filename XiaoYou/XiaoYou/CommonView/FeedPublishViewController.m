//
//  FeedPublishViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedPublishViewController.h"
#import "YTextView.h"
#import "FeedImageGroup.h"

#define KTEXTVIEWMARGIN_LEFT SCALE_NUM(5)
#define KTEXTVIEWMARGIN_TOP SCALE_NUM(15)
#define KTEXTVIEWHEIGHT SCALE_NUM(60)

#define KIMGGROUPSIZE SCALE_NUM(242)
#define KIMGGROUPMARGIN_TOP SCALE_NUM(10)
#define KIMGGROUPMARGIN_LEFT SCALE_NUM(10)

@interface FeedPublishViewController()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) YTextView *textView;
@property (nonatomic, strong) FeedImageGroup *imgGroup;
@end

@implementation FeedPublishViewController
- (id)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}
- (void)initView {
    self.title = @"说两句";
    [self showCustomNavigationCancelButton];
    [self showCustomNavigationSureButton];
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _contentView = [[UIView alloc] init];
    [scroll addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self initTextView];
    [self initImgView];
}

- (void)initTextView {
    _textView = [[YTextView alloc] init];
    [_contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KTEXTVIEWMARGIN_LEFT);
        make.top.mas_equalTo(KTEXTVIEWMARGIN_TOP);
        make.height.mas_equalTo(KTEXTVIEWHEIGHT);
        make.centerX.equalTo(_contentView);
    }];
    _textView.placeholder = @"发布优质内容，会有更多人给你敬酒";
    _textView.placeholderColor = KCOLORWHITE_b8b7b7;
    _textView.font = CONTENT_FONT(12);
}

- (void)initImgView {
    _imgGroup = [[FeedImageGroup alloc] initWithCamera];
    [_contentView addSubview:_imgGroup];
    [_imgGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KIMGGROUPMARGIN_LEFT);
        make.top.equalTo(_textView.mas_bottom).offset(KIMGGROUPMARGIN_TOP);
        make.width.mas_equalTo(KIMGGROUPSIZE);
    }];
    [_imgGroup updateWithPhotos:@[[UIImage imageNamed:@"toolbar-mine-click"],[UIImage imageNamed:@"toolbar-mine-click"],[UIImage imageNamed:@"toolbar-mine-click"]] bigPics:@[@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg",@"http://cdn.duitang.com/uploads/item/201505/03/20150503184743_Q4EVW.thumb.700_0.jpeg"]];
}



- (void)onNavigationLeftButtonClicked {
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:false];
}


@end
