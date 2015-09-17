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
@property (nonatomic, assign) BOOL isFriendRelationShip;//需要是好友

@end

@implementation XYContactsInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    
    [YUtils showHUDWithTitle];
    [[ContactManager sharedInstance] getUserDetailInfo:_uid hxId:_hxId block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        if (message.isSuccess) {
            ProfileInfo * model = message.object;
            _shareData = @{model.uid:@"userId", @"name":model.userName, @"pic":model.headPic, @"school":model.schoolName};
            [_contactsInfoDetailTableView refreshTableView:model];
            
            _uid = model.uid;
            _bottomButton.enabled = YES;
            [self updateStatus:model.friendStatus];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}

-(void)setUpUI
{
    self.title = @"详情";
    [self showCustomNavigationBackButton];
    
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
    _bottomButton.enabled = NO;
    [_bottomButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
    _isFriendRelationShip = [[ContactManager sharedInstance] isFriendRelationShip:_uid];
    [_bottomButton addTarget:self action:@selector(clickBottomButton) forControlEvents:UIControlEventTouchUpInside];
    if (_isFriendRelationShip)
    {
        _studentDic = [[[ContactManager sharedInstance] getFriendInfo:_uid] dictionaryRepresentation];
        [_bottomButton setTitle:@"聊聊呗" forState:UIControlStateNormal];
        
        [self showCustomNavigationMoreButton];
    }
    else
    {
        [_bottomButton setTitle:@"添加好友" forState:UIControlStateNormal];
    }
    
    [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(KTabBarheight);
    }];
}

#pragma mark - 更新bottomButton
- (void)updateStatus:(NSString *)status {
    if ([status isEqualToString:@"2"]) {
        _bottomButton.enabled = NO;
        [_bottomButton setTitle:@"好友申请已发送" forState:UIControlStateNormal];
    } else {
        _bottomButton.enabled = YES;
    }
}

#pragma mark - 点击bottomButton事件
-(void)clickBottomButton
{
    if (!_isFriendRelationShip) {
        //展示提示
        YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil
                                                                  message:[NSString stringWithFormat:@"确定向%@发送好友申请吗？", _shareData[@"name"]]
                                                             buttonTitles:@"取消",@"确认", nil];
        [alert clickedButtonHandler:^(NSInteger index) {
            if (1 == index) {
                //添加好友
                [YUtils showHUDWithTitle:@"发送中"];
                [[ContactManager sharedInstance] submitFriendApply:_uid block:^(YActionMessage *message) {
                    [YUtils hiddenProgressHUD];
                    if (message.isSuccess) {
                        [self updateStatus:@"2"];
                    }
                    
                    [YUtils showTitle:message.desc];
                }];
            }
        }];
        [alert show];
    } else {
        if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[ChatViewController class]]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:_studentDic[@"thirdCode"] isGroup:NO];
            chatVC.isSystemMessage = NO;
            chatVC.studentDic = [_studentDic mutableCopy];
            [self.navigationController pushViewController:chatVC animated:YES needHiddenBottomBar:YES];
        }
    }
}

#pragma mark - 导航右ActionSheetItem
-(void)onNavigationRightButtonClicked
{
    if (_shareData == nil) {
        [YUtils showTitle:@"无网络连接"];
        return;
    }
    YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeSharePerson title:@"分享该人名片至" extraData:_shareData];
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"消息不提醒"
                                                         type:YCommonActionSheetItemTypeSwitch
                                                      isGroup:NO
                                                         open:[self isRemind]
                                                    extraData:@{@"uid":self.uid}];
    
    YActionSheetItem *item3 = [YActionSheetItem itemWithTitle:@"解除好友关系"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                           YCommonAlertView * alertView = [[YCommonAlertView alloc] initWithTitle:nil message:@"确定解除好友关系？" buttonTitles:@"取消",@"确定", nil];
                                                            [alertView clickedButtonHandler:^(NSInteger index) {
                                                                if (index == 1) {
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
#pragma mark - 删除好友事件
- (void)deleteFriends
{
    [YUtils showHUDWithTitle];
    [[ContactManager sharedInstance] delLinkMan:_studentDic[@"uid"] block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        if (message.isSuccess) {
            if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[ChatViewController class]] && self.navigationController.viewControllers.count >= 3) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
        [YUtils showTitle:message.desc];
        
    }];
}

#pragma mark - 判断消息是否提醒
-(BOOL)isRemind
{
    //获取该人的详情
    LinkManList *man = [[ContactManager sharedInstance] getManById:_uid];
    
    //消息提醒
    if ([man.isRemind isEqualToString:@"n"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
