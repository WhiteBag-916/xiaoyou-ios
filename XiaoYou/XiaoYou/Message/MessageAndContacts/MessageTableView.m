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
#import "ProvisionManager.h"
#import "YFaceImageView.h"
#import "NSDate+Category.h"
#import "RobotManager.h"
#import "MessageManager.h"
#import "XYFriendApplyViewController.h"
#import "XYGroupApplyViewController.h"
#import "YUtils+Component.h"
#import "EMConversation.h"
#import "InterestViewController.h"

#define kRowHeight                     68
#define kHeadWidthAndHeight            40
#define kNameLabelWidth                80
#define kTimeLabelWidth                60
#define kHeadCornerRadius              20
#define kPaddingDistance               10
#define kLabelHeightDistacnce          16
#define kBadgeWidthDistance            21
#define kRemindImageViewWidth          13
#define kRemindImageViewHeight         15
#define kRemindImageViewToRight        25
#define kBottomLineHeight              0.4



@interface MessageTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *messageDataSource;

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *badgeNumberLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *messageLabel;

@property (nonatomic,strong) EMMessage * message;

@property (nonatomic,strong) UILabel * goodLookLabel;
@property (nonatomic,strong) UILabel * goodLookTimeLabel;
@property (strong, nonatomic)  UIImageView *goodLookHeadImageView;
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

#pragma mark - 刷新界面
-(void)refreshTableView:(NSMutableArray *) dataSouceArr AndHeaderModel:(EMMessage *) model
{
    [self setUpHeaderView:model];
    self.messageDataSource = [NSMutableArray arrayWithArray:dataSouceArr];
    [self reloadData];
}

-(void)setUpHeaderView:(EMMessage *) model
{
    _message = model;
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRowHeight*2)];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)];
    [backView addGestureRecognizer:tapGestureRecognizer];
    backView.backgroundColor = [UIColor clearColor];
    //头像
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPaddingDistance, kPaddingDistance, kHeadWidthAndHeight, kHeadWidthAndHeight)];
    _headImageView.layer.cornerRadius = kHeadCornerRadius;
    _headImageView.clipsToBounds = YES;
    [_headImageView setNormalImageWithUrl:[YShareData defaultData][kShareData_SchoolIcon]];
    [backView addSubview:_headImageView];
    
    //姓名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*kPaddingDistance+kHeadWidthAndHeight, kPaddingDistance, 15*kPaddingDistance, kLabelHeightDistacnce)];
    _nameLabel.text = @"系统消息";
    _nameLabel.font = CONTENT_FONT(14);
    _nameLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_nameLabel];
    
    //消息数
    _badgeNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kPaddingDistance - kBadgeWidthDistance, kRowHeight - kLabelHeightDistacnce - kPaddingDistance, kBadgeWidthDistance, kLabelHeightDistacnce)];
    _badgeNumberLabel.font = CONTENT_FONT(10);
    _badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
    _badgeNumberLabel.textColor = [UIColor whiteColor];
    _badgeNumberLabel.backgroundColor = KCOLOR_009688;
    [backView addSubview:_badgeNumberLabel];
    
    //未读数
    NSUInteger unreadCount = model.conversation.unreadMessagesCount;
    if (unreadCount > 99) {
        _badgeNumberLabel.hidden = NO;
        _badgeNumberLabel.text = @"99+";
    }
    else if(unreadCount > 0)
    {
        _badgeNumberLabel.hidden = NO;
        _badgeNumberLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)unreadCount];
    }
    else
    {
        _badgeNumberLabel.hidden = YES;
    }
    //时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kPaddingDistance - kTimeLabelWidth, kPaddingDistance, kTimeLabelWidth, kLabelHeightDistacnce)];
    _timeLabel.font = CONTENT_FONT(9);
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.backgroundColor = [UIColor clearColor];
    if (model)
    {
        _timeLabel.text = [self lastMessageTimeByConversation:model];
    }
    else
    {
        _timeLabel.text = @"";
    }
    
    [backView addSubview:_timeLabel];

    //消息
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*kPaddingDistance + kHeadWidthAndHeight, kRowHeight - kLabelHeightDistacnce - kPaddingDistance, SCREEN_WIDTH - kBadgeWidthDistance - kHeadWidthAndHeight - 4*kPaddingDistance, kLabelHeightDistacnce)];
    _messageLabel.font = CONTENT_FONT(12);
    _messageLabel.textColor = KCOLORWHITE_696969;
    _messageLabel.backgroundColor = [UIColor clearColor];
    if (model)
    {
        _messageLabel.text = [self subTitleMessageByConversation:model];
    }
    else
    {
        _messageLabel.text = @"暂时没有系统消息";
    }
    
    [backView addSubview:_messageLabel];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kRowHeight-1, SCREEN_WIDTH, kBottomLineHeight)];
    bottomView.backgroundColor = [UIColor grayColor];
    bottomView.alpha = 0.6;
    [backView addSubview:bottomView];
    
    
