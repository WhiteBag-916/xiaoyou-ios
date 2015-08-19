//
//  XYChoicePersonViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYChoicePersonViewController.h"
#import "ChoicePersonTableView.h"

#define kButtonItemHeightAndWidth           44
#define kCancleButtonItemWidth              55
#define kRightButtonWidth                   85

@interface XYChoicePersonViewController ()

@property(nonatomic,strong)ChoicePersonTableView * choicePersonTableView;

@end

@implementation XYChoicePersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    
}

-(void)setUpUI
{
    self.title = @"选人";
    [self showCustomNavigationCancelButton];
    
    
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRightButtonWidth, kButtonItemHeightAndWidth)];
    
    UIButton * cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kCancleButtonItemWidth, kButtonItemHeightAndWidth)];
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton setTitle:@"全不选" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelChoice) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * choiceButton = [[UIButton alloc] initWithFrame:CGRectMake(kCancleButtonItemWidth, 0, kButtonItemHeightAndWidth, kButtonItemHeightAndWidth)];
    choiceButton.backgroundColor = [UIColor clearColor];
    [choiceButton setImage:[UIImage imageNamed:@"complete"] forState:UIControlStateNormal];
    [choiceButton addTarget:self action:@selector(finishChoice) forControlEvents:UIControlEventTouchUpInside];

    [rightView addSubview:choiceButton];
    [rightView addSubview:cancelButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    

    
    _choicePersonTableView = [[ChoicePersonTableView alloc] init];
    [self.view addSubview:_choicePersonTableView];
    [_choicePersonTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
}


-(void)finishChoice
{
    NSLog(@"finish");
}

-(void)cancelChoice
{
    NSLog(@"cancel");
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
