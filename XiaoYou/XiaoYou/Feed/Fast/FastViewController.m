//
//  FastViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FastViewController.h"
#import "BottomView.h"
#import "TopView.h"
@interface FastViewController ()

@property (nonatomic,retain) TopView    *topView;
@property (nonatomic,retain) BottomView *bottomView;

@end

@implementation FastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"FAST CONNECTION";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.topView.backgroundColor = [UIColor lightGrayColor];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(300);
    }];
    
    BottomView *bottomView = [[BottomView alloc]init];
    [self.view addSubview:bottomView];
    self.bottomView.backgroundColor = [UIColor cyanColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).width.offset(2);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    
    
}



-(BottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

-(TopView *)topView {
    if (!_topView) {
        _topView = [TopView topView];
        [self.view addSubview:_topView];
    }
    return _topView;
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
