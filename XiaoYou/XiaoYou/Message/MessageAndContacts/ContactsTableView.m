//
//  ContactsTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsTableView.h"
#import "ContactsTableViewCell.h"
#import "Pinyin.h"
#import "ChineseString.h"
#import "YLog.h"
#import "XYContactsInfoDetailViewController.h"
#import "XYGroupInfoDetailViewController.h"
#import "ActivityViewController.h"
#import "Masonry.h"
#import "YSystemDefine.h"
#import "ContactManager.h"
#import "LinkManList.h"

#define kRowHeight                     68
#define kHeadWidthAndHeight            40
#define kNameLabelWidth                200
#define kHeadCornerRadius              20
#define kPaddingDistance               10
#define kLabelHeightDistacnce          14
#define kClassLabelDistance            5
#define kClassLabelWidthAndHeight      40
#define kRemindImageViewWidth          13
#define kRemindImageViewHeight         15
#define kRemindImageViewToRight        25
#define kBottomLineHeight              0.4


@interface ContactsTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *flagLabel;
@property (nonatomic,strong)  UILabel * defaultLabel;
@property (nonatomic,strong) UIImageView * remindImageView;

//原始model
@property (nonatomic,strong)LinkManModel * linkManModel;

//head数据信息
@property (nonatomic,strong) NSMutableArray *originalContactsDataSource;
//原始数据源
@property (nonatomic,strong) NSMutableDictionary *headDataSourceDic;

//转换后数据源
@property (nonatomic,strong) NSMutableArray *contactsDataSource;
@property (nonatomic,strong) NSMutableArray *indexTitleArr;

@property (nonatomic,strong) NSIndexPath * deleteIndexPathOfCell;

@end

@implementation ContactsTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //索引部分设置
        self.sectionIndexBackgroundColor = [UIColor whiteColor];
        self.sectionIndexColor = [UIColor blackColor];
        
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ContactsTableViewCell class] forCellReuseIdentifier:kContactsTableViewCell];
    }
    
    return self;
}

- (BOOL)showHeaderRefresh
{
    return YES;
}

