//
//  ContactsInfoDetailTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsInfoDetailTableView.h"
#import "ContactsInfoDetailTableViewCell.h"
#import "ConnectTag.h"

#define kHeaderViewHeight              90
#define kHeadWidthAndHeight            46
#define kNameLabelWidth                80
#define kHeadCornerRadius              23
#define kPaddingDistance               12
#define kLabelHeightDistacnce          14

@interface ContactsInfoDetailTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *flagLabel;
@property (strong, nonatomic)  UILabel *statesLabel;
@property (strong, nonatomic)  ConnectTag * connectTag;

@property (nonatomic,strong) NSMutableArray * flagNameArr;

@end

@implementation ContactsInfoDetailTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = NO;
        
        self.flagNameArr = [[NSMutableArray alloc] initWithArray:@[@"互联网就业",@"留学陶瓷",@"网球社"]];
        
        [self registerClass:[ContactsInfoDetailTableViewCell class] forCellReuseIdentifier:kContactsInfoDetailTableViewCell];
        [self refreshTableView:nil];
    }
    return self;
}

-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
    [self setUpHeaderView];
    [self reloadData];
}

-(void)setUpHeaderView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewHeight)];
    //头像
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = kHeadCornerRadius;
    _headImageView.clipsToBounds = YES;
    _headImageView.backgroundColor = [UIColor yellowColor];
    [backView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPaddingDistance);
        make.centerY.equalTo(backView);
        make.width.height.mas_equalTo(kHeadWidthAndHeight);
    }];
    //姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = CONTENT_FONT(14);
    _nameLabel.text = @"哈士奇";
    _nameLabel.backgroundColor = [UIColor magentaColor];
    [backView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.width.mas_equalTo(kNameLabelWidth);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
   //标签
    _connectTag = [[ConnectTag alloc] init];
    [backView addSubview:_connectTag];
    [_connectTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kPaddingDistance);
        make.top.mas_equalTo(kPaddingDistance);
    }];
//    [_connectTag updateTag:@[@"班",@"社",@"系",@"团",@"啊"]];
    
    //消息
    _statesLabel = [[UILabel alloc] init];
    _statesLabel.font = CONTENT_FONT(12);
    _statesLabel.numberOfLines = 0;
    _statesLabel.text = @"sahifhasignasopgnagsagaisngoasknmgoiasngoinasoignoiasnoginasoignoi";
    _statesLabel.backgroundColor = [UIColor grayColor];
    [backView addSubview:_statesLabel];
    [_statesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.right.equalTo(backView).offset(-kPaddingDistance);
        make.top.equalTo(_nameLabel.mas_bottom).offset(kPaddingDistance);
    }];
    self.tableHeaderView = backView;
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ContactsInfoDetailTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kContactsInfoDetailTableViewCell forIndexPath:indexPath];
    
    NSString * indexStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    if (indexPath.row == 0)
    {
        NSDictionary * dic = @{@"content":@"200000给您敬酒了",@"index":indexStr};
        [cell setCellInfo:dic];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        NSDictionary * dic = @{@"content":@"200000觉得你很酷",@"index":indexStr};
        [cell setCellInfo:dic];
        return cell;
    }
    else
    {
        NSDictionary * dic = @{@"content":self.flagNameArr[indexPath.row - 2],@"index":indexStr};
        [cell setCellInfo:dic];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1)
    {
        return 60;
    }
    else
    {
        return 40;
    }
}

@end
