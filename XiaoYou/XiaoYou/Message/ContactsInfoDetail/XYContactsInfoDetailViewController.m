//
//  XYContactsInfoDetailViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/14.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYContactsInfoDetailViewController.h"
#import "ContactsInfoDetailTableView.h"
#import "YCommonActionSheet.h"
#import "ContactManager.h"
#import "ProfileInfo.h"
#import "ChatViewController.h"

#define kNavigationgRightWidthAndHeight         40

@interface XYContactsInfoDetailViewController ()

@property(nonatomic,strong)ContactsInfoDetailTableView * contactsInfoDetailTableView;
@property(nonatomic,strong)UIButton * bottomButton;

@end

@implementation XYContactsInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    
    [[ContactManager sharedInstance] getUserDetailInfo:_uid block:^(YActionMessage *message) {
        ProfileInfo * model = message.object;
        [_contactsInfoDetailTableView refreshTableView:model];
    }];
    
    [self showCustomNavigationBackButton];
    
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated navigationBarHidden:NO tabBarHidden:YES];
//}

-(void)viewWillLayoutSubviews
{
    self.hidesBottomBarWhenPushed = NO;
}

-(void)setUpUI
{
    self.title = @"详情";
    
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kNavigationgRightWidthAndHeight, kNavigationgRightWidthAndHeight)];
    [shareButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(showShareActionSheet) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    _contactsInfoDetailTableView = [[ContactsInfoDetailTableView alloc] init];
    _contactsInfoDetailTableView.myController = self;
    _contactsInfoDetailTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contactsInfoDetailTableView];
    
    [_contactsInfoDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-KNavigationBarheight);
    }];
    
    _bottomButton = [[UIButton alloc] init];
    [_bottomButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];    [_bottomButton setTitle:@"聊聊呗" forState:UIControlStateNormal];
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
        if ([_studentDic[@"linkType"] doubleValue] == 0) {
            ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:_studentDic[@"thirdCode"] isGroup:NO];
            chatVC.isSystemMessage = NO;
            chatVC.studentDic = _studentDic;
            [self.navigationController pushViewController:chatVC animated:YES needHiddenBottomBar:YES];
        }
        else
        {
            ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:_studentDic[@"thirdCode"] isGroup:YES];
            chatVC.isSystemMessage = NO;
            chatVC.studentDic = _studentDic;
            [self.navigationController pushViewController:chatVC animated:YES needHiddenBottomBar:YES];
        }
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