- (void)loadNewData
{
    
    //联系人列表请求
    [[ContactManager sharedInstance] getContactsListData:^(YActionMessage *message) {
        YLogD(@"%@",message);
        if (message.isSuccess) {
            
            [self refreshTableView:[[ContactManager sharedInstance] getContactsListData]];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
    [self stopLoadNewData];
}

- (BOOL)showFooterRefresh
{
    return YES;
}

#pragma mark - 刷新界面
-(void)refreshTableView:(LinkManModel *) model
{
    
    _linkManModel = model;
    //联系人model数组
    self.originalContactsDataSource = [NSMutableArray arrayWithArray:model.linkManList];
    //联系人+社团model数组
    [_originalContactsDataSource addObjectsFromArray:model.unionList];
    //索引数组
    self.indexTitleArr = [[NSMutableArray alloc] init];
    //数据源
    self.contactsDataSource = [NSMutableArray arrayWithArray:[self transformDataSouceArr:_originalContactsDataSource]];
    if (model.classList.count > 0)
    {
        [self setUpHeaderView:model.classList];
    }
    
    [self reloadData];
}

-(void)setUpHeaderView:(NSArray *) headerDataSouce
{
    if (headerDataSouce.count > 0)
    {
        self.headDataSourceDic = (NSMutableDictionary *)[headerDataSouce[0] dictionaryRepresentation];
    }
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2*kRowHeight)];
    
    UIView * classBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRowHeight)];
    UITapGestureRecognizer * tapClassGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClassGestureRecognizerAction)];
    [classBackView addGestureRecognizer:tapClassGestureRecognizer];
    classBackView.backgroundColor = [UIColor clearColor];
    
    //头像
    UIImageView * classHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPaddingDistance, kPaddingDistance, kHeadWidthAndHeight, kHeadWidthAndHeight)];
    classHeadImageView.layer.cornerRadius = kHeadCornerRadius;
    classHeadImageView.clipsToBounds = YES;
    classHeadImageView.backgroundColor = KCOLORGREEN_009688;
    [classBackView addSubview:classHeadImageView];

    //班
    UILabel * classDefaultLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPaddingDistance, kPaddingDistance, kClassLabelWidthAndHeight, kClassLabelWidthAndHeight)];
    classDefaultLabel.text = @"班";
    classDefaultLabel.font = CONTENT_FONT(12);
    classDefaultLabel.textAlignment = NSTextAlignmentCenter;
    classDefaultLabel.textColor = [UIColor whiteColor];
    [classBackView addSubview:classDefaultLabel];
    
    //提醒
    UIImageView * classRemindImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kRemindImageViewToRight - kRemindImageViewWidth, kRowHeight - kPaddingDistance - kRemindImageViewHeight, kRemindImageViewWidth, kRemindImageViewHeight)];
    classRemindImageView.image = [UIImage imageNamed:@"chat_remindnot"];
    [classBackView addSubview:classRemindImageView];
    classRemindImageView.hidden = [_headDataSourceDic[@"isRemind"] isEqualToString:@"y"];
    
    //姓名
    UILabel * classNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*kPaddingDistance + kHeadWidthAndHeight, kPaddingDistance, kNameLabelWidth, kLabelHeightDistacnce)];
    classNameLabel.font = CONTENT_FONT(14);
    classNameLabel.text = _headDataSourceDic[@"name"];
    classNameLabel.backgroundColor = [UIColor clearColor];
    [classBackView addSubview:classNameLabel];

    //标签
    UILabel * classFlagLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*kPaddingDistance + kHeadWidthAndHeight, kRowHeight - kLabelHeightDistacnce - kPaddingDistance, 15*kPaddingDistance, kLabelHeightDistacnce)];
    classFlagLabel.font = CONTENT_FONT(10);
    classFlagLabel.textColor = KCOLORWHITE_696969;
    classFlagLabel.text = @"班级群聊";
    classFlagLabel.backgroundColor = [UIColor clearColor];
    [classBackView addSubview:classFlagLabel];
    
    //底线
    UIView * classBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kRowHeight-1, SCREEN_WIDTH, kBottomLineHeight)];
    classBottomView.backgroundColor = [UIColor grayColor];
    classBottomView.alpha = 0.6;
    [classBackView addSubview:classBottomView];
    
    UIView * funBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kRowHeight, SCREEN_WIDTH, kRowHeight)];
    UITapGestureRecognizer * tapFunGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFunGestureRecognizerAction)];
    [funBackView addGestureRecognizer:tapFunGestureRecognizer];
    funBackView.backgroundColor = [UIColor clearColor];
    
    //头像
    UIImageView * funHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPaddingDistance, kPaddingDistance, kHeadWidthAndHeight, kHeadWidthAndHeight)];
    funHeadImageView.layer.cornerRadius = kHeadCornerRadius;
    funHeadImageView.clipsToBounds = YES;
    funHeadImageView.backgroundColor = [UIColor redColor];
    [funBackView addSubview:funHeadImageView];
    
    //好玩
    UILabel * funDefaultLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPaddingDistance, kPaddingDistance, kClassLabelWidthAndHeight, kClassLabelWidthAndHeight)];
    funDefaultLabel.text = @"好玩";
    funDefaultLabel.font = CONTENT_FONT(12);
    funDefaultLabel.textAlignment = NSTextAlignmentCenter;
    funDefaultLabel.textColor = [UIColor whiteColor];
    [funBackView addSubview:funDefaultLabel];
    
    //提醒
    UIImageView * funRemindImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kRemindImageViewToRight - kRemindImageViewWidth, kRowHeight - kPaddingDistance - kRemindImageViewHeight, kRemindImageViewWidth, kRemindImageViewHeight)];
    funRemindImageView.image = [UIImage imageNamed:@"chat_remindnot"];
    [funBackView addSubview:funRemindImageView];
    
    funRemindImageView.hidden = [_headDataSourceDic[@"isRemind"] isEqualToString:@"y"];

    //姓名
    UILabel * funNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*kPaddingDistance + kHeadWidthAndHeight, kPaddingDistance, kNameLabelWidth, kLabelHeightDistacnce)];
    funNameLabel.font = CONTENT_FONT(14);
    funNameLabel.text = @"好玩";
    funNameLabel.backgroundColor = [UIColor clearColor];
    [funBackView addSubview:funNameLabel];
    
    //标签
    UILabel * funFlagLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*kPaddingDistance + kHeadWidthAndHeight, kRowHeight - kLabelHeightDistacnce - kPaddingDistance, 15*kPaddingDistance, kLabelHeightDistacnce)];
    funFlagLabel.font = CONTENT_FONT(10);
    funFlagLabel.textColor = KCOLORWHITE_696969;
    funFlagLabel.text = @"校际活动精选";
    funFlagLabel.backgroundColor = [UIColor clearColor];
    [funBackView addSubview:funFlagLabel];
    
    //底线
    UIView * funBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kRowHeight-1, SCREEN_WIDTH, kBottomLineHeight)];
    funBottomView.backgroundColor = [UIColor grayColor];
    funBottomView.alpha = 0.6;
    [funBackView addSubview:funBottomView];
    
    [backView addSubview:classBackView];
    [backView addSubview:funBackView];
    self.tableHeaderView = backView;
    
