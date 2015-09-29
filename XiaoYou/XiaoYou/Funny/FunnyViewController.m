//
//  FunnyViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FunnyViewController.h"
#import "FunnyListView.h"
@interface FunnyViewController ()
@property (nonatomic,strong) FunnyListView *funnyList;
@end

@implementation FunnyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self funnyList];
}


-(FunnyListView *)funnyList
{
    if (!_funnyList) {
        _funnyList = [[FunnyListView alloc]init];
        [self.view addSubview:_funnyList];
        [_funnyList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _funnyList;
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
