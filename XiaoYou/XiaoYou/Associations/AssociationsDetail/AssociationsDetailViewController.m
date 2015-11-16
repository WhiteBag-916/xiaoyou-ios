//
//  AssociationsDetailViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "AssociationsDetailViewController.h"
#import "AssociationsDetailTableView.h"
#import "YCommonActionSheet.h"
#import "ContactManager.h"
#import "YUtils+HUD.h"
#import "ChatViewController.h"
#import "GroupModel.h"
#import "YCommonReport.h"

@interface AssociationsDetailViewController ()
<AssociationsDetailTableViewDelegate>

@property (nonatomic, strong) AssociationsDetailTableView *associationsDetailTableView;
@property (nonatomic, strong) UIButton *addButton; //一键入社
@property (nonatomic, strong) NSString *uid;//社团id
@property (nonatomic, strong) GroupModel *groupModel;//详情
@property (nonatomic, strong) NSString *name;

@end

@implementation AssociationsDetailViewController

- (instancetype)initWithId:(NSString *)uid name:(NSString *)name {
    if (self = [super init]) {
        _uid = uid;
        _name = name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _name;
    [self showCustomNavigationBackButton];
    [self showCustomNavigationMoreButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:KNotification_Refresh_FeedList object:nil];
    
    [self initView];
}

- (void)refreshData {
    [_associationsDetailTableView loadData];
}

//需要调用之前设定好_shareData，参考XYGroupInfoDetailViewController
- (void)onNavigationRightButtonClicked {
    if (nil != _groupModel) {
        YActionSheetItem *item1 = [YActionSheetItem itemWithType:YCommonActionSheetItemTypeShareOrganization title:@"分享社团名片至" extraData:@{@"name":_groupModel.groupName, @"content":_groupModel.internalBaseClassDescription, @"pic":_groupModel.groupIcon,@"groupId":[NSString stringWithFormat:@"%g", _groupModel.internalBaseClassIdentifier]}];
        
        
        YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"举报"
                                                             type:YCommonActionSheetItemTypeCommon
                                                            block:^(NSInteger checkNum) {
                                                                [YCommonReport report];
                                                            }];
        
        YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] haveShareButton:YES];
        [sheet show];
    }
}

- (void)initView {
    //button
    _addButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setTitle:[NSString stringWithFormat:@"一键申请加入%@", _name] forState:UIControlStateNormal];
    [_addButton setTitleColor:KCOLORWHITE forState:UIControlStateNormal];
    [_addButton setBackgroundImage:[UIImage imageNamed:@"contacts_bottom"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(pressAddButton) forControlEvents:UIControlEventTouchUpInside];
    [self addButtonEnabled:NO];
    [self.view addSubview:_addButton];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(SCALE_NUM(48));
    }];
    
    //tableview
    _associationsDetailTableView = [[AssociationsDetailTableView alloc] initWithGroupId:_uid];
    _associationsDetailTableView.parent = self;
    _associationsDetailTableView.associationsDetailTableViewDelegate = self;
    [self.view addSubview:_associationsDetailTableView];
    
    [_associationsDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_addButton.mas_top);
    }];
    
    [_associationsDetailTableView loadData];
}

- (void)pressAddButton {
    if ([_groupModel.groupStatus isEqualToString:@"3"]) {
        //进入群聊
        ChatViewController *chatViewController = [[ChatViewController alloc] initWithChatter:_groupModel.thirdId isGroup:YES];
        chatViewController.studentDic = [@{@"name":_groupModel.groupName, @"icon":_groupModel.groupIcon,@"gid":[NSString stringWithFormat:@"%g", _groupModel.internalBaseClassIdentifier]} mutableCopy];
        [self.navigationController pushViewController:chatViewController animated:YES];
    } else {
        [YUtils showHUDWithTitle];
        //申请入社
        [[ContactManager sharedInstance] submitApply:_uid block:^(YActionMessage *message) {
            [YUtils hiddenProgressHUD];
            
            if (message.isSuccess) {
                [self addButtonEnabled:NO];
            }
            
            [YUtils showTitle:message.desc];
        }];
    }
}

- (void)addButtonEnabled:(BOOL)isEnabled {
    _addButton.enabled = isEnabled;
}

#pragma mark - AssociationsDetailTableViewDelegate
- (void)resetAddButtonType:(GroupModel *)model {
    _groupModel = model;
    //1 未入社、2 申请中、3 已加入
    if ([_groupModel.groupStatus isEqualToString:@"1"]) {
        [self addButtonEnabled:YES];
    } else if ([_groupModel.groupStatus isEqualToString:@"2"]) {
        [self addButtonEnabled:NO];
    } else if ([_groupModel.groupStatus isEqualToString:@"3"]) {
        [self addButtonEnabled:YES];
        
        [_addButton setTitle:@"进入群聊" forState:UIControlStateNormal];
    }
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