//    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRowHeight)];
//    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)];
//    [backView addGestureRecognizer:tapGestureRecognizer];
//    backView.backgroundColor = [UIColor clearColor];
//
//    //头像
//    _headImageView = [[UIImageView alloc] init];
//    _headImageView.layer.cornerRadius = kHeadCornerRadius;
//    _headImageView.clipsToBounds = YES;
//    _headImageView.backgroundColor = KCOLORGREEN_009688;
//    [backView addSubview:_headImageView];
//    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_equalTo(kPaddingDistance);
//        make.width.height.mas_equalTo(kHeadWidthAndHeight);
//    }];
//    //班
//    _defaultLabel = [[UILabel alloc] init];
//    _defaultLabel.text = @"班";
//    _defaultLabel.textAlignment = NSTextAlignmentCenter;
//    _defaultLabel.textColor = [UIColor whiteColor];
//    [backView addSubview:_defaultLabel];
//    [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_headImageView.mas_top).offset(kClassLabelDistance);
//        make.left.mas_equalTo(_headImageView.mas_left).offset(kClassLabelDistance);
//        make.width.height.mas_equalTo(kClassLabelWidthAndHeight);
//    }];
//    //提醒
//    _remindImageView = [[UIImageView alloc] init];
//    _remindImageView.image = [UIImage imageNamed:@"chat_remindnot"];
//    [backView addSubview:_remindImageView];
//    [_remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-kPaddingDistance);
//        make.right.mas_equalTo(-kRemindImageViewToRight);
//        make.height.mas_equalTo(kRemindImageViewHeight);
//        make.width.mas_equalTo(kRemindImageViewWidth);
//    }];
//    if ([_headDataSourceDic[@"isRemind"] isEqualToString:@"y"])
//    {
//        _remindImageView.hidden = YES;
//    }
//    else
//    {
//        _remindImageView.hidden = NO;
//    }
//    //姓名
//    _nameLabel = [[UILabel alloc] init];
//    _nameLabel.font = CONTENT_FONT(14);
//    _nameLabel.text = _headDataSourceDic[@"name"];
//    _nameLabel.backgroundColor = [UIColor clearColor];
//    [backView addSubview:_nameLabel];
//    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(kPaddingDistance);
//        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
//        make.width.mas_equalTo(kNameLabelWidth);
//        make.height.mas_equalTo(kLabelHeightDistacnce);
//    }];
//    //标签
//    _flagLabel = [[UILabel alloc] init];
//    _flagLabel.font = CONTENT_FONT(10);
//    _flagLabel.textColor = KCOLORWHITE_696969;
//    _flagLabel.text = @"班级群聊";
//    _flagLabel.backgroundColor = [UIColor clearColor];
//    [backView addSubview:_flagLabel];
//    [_flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-kPaddingDistance);
//        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
//        make.right.mas_equalTo(-kPaddingDistance);
//        make.height.mas_equalTo(kLabelHeightDistacnce);
//    }];
//    
//    UIView * bottomView = [[UIView alloc] init];
//    bottomView.backgroundColor = [UIColor grayColor];
//    bottomView.alpha = 0.6;
//    [backView addSubview:bottomView];
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(kBottomLineHeight);
//    }];
//    
//    self.tableHeaderView = backView;
//    [self.tableHeaderView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(kRowHeight);
//    }];
}
#pragma mark - headView 点击事件
-(void)tapClassGestureRecognizerAction
{
    XYGroupInfoDetailViewController * groupInfoDetailViewController = [[XYGroupInfoDetailViewController alloc] init];
    groupInfoDetailViewController.studentDic = _headDataSourceDic;
    groupInfoDetailViewController.isClass = YES;
    groupInfoDetailViewController.gid = _headDataSourceDic[@"gid"];
    [self.myController.navigationController pushViewController:groupInfoDetailViewController animated:YES needHiddenBottomBar:YES];
}
-(void)tapFunGestureRecognizerAction
{
    //好玩列表页
    ActivityViewController *funnyVC = [[ActivityViewController alloc]init];
    [self.myController.navigationController pushViewController:funnyVC animated:YES needHiddenBottomBar:YES];
}

