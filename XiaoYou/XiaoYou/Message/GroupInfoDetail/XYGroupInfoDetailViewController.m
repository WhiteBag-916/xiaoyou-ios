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

#define kNavigationgLeftWidth                   SCALE_NUM(9)
#define kNavigationgLeftHeight                  SCALE_NUM(14)
#define kNavigationgRightWidthAndHeight         SCALE_NUM(40)

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
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    
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
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(SCALE_NUM(70), SCALE_NUM(70));
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
    [MobClick event:@"event24"];
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
-(void)onNavigationRightButtonClicked
{
    [MobClick event:@"event22"];
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"消息不提醒"
                                                         type:YCommonActionSheetItemTypeSwitch
                                                      isGroup:YES
                                                         open:[[MessageManager sharedInstance] isForbiddenGroupByThirdCode:_studentDic[@"thirdCode"]]
                                                    extraData:@{@"thirdCode":_studentDic[@"thirdCode"]}];
    
    
    YActionSheetItem *item3 = [YActionSheetItem itemWithTitle:@"举报"
                                                         type:YCommonActionSheetItemTypeCommon
                                                        block:^(NSInteger checkNum) {
                                                            [MobClick event:@"event27"];
                                                            [YCommonReport report];
                                                        }];
    
    LinkManModel * model = [[ContactManager sharedInstance] getContactsListData];
    if (model.classList.count > 0 && [[NSString stringWithFormat:@"%g", _model.groupModel.internalBaseClassIdentifier] isEqualToString:[model.classList[0] gid]]) {
        
        YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item2, item3] title:nil];
        [sheet show];
    }
    else
    {
        YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeShareOrganization title:@"分享社团名片至" extraData:_shareData];
        
        YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2, item3] haveShareButton:YES];
        [sheet show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
