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
#import "YCommonReport.h"
#import "YCommonAlertView.h"

#define kNavigationgRightWidthAndHeight         40

@interface XYContactsInfoDetailViewController ()

@property(nonatomic,strong)ContactsInfoDetailTableView * contactsInfoDetailTableView;
@property(nonatomic,strong)UIButton * bottomButton;
@property   (nonatomic, strong) NSDictionary *shareData;

@end

@implementation XYContactsInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    [[ContactManager sharedInstance] getUserDetailInfo:_uid block:^(YActionMessage *message) {
        if (message.isSuccess) {
            ProfileInfo * model = message.object;
            _shareData = @{@"name":model.userName, @"pic":model.headPic, @"school":model.schoolName};
            [_contactsInfoDetailTableView refreshTableView:model];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
    
    [self showCustomNavigationBackButton];
    
    
}



-(void)setUpUI
{
    self.title = @"详情";
    [self showCustomNavigationMoreButton];
    
    _contactsInfoDetailTableView = [[ContactsInfoDetailTableView alloc] init];
    _contactsInfoDetailTableView.myController = self;
    _contactsInfoDetailTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contactsInfoDetailTableView];
    
    [_contactsInfoDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-KTabBarheight);
    }];
    
    _bottomButton = [[UIButton alloc] init];
    [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_bottomButton];
    
    [_bottomButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
    if ([[ContactManager sharedInstance] isFriendRelationShip:_uid])
    {
        _studentDic = [[[ContactManager sharedInstance] getFriendInfo:_uid] dictionaryRepresentation];
        [_bottomButton addTarget:self action:@selector(clickBottomButton) forControlEvents:UIControlEventTouchUpInside];
        [_bottomButton setTitle:@"聊聊呗" forState:UIControlStateNormal];
    }
    else
    {
        _bottomButton.enabled = NO;
        [_bottomButton setTitle:@"你们还不是好友" forState:UIControlStateNormal];
    }
    
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

-(void)onNavigationRightButtonClicked
{
    if (_shareData == nil) {
        [YUtils showTitle:@"无网络连接"];
        return;
    }
    YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeSharePerson title:@"分享该人名片至" extraData:_shareData];
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"消息不提醒"
                                                         type:YCommonActionSheetItemTypeSwitch
                                                         open:YES
                                                        block:^(NSInteger checkNum) {
                                                            
                                                        }];
    
    YActionSheetItem *item3 = [YActionSheetItem itemWithTitle:@"解除好友关系"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                           YCommonAlertView * alertView = [[YCommonAlertView alloc] initWithTitle:nil message:@"确定解除好友关系？" buttonTitles:@"确定",@"取消", nil];
                                                            [alertView clickedButtonHandler:^(NSInteger index) {
                                                                if (index == 0) {
                                                                    [self deleteFriends];
                                                                }
                                                           
                                                            }];
                                                            [alertView show];
                                                        }];
    YActionSheetItem *item4 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            [YCommonReport report];
                                                        }];
    
    if ([[ContactManager sharedInstance] isFriendRelationShip:_uid])
    {
        YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2, item3, item4] title:nil];
        [sheet show];
    }
    else
    {
        
        YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item4] title:nil];
        [sheet show];
    }
    
}

- (void)deleteFriends
{
    [YUtils showHUDWithTitle];
    [[ContactManager sharedInstance] delLinkMan:_studentDic[@"uid"] block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        if (message.isSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [YUtils showTitle:message.desc hideAfter:2];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
