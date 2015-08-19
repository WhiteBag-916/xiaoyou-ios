//
//  SearchResultViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SearchResultViewController.h"
#import "FeedContactTableView.h"
#import "YUtils+Component.h"

@interface SearchResultViewController ()

@property (nonatomic, strong) FeedContactTableView *feedContactTableView;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"搜索结果";
    [self showCustomNavigationBackButton];
    
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = KCOLORGREEN_e6eae9;
    //结果
    NSString *nameStr = @"";
    if (_searchName.length > 0) {
        [_searchCondition addObject:@"姓名"];
        nameStr = [NSString stringWithFormat:@"人名 %@", _searchName];
    }
    NSString *searchConditionStr = [_searchCondition componentsJoinedByString:@"|"];
    NSString *text = [NSString stringWithFormat:@"根据条件 %@ 搜索%@", searchConditionStr, nameStr];
    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithString:text];
    
    //搜索字变色
    NSRange searchConditionStrRange = [text rangeOfString:searchConditionStr];
    NSRange searchNameRange = [text rangeOfString:_searchName];
    [contentText addAttributes:@{NSStrokeWidthAttributeName : @0,
                                 NSForegroundColorAttributeName : KCOLORGREEN_009688,
                                 NSUnderlineColorAttributeName: KCOLORWHITE_696969,
                                 NSFontAttributeName:CONTENT_FONT(12)}
                         range:searchConditionStrRange];
    [contentText addAttributes:@{NSStrokeWidthAttributeName : @0,
                                 NSForegroundColorAttributeName : KCOLORGREEN_009688,
                                 NSUnderlineColorAttributeName: KCOLORWHITE_696969,
                                 NSFontAttributeName:CONTENT_FONT(12)}
                         range:searchNameRange];
    //构建label
    UILabel *contentLabel = [YUtils initLabel:CONTENT_FONT(12)
                                        color:KCOLORWHITE_696969
                                         text:@""
                                        frame:CGRectZero
                                    alignment:NSTextAlignmentLeft];
    [contentLabel setAttributedText:contentText];
    [self.view addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(15));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(47));
        make.right.mas_equalTo(SCALE_NUM(-15));
    }];
    
    //table
    _feedContactTableView = [[FeedContactTableView alloc] init];
    [self.view addSubview:_feedContactTableView];
    [_feedContactTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(contentLabel.mas_bottom);
    }];
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