//    self.tableHeaderView = backView;
    
    
    UIView * funBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kRowHeight, SCREEN_WIDTH, kRowHeight)];
    UITapGestureRecognizer * tapFunGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFunGestureRecognizerAction)];
    [funBackView addGestureRecognizer:tapFunGestureRecognizer];
    funBackView.backgroundColor = [UIColor clearColor];

    //头像
    _goodLookHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPaddingDistance, kPaddingDistance, kHeadWidthAndHeight, kHeadWidthAndHeight)];
    
    _goodLookHeadImageView.backgroundColor = [UIColor clearColor];
    [funBackView addSubview:_goodLookHeadImageView];

    //姓名
    UILabel * funNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*kPaddingDistance + kHeadWidthAndHeight, kPaddingDistance, kNameLabelWidth, kLabelHeightDistacnce)];
    funNameLabel.font = CONTENT_FONT(14);
    funNameLabel.text = @"好看";
    funNameLabel.backgroundColor = [UIColor clearColor];
    [funBackView addSubview:funNameLabel];

    //标签
    _goodLookLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*kPaddingDistance + kHeadWidthAndHeight, kRowHeight - kLabelHeightDistacnce - kPaddingDistance, 15*kPaddingDistance, kLabelHeightDistacnce)];
    _goodLookLabel.font = CONTENT_FONT(12);
    _goodLookLabel.textColor = KCOLORWHITE_696969;
    _goodLookLabel.text = @"你最关心的校园资讯";
    _goodLookLabel.backgroundColor = [UIColor clearColor];
    [funBackView addSubview:_goodLookLabel];

    
    //time
    _goodLookTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - kPaddingDistance - kTimeLabelWidth, kPaddingDistance, kTimeLabelWidth, kLabelHeightDistacnce)];
    _goodLookTimeLabel.font = CONTENT_FONT(9);
    _goodLookTimeLabel.textAlignment = NSTextAlignmentRight;
    _goodLookTimeLabel.backgroundColor = [UIColor clearColor];
    [funBackView addSubview:_goodLookTimeLabel];

    NSDictionary * ext = [[NSUserDefaults standardUserDefaults] objectForKey:@"GoodLookMessage"];
    if (nil != ext)
    {
        if ([ext[@"unreadGoodLook"] boolValue]) {
            _goodLookHeadImageView.image = [UIImage imageNamed:@"goodlook_see_y"];
        } else {
            _goodLookHeadImageView.image = [UIImage imageNamed:@"goodlook_see"];
        }
        
        _goodLookLabel.text = ext[@"em_apns_ext"][@"em_push_title"];
        _goodLookTimeLabel.text = [YUtils distanceTimeToday:[NSDate dateWithTimeIntervalSince1970:[ext[@"timestamp"] integerValue]/1000]];
    }
    else
    {
        _goodLookHeadImageView.image = [UIImage imageNamed:@"goodlook_see"];
        _goodLookLabel.text = @"你最关心的校园资讯";
        _goodLookTimeLabel.text = @"";
    }
    
    //底线
    UIView * funBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kRowHeight-1, SCREEN_WIDTH, kBottomLineHeight)];
    funBottomView.backgroundColor = [UIColor grayColor];
    funBottomView.alpha = 0.6;
    [funBackView addSubview:funBottomView];
    
    [backView addSubview:funBackView];
    
    
    //    [backView addSubview:funBackView];
    
