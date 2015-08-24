//
//  XYGroupInfoDetailViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYGroupInfoDetailViewController.h"
#import "GroupInfoDetailCollectionView.h"
#import "YCommonActionSheet.h"
#import "ChatViewController.h"

#define kNavigationgLeftWidth                   9
#define kNavigationgLeftHeight                  14
#define kNavigationgRightWidthAndHeight         40

@interface XYGroupInfoDetailViewController ()

@property (nonatomic,strong) GroupInfoDetailCollectionView * groupInfoDetailCollectionView;

@property(nonatomic,strong)UIButton * bottomButton;


@end

@implementation XYGroupInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    [self setUpUI];
    
}

-(void)setUpUI
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kNavigationgLeftWidth, kNavigationgLeftHeight)];
    [backButton setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kNavigationgRightWidthAndHeight, kNavigationgRightWidthAndHeight)];
    [shareButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(showShareActionSheet) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(70, 70);
    _groupInfoDetailCollectionView = [[GroupInfoDetailCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-KTabBarheight-KNavigationBarheight) collectionViewLayout:flowLayout];
    [self.view addSubview:_groupInfoDetailCollectionView];
    
    _bottomButton = [[UIButton alloc] init];
    [_bottomButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
    [_bottomButton setTitle:@"进入群聊" forState:UIControlStateNormal];
    [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_bottomButton addTarget:self action:@selector(clickBottomButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomButton];
    [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(KTabBarheight);
    }];
}

-(void)clickBottomButton
{
    ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:_studentDic[@"thirdCode"] isGroup:YES];
    chatVC.isSystemMessage = NO;
    chatVC.studentDic = _studentDic;
    [self.navigationController pushViewController:chatVC animated:YES needHiddenBottomBar:YES];
}

-(void)showShareActionSheet
{
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"分享这社团名片至"
                                                         type:YCommonActionSheetItemTypeShare
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"消息不提醒"
                                                         type:YCommonActionSheetItemTypeSwitch
                                                         open:YES
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YActionSheetItem *item3 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2, item3] title:nil];
    [sheet show];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
