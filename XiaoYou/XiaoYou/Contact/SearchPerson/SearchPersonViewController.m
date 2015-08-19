//
//  SearchPersonViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SearchPersonViewController.h"
#import "YTextField.h"
#import "TagListTableView.h"
#import "SearchFilterViewController.h"
#import "SearchResultViewController.h"

@interface SearchPersonViewController ()
<UITextFieldDelegate>

@property (nonatomic, strong) YTextField *textField;
@property (nonatomic, strong) TagListTableView *tagListTableView;
@property (nonatomic, strong) NSArray *chooseFiterArray;

@end

@implementation SearchPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    [self showCustomNavigationSearchButton];
    self.title = @"找人";
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resetRightButton];
}

- (void)initView
{
    //编辑框边框
    UIView *textFieldBgView = [[UIView alloc] init];
    textFieldBgView.backgroundColor = KCOLORWHITE;
    [self.view addSubview:textFieldBgView];
    [textFieldBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(SCALE_NUM(43));
    }];
    
    //filter
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton setImage:[UIImage imageNamed:@"toast_cup"] forState:UIControlStateNormal];
    [filterButton setImage:[UIImage imageNamed:@"toast_cup"] forState:UIControlStateHighlighted];
    [filterButton addTarget:self action:@selector(pressFilterButton) forControlEvents:UIControlEventTouchUpInside];
    [textFieldBgView addSubview:filterButton];
    [filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(textFieldBgView);
        make.right.mas_equalTo(SCALE_NUM(-10));
        make.width.mas_equalTo(SCALE_NUM(16));
    }];
    
    //编辑框
    _textField = [[YTextField alloc] init];
    _textField.font = CONTENT_FONT(12);
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.enablesReturnKeyAutomatically = YES;
    _textField.placeholder = @"请输入姓名或设置删选条件搜索";
    [_textField registerChanged:self action:@selector(textFieldEditingChanged:)];
    [textFieldBgView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(textFieldBgView);
        make.left.mas_equalTo(SCALE_NUM(14));
        make.right.equalTo(filterButton.mas_left).offset(SCALE_NUM(-14));
    }];
    
    //tagListTableView
    _tagListTableView = [[TagListTableView alloc] initWithType:TagSearchType];
    [self.view addSubview:_tagListTableView];
    [_tagListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(textFieldBgView.mas_bottom).offset(SCALE_NUM(15));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [_tagListTableView addGestureRecognizer:tap];
}

- (void)endEdit {
    [self.view endEditing:YES];
}

//筛选
- (void)pressFilterButton
{
    SearchFilterViewController *searchFilterViewController = [[SearchFilterViewController alloc] init];
    [searchFilterViewController endSelected:^(NSArray *select) {
        self.chooseFiterArray = [NSArray arrayWithArray:select];
        [_tagListTableView setData:_chooseFiterArray];
    }];
    searchFilterViewController.isSelectArray = [NSArray arrayWithArray:_chooseFiterArray];
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:searchFilterViewController];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

//重置右上角按钮是否可点
- (void)resetRightButton
{
    //判断
    if (_textField.text.length > 0)
    {
        self.navigationRightButton.userInteractionEnabled = YES;
        [self.navigationRightButton setImage:[UIImage imageNamed:@"feed-find-someone-search"] forState:UIControlStateNormal];
    }
    else
    {
        self.navigationRightButton.userInteractionEnabled = NO;
        [self.navigationRightButton setImage:[UIImage imageNamed:@"feed-find-someone-search-grey"] forState:UIControlStateNormal];
    }
}

- (void)onNavigationRightButtonClicked {
    [self toSearchResult];
}

- (void)toSearchResult {
    SearchResultViewController *searchResultViewController = [[SearchResultViewController alloc] init];
    searchResultViewController.searchCondition = [[NSMutableArray alloc] initWithArray:_chooseFiterArray];
    searchResultViewController.searchName = _textField.text;
    [self.navigationController pushViewController:searchResultViewController animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldEditingChanged:(UITextField *)theTextField
{
    [self resetRightButton];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self toSearchResult];
    
    return YES;
}

@end