//    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRowHeight)];
    UITapGestureRecognizer * tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFunGestureRecognizerAction)];
    [funBackView addGestureRecognizer:tapGestureRecognizer1];
    funBackView.backgroundColor = [UIColor clearColor];
    
    
    self.tableHeaderView = backView;
    
//    //头像
//    _headImageView = [[UIImageView alloc] init];
//    _headImageView.layer.cornerRadius = kHeadCornerRadius;
//    _headImageView.clipsToBounds = YES;
////    _headImageView.image = [YShareData defaultData][kShareData_SchoolIcon];
//    [_headImageView setNormalImageWithUrl:[YShareData defaultData][kShareData_SchoolIcon]];
//    [backView addSubview:_headImageView];
//    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_equalTo(kPaddingDistance);
//        make.width.height.mas_equalTo(kHeadWidthAndHeight);
//    }];
//    
//    
//    //姓名
//    _nameLabel = [[UILabel alloc] init];
//    _nameLabel.text = @"系统消息";
//    _nameLabel.font = CONTENT_FONT(14);
//    _nameLabel.backgroundColor = [UIColor clearColor];
//    [backView addSubview:_nameLabel];
//    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(kPaddingDistance);
//        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
//        make.height.mas_equalTo(kLabelHeightDistacnce);
//    }];
//    //消息数
//    _badgeNumberLabel = [[UILabel alloc] init];
//    _badgeNumberLabel.font = CONTENT_FONT(10);
//    _badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
//    _badgeNumberLabel.textColor = [UIColor whiteColor];
//    _badgeNumberLabel.backgroundColor = KCOLOR_009688;
//    [backView addSubview:_badgeNumberLabel];
//    [_badgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-kPaddingDistance);
//        make.right.equalTo(backView).offset(-kPaddingDistance);
//        make.height.mas_equalTo(kLabelHeightDistacnce);
//        make.width.mas_equalTo(kBadgeWidthDistance);
//    }];
//    //未读数
//    NSUInteger unreadCount = model.conversation.unreadMessagesCount;
//    if (unreadCount > 99) {
//        _badgeNumberLabel.hidden = NO;
//        _badgeNumberLabel.text = @"99+";
//    }
//    else if(unreadCount > 0)
//    {
//        _badgeNumberLabel.hidden = NO;
//        _badgeNumberLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)unreadCount];
//    }
//    else
//    {
//        _badgeNumberLabel.hidden = YES;
//    }
//    //时间
//    _timeLabel = [[UILabel alloc] init];
//    _timeLabel.font = CONTENT_FONT(9);
//    _timeLabel.textAlignment = NSTextAlignmentRight;
//    _timeLabel.backgroundColor = [UIColor clearColor];
//    if (model)
//    {
//        _timeLabel.text = [self lastMessageTimeByConversation:model];
//    }
//    else
//    {
//        _timeLabel.text = @"";
//    }
//    
//    [backView addSubview:_timeLabel];
//    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(kPaddingDistance);
//        make.right.mas_equalTo(-kPaddingDistance);
//        make.width.mas_equalTo(kTimeLabelWidth);
//        make.height.mas_equalTo(kLabelHeightDistacnce);
//    }];
//    //消息
//    _messageLabel = [[UILabel alloc] init];
//    _messageLabel.font = CONTENT_FONT(12);
//    _messageLabel.backgroundColor = [UIColor clearColor];
//    if (model)
//    {
//        _messageLabel.text = [self subTitleMessageByConversation:model];
//    }
//    else
//    {
//        _messageLabel.text = @"暂时没有系统消息";
//    }
//    
//    [backView addSubview:_messageLabel];
//    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-kPaddingDistance);
//        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
//        make.right.equalTo(_badgeNumberLabel.mas_left).offset(-kPaddingDistance);
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

-(void)tapFunGestureRecognizerAction
{
    //好看相关节面
    [_myController.navigationController pushViewController:[[InterestViewController alloc] init] animated:true];
    
    //修改缓存
    NSMutableDictionary * ext = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"GoodLookMessage"]];
    [ext setObject:@NO forKey:@"unreadGoodLook"];
    [[NSUserDefaults standardUserDefaults] setObject:ext forKey:@"GoodLookMessage"];
}