#pragma mark - 将拿到的数据源转化成自己需要的数据格式
-(NSMutableArray *)transformDataSouceArr:(NSMutableArray *) dataSouceArr
{
    NSMutableArray * receiveDataSouceArr = [[NSMutableArray alloc] initWithArray:dataSouceArr];
    NSMutableArray * sortDataSouceArr = [ChineseString SortArray:receiveDataSouceArr];
    
    
    NSMutableArray * tempTransitonArr = [[NSMutableArray alloc] init];
    NSMutableArray * transitonArr = [[NSMutableArray alloc] init];
    //model
    NSDictionary * lastModel = [sortDataSouceArr.lastObject dictionaryRepresentation];
    NSString * lastName = lastModel[@"name"];
    //取出所有模型，将数据拆分成section（firstIndexTitleArr）数组和sectionRows(transitonArr)数组
    [sortDataSouceArr enumerateObjectsUsingBlock:^(id  model, NSUInteger idx1, BOOL *stop2) {
        
        char temp =  pinyinFirstLetter([[model dictionaryRepresentation][@"name"] characterAtIndex:0]);
        
        NSString * firstStr = [NSString stringWithFormat:@"%c",temp].uppercaseString;
        
        if([self.indexTitleArr containsObject:firstStr.uppercaseString] == NO)
        {
            if (tempTransitonArr.count > 0) {
                [transitonArr addObject:[NSArray arrayWithArray: tempTransitonArr]];
            }
            [tempTransitonArr removeAllObjects];
            
            [self.indexTitleArr addObject:firstStr];
            
//            NSDictionary * dic = [self transformModelToDictionary:model];

            [tempTransitonArr addObject:model];
            
            if ([lastName isEqualToString:[model dictionaryRepresentation][@"name"]])
            {
                [transitonArr addObject:[NSArray arrayWithArray: tempTransitonArr]];
            }
        }
        else
        {
//            NSDictionary * dic = [self transformModelToDictionary:model];
            [tempTransitonArr addObject:model];
            
            if ([lastName isEqualToString:[model dictionaryRepresentation][@"name"]])
            {
                [transitonArr addObject:[NSArray arrayWithArray: tempTransitonArr]];
            }
        }
        
    }];
    
    //将section（firstIndexTitleArr）数组和sectionRows(transitonArr)数组合并成一个数组（finishdataSouceArr）
    NSMutableArray *resultDataSouceArr = [[NSMutableArray alloc] init];
    
    [self.indexTitleArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop2) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:obj forKey:@"index_title"];
        
        [dic setObject:transitonArr[idx] forKey:@"user_info"];
        
        [resultDataSouceArr addObject:dic];
    }];

    return resultDataSouceArr;
}


#pragma mark - UITableViewDataSource和UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contactsDataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = self.contactsDataSource[section][@"user_info"];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ContactsTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kContactsTableViewCell];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellInfo:self.contactsDataSource[indexPath.section][@"user_info"][indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
   
    return self.indexTitleArr;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSLog(@"this is row = %li",(long)indexPath.section);
    ContactsTableViewCell * cell = (ContactsTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    
    
    if ([cell.studentDic[@"linkType"] doubleValue] == 0) {
        XYContactsInfoDetailViewController * contactsInfoDetailVC = [[XYContactsInfoDetailViewController alloc] init];
        contactsInfoDetailVC.studentDic = cell.studentDic;
        contactsInfoDetailVC.uid = cell.studentDic[@"uid"];
        [self.myController.navigationController pushViewController:contactsInfoDetailVC animated:YES needHiddenBottomBar:YES];
    }
    else
    {
        XYGroupInfoDetailViewController * groupInfoDetailViewController = [[XYGroupInfoDetailViewController alloc] init];
        groupInfoDetailViewController.studentDic = cell.studentDic;
        groupInfoDetailViewController.gid = cell.studentDic[@"gid"];
        groupInfoDetailViewController.isClass = NO;
        [self.myController.navigationController pushViewController:groupInfoDetailViewController animated:YES needHiddenBottomBar:YES];
    }
    
}



@end
