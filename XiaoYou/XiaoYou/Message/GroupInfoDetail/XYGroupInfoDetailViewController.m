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
#import "ContactManager.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"
#import "GroupDetail.h"
#import "YCommonReport.h"
#import "GroupModel.h"
#import "MessageManager.h"
#import "ContactManager.h"
#import "ClassList.h"
#import "YUtils+HUD.h"

#define kNavigationgLeftWidth                   9
#define kNavigationgLeftHeight                  14
#define kNavigationgRightWidthAndHeight         40

NSString *const kXYGroupInfoDetailViewController = @"XYGroupInfoDetailViewControllerId";

@interface XYGroupInfoDetailViewController ()

@property (nonatomic,strong) GroupInfoDetailCollectionView * groupInfoDetailCollectionView;
@property (nonatomic, strong) NSDictionary *shareData;
@property(nonatomic,strong)UIButton * bottomButton;
@property(nonatomic,strong)GroupDetail * model;

@end

@implementation XYGroupInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    
    [self setUpUI];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [YUtils showHUDWithTitle];
    [super viewWillAppear:animated];
    [[ContactManager sharedInstance] groupDetail:_gid block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        if (message.object) {
            _model = message.object;
            [_groupInfoDetailCollectionView refreshTableView:message.object];
             _shareData = @{@"name":_model.groupModel.groupName,@"content":_model.groupModel.internalBaseClassDescription,@"pic":_model.groupModel.groupIcon,@"groupId":[NSString stringWithFormat:@"%g", _model.groupModel.internalBaseClassIdentifier]};
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_groupInfoDetailCollectionView showDel:NO];
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
    _groupInfoDetailCollectionView.myController = self;
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

#pragma mark - 点击底部button事件
-(void)clickBottomButton
{
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count-2] isKindOfClass:[ChatViewController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:_studentDic[@"thirdCode"] isGroup:YES];
        chatVC.isSystemMessage = NO;
        chatVC.studentDic = [_studentDic mutableCopy];
        [self.navigationController pushViewController:chatVC animated:YES needHiddenBottomBar:YES];
    }
}
#pragma mark - 分享ActionSheet
-(void)showShareActionSheet
{
    LinkManModel * model = [[ContactManager sharedInstance] getContactsListData];
    ClassList * classModel = model.classList[0];
    
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"消息不提醒"
                                                         type:YCommonActionSheetItemTypeSwitch
                                                      isGroup:YES
                                                         open:[[MessageManager sharedInstance] isForbiddenGroupByThirdCode:_studentDic[@"thirdCode"]]
                                                    extraData:@{@"thirdCode":_studentDic[@"thirdCode"]}];
    
    
    YActionSheetItem *item3 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            [YCommonReport report];
                                                        }];
    if ([[NSString stringWithFormat:@"%g", _model.groupModel.internalBaseClassIdentifier] isEqualToString:classModel.gid]) {
        
        YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item2, item3] title:nil];
        [sheet show];
    }
    else
    {
        YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeShareOrganization title:@"分享社团名片至" extraData:_shareData];
        
        YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2, item3] title:nil];
        [sheet show];
    }
    
}

#pragma mark - 导航返回按钮点击事件
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