-(void)refreshGoodLook:(EMMessage *) message
{
    NSMutableDictionary * ext = [NSMutableDictionary dictionaryWithDictionary:message.ext];
    if (nil != ext)
    {
        _goodLookHeadImageView.image = [UIImage imageNamed:@"goodlook_see_y"];
        _goodLookLabel.text = ext[@"em_apns_ext"][@"em_push_title"];
        _goodLookTimeLabel.text = [YUtils distanceTimeToday:[NSDate dateWithTimeIntervalSince1970:message.timestamp/1000]];
        [ext setObject:@YES forKey:@"unreadGoodLook"];
        [[NSUserDefaults standardUserDefaults] setObject:ext forKey:@"GoodLookMessage"];
    }
}

#pragma mark - 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMMessage *)model
{
    NSString *ret = @"";
    EMMessage *lastMessage = model;
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = NSLocalizedString(@"[图片]", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                if ([[RobotManager sharedInstance] isRobotMenuMessage:lastMessage]) {
                    ret = [[RobotManager sharedInstance] getRobotMenuMessageDigest:lastMessage];
                } else {
                    ret = didReceiveText;
                }
            } break;
            case eMessageBodyType_Voice:{
                ret = NSLocalizedString(@"[语音]", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                ret = NSLocalizedString(@"[位置]", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                ret = NSLocalizedString(@"[视频]", @"[video]");
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}
#pragma mark - headerView点击事件
-(void)tapGestureRecognizerAction
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    for (EMConversation *conversation in conversations) {
        if ([conversation.chatter isEqualToString:KSYSTEM_MESSAGEID])
        {
            [conversation markAllMessagesAsRead:YES];
        }
    }
    
    [[MessageManager sharedInstance] setupUnreadMessageCount];
    XYSystemMessageViewController * systemMessageViewController = [[XYSystemMessageViewController alloc] init];
    [self.myController.navigationController pushViewController:systemMessageViewController animated:YES needHiddenBottomBar:YES];
}

#pragma mark - 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMMessage *)model
{
    NSString *ret = @"";
    ret = [YUtils distanceTimeToday:[NSDate dateWithTimeIntervalSince1970:model.timestamp/1000]];
    
    return ret;
}

#pragma mark - 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    return conversation.unreadMessagesCount;
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
    if (editingStyle == UITableViewCellEditingStyleDelete && _messageDataSource.count > indexPath.row) {
        EMConversation *converation = [_messageDataSource objectAtIndex:indexPath.row];
        //删除前清空该回话未读数
        [converation markAllMessagesAsRead:YES];
        [[MessageManager sharedInstance] setupUnreadMessageCount];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:YES append2Chat:NO];
        [_messageDataSource removeObjectAtIndex:indexPath.row];
        [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMConversation *converation = [_messageDataSource objectAtIndex:indexPath.row];
    
    NSDictionary *ext = converation.latestMessageFromOthers.ext;
    if ([ext[@"server_flag"] boolValue]) {
        //非聊天消息
        if (FRIEND_APPLY == [ext[@"type"] integerValue]) {
            [_myController.navigationController pushViewController:[[XYFriendApplyViewController alloc] initWithChatter:converation.chatter] animated:YES needHiddenBottomBar:YES];
        } else if (GROUP_APPLY == [ext[@"type"] integerValue]) {
            [_myController.navigationController pushViewController:[[XYGroupApplyViewController alloc] initWithGroupId:[NSString stringWithFormat:@"%d", [ext[@"group_id"] intValue]] chatter:converation.chatter] animated:YES needHiddenBottomBar:YES];
        }
        [converation markAllMessagesAsRead:YES];
    } else {
        MessageTableViewCell * cell = (MessageTableViewCell *)[self cellForRowAtIndexPath:indexPath];
        self.myController.hidesBottomBarWhenPushed = YES;
        ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:cell.conversation.chatter isGroup:converation.conversationType];
        chatVC.isSystemMessage = NO;
        chatVC.studentDic = [cell.studentDic  mutableCopy];
        [self.myController.navigationController pushViewController:chatVC animated:YES];
    }
    
}



@end
