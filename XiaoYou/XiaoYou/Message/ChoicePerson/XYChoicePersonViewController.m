//
//  XYChoicePersonViewController.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "XYChoicePersonViewController.h"
#import "ChoicePersonTableView.h"
#import "XYSendMessageViewController.h"
#import "ContactManager.h"
#import "LinkManModel.h"
#import "LinkManList.h"
#import "YUtils+HUD.h"
#import "XYGroupInfoDetailViewController.h"
#import "XYGroupApplyViewController.h"
#import "Author.h"

#define kButtonItemHeightAndWidth           SCALE_NUM(44)
#define kCancleButtonItemWidth              SCALE_NUM(55)
#define kRightButtonWidth                   SCALE_NUM(85)

@interface XYChoicePersonViewController ()

@property(nonatomic,strong)ChoicePersonTableView * choicePersonTableView;

@property (nonatomic,strong) NSMutableArray * dataSourceArr;

@end

@implementation XYChoicePersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    if ([_superType isEqualToString:kXYGroupInfoDetailViewController])
    {
        LinkManModel * model =[[ContactManager sharedInstance] getContactsListData];
        _dataSourceArr = [[NSMutableArray alloc] initWithArray:model.linkManList];
        [_choicePersonTableView refreshTableView:_dataSourceArr];
    }
    else
    {
        _dataSourceArr = [[NSMutableArray alloc] initWithArray:_authorArr];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_choicePersonTableView refreshTableView:_dataSourceArr];
}

-(void)setUpUI
{
    self.title = @"选人";
    [self showCustomNavigationCancelButton];
    
    
    UIView * rightView =
    [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRightButtonWidth, kButtonItemHeightAndWidth)];
    
    UIButton * cancelButton =
    [[UIButton alloc] initWithFrame:CGRectMake(0, 0,
                                               kCancleButtonItemWidth, kButtonItemHeightAndWidth)];
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton setTitle:@"全不选" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = CONTENT_FONT(14);
    [cancelButton addTarget:self action:@selector(cancelChoice)
           forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * choiceButton =
    [[UIButton alloc] initWithFrame:CGRectMake(kCancleButtonItemWidth, 0,
                                               kButtonItemHeightAndWidth,
                                               kButtonItemHeightAndWidth)];
    choiceButton.backgroundColor = [UIColor clearColor];
    [choiceButton setImage:[UIImage imageNamed:@"complete"]
                  forState:UIControlStateNormal];
    [choiceButton addTarget:self action:@selector(finishChoice)
           forControlEvents:UIControlEventTouchUpInside];

    [rightView addSubview:choiceButton];
    [rightView addSubview:cancelButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    

    
    _choicePersonTableView = [[ChoicePersonTableView alloc] init];
    _choicePersonTableView.superVC = self;
    [self.view addSubview:_choicePersonTableView];
    [_choicePersonTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
}

#pragma mark - 选人完成事件

-(void)finishChoice
{
    NSLog(@"finish");
    NSMutableArray * sendPersonsArr = [[NSMutableArray alloc] init];
    [_choicePersonTableView.dataSouceArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"isSelected"] boolValue])
        {
            if ([[self superType] isEqualToString:kXYGroupInfoDetailViewController])
            {
                LinkManList * model = obj[@"model"];
                [sendPersonsArr addObject:model];
            }
            else
            {
                Author * model = obj[@"model"];
                [sendPersonsArr addObject:model];
            }
            
        }
    }];
    
    if (sendPersonsArr.count > 0)
    {
        if ([[self superType] isEqualToString:kXYGroupInfoDetailViewController])
        {
            NSMutableArray * uidArr = [NSMutableArray array];
            for (int i = 0; i < sendPersonsArr.count; i++)
            {
                LinkManList * model = sendPersonsArr[i];
                [uidArr addObject:model.uid];
            }
            NSString * uids = [uidArr componentsJoinedByString:@","];
            //走接口
            [YUtils showHUDWithTitle];
            [[ContactManager sharedInstance] addGroupUser:_groupId addUserIds:uids
                                                    block:^(YActionMessage *message) {
                [YUtils hiddenProgressHUD];
                if (message.isSuccess)
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [YUtils showTitle:message.desc];
                }
            }];
        }
        else
        {
            XYSendMessageViewController * sendMessageViewController =
            [[XYSendMessageViewController alloc] init];
            sendMessageViewController.sendPersonsArr = sendPersonsArr;
            sendMessageViewController.groupId = _groupId;
            [self.navigationController pushViewController:sendMessageViewController animated:YES];
        }
        
    }
    else
    {
        [YUtils showTitle:@"没有选择任何人"];
    }
    
}

#pragma mark - 取消选择事件

-(void)cancelChoice
{
    NSLog(@"cancel");
    [_choicePersonTableView refreshTableView:_dataSourceArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
