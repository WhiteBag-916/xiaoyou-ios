//
//  MessageTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MessageTableView.h"
#import "MessageTableViewCell.h"
#import "YLog.h"
#import "ChatViewController.h"
#import "Masonry.h"
#import "YColor+Ext.h"
#import "XYFriendApplyViewController.h"
#import "XYGroupApplyViewController.h"
#import "ChatViewController.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "XYSystemMessageViewController.h"

#define kRowHeight                     68
#define kHeadWidthAndHeight            40
#define kNameLabelWidth                80
#define kTimeLabelWidth                60
#define kHeadCornerRadius              20
#define kPaddingDistance               10
#define kLabelHeightDistacnce          14
#define kBadgeWidthDistance            21



@interface MessageTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *messageDataSource;

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *badgeNumberLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *messageLabel;


@end

@implementation MessageTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[MessageTableViewCell class] forCellReuseIdentifier:kMessageTableViewCell];
    }
    
    return self;
}

- (BOOL)showHeaderRefresh
{
    return NO;
}

- (BOOL)showFooterRefresh
{
    return YES;
}


-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
//    for (int i = 0; i < dataSouceArr.count; i++)
//    {
//        EMConversation * conversation = dataSouceArr[i];
//        if ([conversation.latestMessage.from isEqualToString:@"000001"])
//        {
//            [self setUpHeaderView];
//            [dataSouceArr removeObject:conversation];
//        }
//    }
    [self setUpHeaderView];
    _messageDataSource = dataSouceArr;
    [self reloadData];
}

-(void)setUpHeaderView
{
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
    
    
    //姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = @"系统消息";
    _nameLabel.font = CONTENT_FONT(14);
    _nameLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.width.mas_equalTo(kNameLabelWidth);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    //消息数
    _badgeNumberLabel = [[UILabel alloc] init];
    _badgeNumberLabel.text = @"8";
    _badgeNumberLabel.font = CONTENT_FONT(10);
    _badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
    _badgeNumberLabel.backgroundColor = [UIColor hexChangeFloat:@"258f74"];
    [backView addSubview:_badgeNumberLabel];
    [_badgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kPaddingDistance);
        make.right.equalTo(backView).offset(-kPaddingDistance);
        make.height.mas_equalTo(kLabelHeightDistacnce);
        make.width.mas_equalTo(kBadgeWidthDistance);
    }];
    //时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = CONTENT_FONT(9);
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kPaddingDistance);
        make.right.mas_equalTo(-kPaddingDistance);
        make.width.mas_equalTo(kTimeLabelWidth);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    //消息
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = CONTENT_FONT(12);
    _messageLabel.backgroundColor = [UIColor clearColor];
    _messageLabel.text = @"暂时没有新的消息";
    [backView addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.right.equalTo(_badgeNumberLabel.mas_left).offset(-kPaddingDistance);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    self.tableHeaderView = backView;
}

-(void)tapGestureRecognizerAction
{
//    ChatViewController * chatViewController = [[ChatViewController alloc] initWithChatter:@"yinhui" isGroup:NO];
//    chatViewController.isSystemMessage = YES;
//    [self.myController.navigationController pushViewController:chatViewController animated:YES needHiddenBottomBar:YES];
    XYSystemMessageViewController * systemMessageViewController = [[XYSystemMessageViewController alloc] init];
    [self.myController.navigationController pushViewController:systemMessageViewController animated:YES needHiddenBottomBar:YES];
}

#pragma mark - UITableViewDataSource和UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [self dequeueReusableCellWithIdentifier:kMessageTableViewCell];
    
    [cell setCellInfo:_messageDataSource[indexPath.row]];
    
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMConversation *converation = [_messageDataSource objectAtIndex:indexPath.row];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:YES append2Chat:YES];
        [_messageDataSource removeObjectAtIndex:indexPath.row];
        [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell * cell = (MessageTableViewCell *)[self cellForRowAtIndexPath:indexPath];
    self.myController.hidesBottomBarWhenPushed = YES;
    
    if ([cell.studentDic[@"linkType"] doubleValue] == 0) {
        ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:cell.studentDic[@"thirdCode"] isGroup:NO];
        chatVC.isSystemMessage = NO;
        chatVC.studentDic = cell.studentDic;
        [self.myController.navigationController pushViewController:chatVC animated:YES];
    }
    else
    {
        ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:cell.studentDic[@"thirdCode"] isGroup:YES];
        chatVC.isSystemMessage = NO;
        chatVC.studentDic = cell.studentDic;
        [self.myController.navigationController pushViewController:chatVC animated:YES];
    }
    
    
}



@end
