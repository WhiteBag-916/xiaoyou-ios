//
//  ChooseSchoolViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/7/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ChooseSchoolViewController.h"
#import "ProvisionManager.h"
#import "AppDelegate+RootVC.h"
#import "SchoolListModel.h"
#import "PinYinForObjc.h"
#import "UIImageView+WebCache.h"
#import "YTextField.h"
#import "YTableView.h"
#import "YTableViewCell.h"
#import "ChooseSchoolTableViewCell.h"
#import "LoginViewController.h"

@interface ChooseSchoolViewController ()
<UITextFieldDelegate
,UITableViewDataSource
,UITableViewDelegate>

@property (nonatomic, strong) YTextField *schoolTextField;
@property (nonatomic, strong) YTableView *tableView;
@property (nonatomic, strong) UIImageView *schoolLogoImageView;
@property (nonatomic, strong) NSMutableArray *schoolSearchList;//服务器获取数据后才进行的搜索
@property (nonatomic, strong) NSArray *schoolListBySeaver;//服务器的联系人列表，用于存储学校信息

@end

@implementation ChooseSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选学校";
    [self showCustomNavigationNextButton];
    self.view.backgroundColor = KCOLORGREEN_e6ebea;
    
    [self setupUI];
    [self schoolListRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    _schoolTextField.text = [YShareData defaultData][kShareData_SchoolName];
    [self searchSchoolByKey:YES];
    
    [self resetRightButton];
}

#pragma mark - private
-(void)setupUI {
    //schoolview
    UIView *schoolView = [UIView new];
    schoolView.backgroundColor = KCOLORWHITE;
    [self.view addSubview:schoolView];
    [schoolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(SCALE_NUM(28));
        make.height.mas_equalTo(SCALE_NUM(49));
    }];
    
    //logo
    _schoolLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_school"]];
    [schoolView addSubview:_schoolLogoImageView];
    [_schoolLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(24));
        make.height.mas_equalTo(SCALE_NUM(27));
        make.centerY.equalTo(schoolView);
    }];
    
    //line
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor hexChangeFloat:@"4e5659"];
    [schoolView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_schoolLogoImageView.mas_right).offset(SCALE_NUM(12));
        make.width.mas_equalTo(0.5);
        make.height.equalTo(schoolView).offset(SCALE_NUM(-13));
        make.centerY.equalTo(schoolView);
    }];
    
    //textField
    _schoolTextField = [[YTextField alloc] init];
    _schoolTextField.placeholder = @"找到你的学校";
    _schoolTextField.delegate = self;
    [_schoolTextField registerChanged:self action:@selector(textFieldValueChanged:)];
    [schoolView addSubview:_schoolTextField];
    [_schoolTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(SCALE_NUM(14));
        make.right.mas_equalTo(SCALE_NUM(-14));
        make.top.height.equalTo(schoolView);
    }];
    
    //tableview
    _tableView = [[YTableView alloc]init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = KCOLORGREEN_e6ebea;
    [_tableView registerClass:[ChooseSchoolTableViewCell class] forCellReuseIdentifier:kChooseSchoolTableViewCell];
    [self.view addSubview:_tableView];
    _tableView.hidden = YES;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(schoolView.mas_bottom);
    }];
}

- (void)resetRightButton {
    if ([_schoolTextField.text isEmpty]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

//根据服务器的学校列表，更新总列表
- (void)updateSchoolListArray:(NSArray *)schoolArray
{
    [self searchSchoolByKey:YES];
    [self checkTextChangeLogoImage];
}

//筛选  参数：完全匹配
- (void)searchSchoolByKey:(BOOL)isAllCheck
{
    NSString *searchKey = [_schoolTextField.text lowercaseString];
    
    if (nil == _schoolSearchList)
    {
        _schoolSearchList = [[NSMutableArray alloc] init];
    }
    
    [_schoolSearchList removeAllObjects];
    
    if (searchKey.length > 0)
    {
        [_schoolListBySeaver enumerateObjectsUsingBlock:^(SchoolListModel *model, NSUInteger idx, BOOL *stop) {
            NSRange range = [model.schoolName rangeOfString:searchKey];
            if (range.location != NSNotFound)
            {
                //汉字
                [_schoolSearchList addObject:model];
            }
            else if (!isAllCheck)
            {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:model.schoolName];
                NSRange titleResult=[tempPinYinStr rangeOfString:searchKey options:NSCaseInsensitiveSearch];
                if (titleResult.location != NSNotFound)
                {
                    //全拼
                    [_schoolSearchList addObject:model];
                }
                else
                {
                    //首字母
                    NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:model.schoolName];
                    NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:searchKey options:NSCaseInsensitiveSearch];
                    if (titleHeadResult.location != NSNotFound)
                    {
                        [_schoolSearchList addObject:model];
                    }
                }
                
            }
        }];
    }
    else
    {
        [_schoolSearchList addObjectsFromArray:_schoolListBySeaver];
    }
    
    [_tableView reloadData];
    _tableView.hidden = NO;
}

