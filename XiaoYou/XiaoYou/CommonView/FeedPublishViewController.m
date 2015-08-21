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
#import "SKTagView.h"

#define KTEXTVIEWMARGIN_LEFT SCALE_NUM(5)
#define KTEXTVIEWMARGIN_TOP SCALE_NUM(15)
#define KTEXTVIEWHEIGHT SCALE_NUM(60)

#define KIMGGROUPSIZE SCALE_NUM(242)
#define KIMGGROUPMARGIN_TOP SCALE_NUM(10)
#define KIMGGROUPMARGIN_LEFT SCALE_NUM(10)

#define KLINEMARGIN SCALE_NUM(15)

@interface FeedPublishViewController()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) YTextView *textView;
@property (nonatomic, strong) FeedImageGroup *imgGroup;
@property (nonatomic, strong) SKTagView *tagView;
@property (nonatomic, strong) NSMutableArray *isChecked;

@end

@implementation FeedPublishViewController
- (id)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _isChecked = [NSMutableArray array];
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
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
    [self initBottom];
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

- (void)initBottom {
    UIImageView *line = [[UIImageView alloc] init];
    [_contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgGroup);
        make.centerX.equalTo(_contentView);
        make.height.mas_equalTo(1);
        make.top.equalTo(_imgGroup.mas_bottom).offset(KLINEMARGIN);
    }];
    line.backgroundColor = [UIColor blackColor];
    
    UILabel *info = [[UILabel alloc] init];
    [_contentView addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line);
        make.top.equalTo(line.mas_bottom).offset(KLINEMARGIN);
        make.height.mas_equalTo(SCALE_NUM(10));
    }];
    info.font = CONTENT_FONT(10);
    info.text = @"选择以下标签，动态将会同步进入选中标签的列表中";
    
    _tagView = [[SKTagView alloc] init];
    [_contentView addSubview:_tagView];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(info);
        make.top.equalTo(info.mas_bottom).offset(KLINEMARGIN);
        make.bottom.lessThanOrEqualTo(_contentView);
    }];
    _tagView.insets = 5;
    _tagView.lineSpace = 5;
    __weak FeedPublishViewController *weakSelf = self;
    [_tagView setDidClickTagAtIndex:^(NSUInteger index) {
        BOOL isCheck = [weakSelf.isChecked[index] boolValue];
        isCheck = !isCheck;
        weakSelf.isChecked[index] = [NSNumber numberWithBool:isCheck];
        [weakSelf.tagView updateTag:isCheck atIndex:index];
    }];
    [self loadTag];
}

- (void)loadTag {
    NSArray *labelName = @[@"金融", @"留学咨询", @"学校生活", @"工作", @"互联网信息"];
    for (int i = 0; i < labelName.count; i++) {
        [_isChecked addObject:[NSNumber numberWithBool:false]];
        SKTag *tag = [SKTag tagWithText:labelName[i]];
        [tag updateWithPublishSelectType:false];
        [_tagView addTag:tag];
    }

}

- (void)onNavigationLeftButtonClicked {
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:false];
}


@end
