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
#define kClassLabelWidthAndHeight      30
#define kRemindImageViewWidth          13
#define kRemindImageViewHeight         15
#define kRemindImageViewToRight        25

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
//            LinkManModel * model = message.object;
            
//            [[ContactManager sharedInstance] saveContactsList:model];
            
            [self refreshTableView:[[ContactManager sharedInstance] getContactsListData]];
        }
    }];
    [self stopLoadNewData];
}

- (BOOL)showFooterRefresh
{
    return YES;
}


-(void)refreshTableView:(LinkManModel *) model
{
    
    _linkManModel = model;
    //联系人model数组
    _originalContactsDataSource = [NSMutableArray arrayWithArray:model.linkManList];
    //联系人+社团model数组
    [_originalContactsDataSource addObjectsFromArray:model.unionList];
    //索引数组
    _indexTitleArr = [[NSMutableArray alloc] init];
    //数据源
    _contactsDataSource = [NSMutableArray arrayWithArray:[self transformDataSouceArr:_originalContactsDataSource]];
    [self setUpHeaderView:model.classList];
    [self reloadData];
}

-(void)setUpHeaderView:(NSArray *) headerDataSouce
{
    if (headerDataSouce.count > 0)
    {
        _headDataSourceDic = (NSMutableDictionary *)[headerDataSouce[0] dictionaryRepresentation];
    }
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRowHeight)];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)];
    [backView addGestureRecognizer:tapGestureRecognizer];
    //头像
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = kHeadCornerRadius;
    _headImageView.clipsToBounds = YES;
    _headImageView.backgroundColor = [UIColor hexChangeFloat:@"258f74"];
    [backView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(kPaddingDistance);
        make.width.height.mas_equalTo(kHeadWidthAndHeight);
    }];
    //班
    _defaultLabel = [[UILabel alloc] init];
    _defaultLabel.text = @"班";
    _defaultLabel.textAlignment = NSTextAlignmentCenter;
    _defaultLabel.textColor = [UIColor whiteColor];
    [backView addSubview:_defaultLabel];
    [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.mas_top).offset(kClassLabelDistance);
        make.left.mas_equalTo(_headImageView.mas_left).offset(kClassLabelDistance);
        make.width.height.mas_equalTo(kClassLabelWidthAndHeight);
    }];
    //提醒
    _remindImageView = [[UIImageView alloc] init];
    _remindImageView.image = [UIImage imageNamed:@"chat_remindnot"];
    [backView addSubview:_remindImageView];
    [_remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kPaddingDistance);
        make.right.mas_equalTo(-kRemindImageViewToRight);
        make.height.mas_equalTo(kRemindImageViewHeight);
        make.width.mas_equalTo(kRemindImageViewWidth);
    }];
    if ([_headDataSourceDic[@"isRemind"] isEqualToString:@"y"])
    {
        _remindImageView.hidden = YES;
    }
    else
    {
        _remindImageView.hidden = NO;
    }
    //姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = CONTENT_FONT(14);
    _nameLabel.text = _headDataSourceDic[@"name"];
    _nameLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.width.mas_equalTo(kNameLabelWidth);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    //标签
    _flagLabel = [[UILabel alloc] init];
    _flagLabel.font = CONTENT_FONT(11);
    _flagLabel.text = @"班级群聊";
    _flagLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_flagLabel];
    [_flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.right.mas_equalTo(-kPaddingDistance);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    self.tableHeaderView = backView;
}

-(void)tapGestureRecognizerAction
{
//    ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:_headDataSourceDic[@"thirdCode"] isGroup:YES];
//    chatVC.isSystemMessage = NO;
//    chatVC.studentDic = _headDataSourceDic;
//    [self.myController.navigationController pushViewController:chatVC animated:YES needHiddenBottomBar:YES];
}


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

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        self.deleteIndexPathOfCell = indexPath;
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"确定删除此人？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
   
    return self.indexTitleArr;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        groupInfoDetailViewController.gid = [cell.studentDic[@"gid"] stringValue];
        [self.myController.navigationController pushViewController:groupInfoDetailViewController animated:YES needHiddenBottomBar:YES];
    }
    
}

#pragma mark - UIAlterViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        YLogD(@"contactDelete");
        YLogD(@"%@",self.deleteIndexPathOfCell);
        ContactsTableViewCell * cell = (ContactsTableViewCell *)[self cellForRowAtIndexPath:self.deleteIndexPathOfCell];
        
        for (LinkManList * obj in _linkManModel.linkManList) {
            if ([cell.studentDic[@"thirdCode"] isEqualToString:obj.thirdCode])
            {
                NSMutableArray * linkManArr = [[NSMutableArray alloc] initWithArray:_linkManModel.linkManList];
                [linkManArr removeObject:obj];
                _linkManModel.linkManList = [[NSArray alloc] initWithArray:linkManArr];
                [self refreshTableView:_linkManModel];
             
                [[ContactManager sharedInstance] saveContactsList:_linkManModel];
            }
        }
      
    }
}

@end
