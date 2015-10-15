//
//  ActivityChoiceController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityChoiceController.h"
#import "ActivityChoiceTableView.h"

@interface ActivityChoiceController ()

@property (nonatomic,strong)ActivityChoiceTableView * activityChoiceTableView;

@end

@implementation ActivityChoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

-(void)setUpUI
{
    _activityChoiceTableView = [[ActivityChoiceTableView alloc] init];
    _activityChoiceTableView.myController = self;
    [self.view addSubview:_activityChoiceTableView];
    [_activityChoiceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.mas_equalTo(0);
    }];
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