//完全匹配，换图标
- (void)checkTextChangeLogoImage
{
    NSString *searchText = _schoolTextField.text;
    
    __block NSString *logoImageStr;
    //相同
    [_schoolListBySeaver enumerateObjectsUsingBlock:^(SchoolListModel *schoolModel, NSUInteger idx, BOOL *stop) {
        if ([searchText isEqualToString:schoolModel.schoolName])
        {
            logoImageStr = schoolModel.schoolLogoPath;
            *stop = YES;
        }
    }];
    
    [self updateLogo:logoImageStr];
}

//更新logo
- (void)updateLogo:(NSString *)logoImageStr
{
    if (logoImageStr.length > 0)
    {
        [_schoolLogoImageView setNormalImageWithUrl:logoImageStr];
        [_schoolLogoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_NUM(24));
            make.height.mas_equalTo(SCALE_NUM(24));
        }];
    }
    else
    {
        [_schoolLogoImageView setImage:[UIImage imageNamed:@"login_school"]];
        [_schoolLogoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_NUM(24));
            make.height.mas_equalTo(SCALE_NUM(27));
        }];
    }
}

#pragma mark - API
//获取学校列表
- (void)schoolListRequest{
    [[ProvisionManager sharedInstance] schoolListReq:_schoolTextField.text block:^(YActionMessage *message) {
        if (message.isSuccess) {
            self.schoolListBySeaver = [NSArray arrayWithArray:message.object];
            
            [self updateSchoolListArray:message.object];
            
            _tableView.hidden = NO;
        } else {
            YLogE(@"schoolListRequest: %@",message);
        }
    }];
}

//是否是录入学校
- (void)checkSchoolRequest
{
    [[ProvisionManager sharedInstance] schoolListReq:_schoolTextField.text block:^(YActionMessage *message) {
        if (message.isSuccess) {
            //选取学校
            __block SchoolListModel *schoolModel=nil;
            [message.object enumerateObjectsUsingBlock:^(SchoolListModel *model, NSUInteger idx, BOOL *stop) {
                if ([_schoolTextField.text isEqualToString:model.schoolName])
                {
                    schoolModel = model;
                    *stop = YES;
                }
            }];
            
            if (nil != schoolModel) {
                [self pushToNext:schoolModel];
            }
            
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}

#pragma mark - Action
//下一步
- (void)onNavigationRightButtonClicked {
    //判断输入文字是否是数组中得文字全匹配
    __block BOOL isExist = NO;
    [_schoolListBySeaver enumerateObjectsUsingBlock:^(SchoolListModel *school, NSUInteger idx, BOOL *stop) {
        if ([school.schoolName isEqualToString:_schoolTextField.text])
        {
            isExist = YES;
            
            *stop = YES;
        }
    }];
    
    if (!isExist) {
        [YUtils showTitle:@"学校输入错误"];
        return;
    }
    
    //选取学校
    __block SchoolListModel *schoolModel=nil;
    [self.schoolListBySeaver enumerateObjectsUsingBlock:^(SchoolListModel *model, NSUInteger idx, BOOL *stop) {
        if ([_schoolTextField.text isEqualToString:model.schoolName])
        {
            schoolModel = model;
            *stop = YES;
        }
    }];
    
    if (nil == schoolModel)
    {
        //去验证，是否有权限
        [self checkSchoolRequest];
        return;
    }
    
    [self pushToNext:schoolModel];
}

//跳转
- (void)pushToNext:(SchoolListModel *)schoolModel
{
    [YShareData defaultData][kShareData_SchoolCode] = schoolModel.schoolCode;
    [YShareData defaultData][kShareData_SchoolName] = schoolModel.schoolName;
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];

//    [kAppDelegateAccessor initLoginNC];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCALE_NUM(49);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _schoolSearchList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseSchoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChooseSchoolTableViewCell];
    
    SchoolListModel *school = (SchoolListModel *)_schoolSearchList[indexPath.row];
    [cell initData:school.schoolName];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    tableView.hidden = YES;
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SchoolListModel *school = (SchoolListModel *)_schoolSearchList[indexPath.row];
    _schoolTextField.text = school.schoolName;
    [self updateLogo:school.schoolLogoPath];
    //    _tableView.hidden = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    //刷新列表
    [self searchSchoolByKey:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldValueChanged:(UITextField *)sender{
    [self resetRightButton];
    
    [self searchSchoolByKey:NO];
    
    [self checkTextChangeLogoImage];
}

@end
