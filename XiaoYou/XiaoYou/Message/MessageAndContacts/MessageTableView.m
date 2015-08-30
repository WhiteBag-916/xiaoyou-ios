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

#define kRowHeight                     68
#define kHeadWidthAndHeight            40
#define kNameLabelWidth                80
#define kTimeLabelWidth                60
#define kHeadCornerRadius              20
#define kPaddingDistance               10
#define kLabelHeightDistacnce          14
#define kBadgeWidthDistance            21
#define kBottomLineHeight              0.4



@interface MessageTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *messageDataSource;

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *badgeNumberLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *messageLabel;

@property (nonatomic,strong) EMMessage * message;

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


-(void)refreshTableView:(NSMutableArray *) dataSouceArr AndHeaderModel:(EMMessage *) model
{
    [self setUpHeaderView:model];
    _messageDataSource = dataSouceArr;
    [self reloadData];
}

-(void)setUpHeaderView:(EMMessage *) model
{
    _message = model;
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRowHeight)];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)];
    [backView addGestureRecognizer:tapGestureRecognizer];
    //头像
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = kHeadCornerRadius;
    _headImageView.clipsToBounds = YES;
//    _headImageView.image = [YShareData defaultData][kShareData_SchoolIcon];
    [_headImageView setNormalImageWithUrl:[YShareData defaultData][kShareData_SchoolIcon]];
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
    _badgeNumberLabel.font = CONTENT_FONT(10);
    _badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
    _badgeNumberLabel.textColor = [UIColor whiteColor];
    _badgeNumberLabel.backgroundColor = KCOLORGREEN_009688;
    [backView addSubview:_badgeNumberLabel];
    [_badgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kPaddingDistance);
        make.right.equalTo(backView).offset(-kPaddingDistance);
        make.height.mas_equalTo(kLabelHeightDistacnce);
        make.width.mas_equalTo(kBadgeWidthDistance);
    }];
    //未读数
    NSUInteger unreadCount = model.conversation.unreadMessagesCount;
    if (unreadCount > 0) {
        _badgeNumberLabel.hidden = NO;
        _badgeNumberLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)unreadCount];
    }
    else
    {
        _badgeNumberLabel.hidden = YES;
    }
    //时间
    _timeLabel = [[UILabel alloc] init];
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
    if (model)
    {
        _messageLabel.text = [self subTitleMessageByConversation:model];
    }
    else
    {
        _messageLabel.text = @"暂时没有系统消息";
    }
    
    [backView addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.right.equalTo(_badgeNumberLabel.mas_left).offset(-kPaddingDistance);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor grayColor];
    bottomView.alpha = 0.6;
    [backView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kBottomLineHeight);
    }];
    
    self.tableHeaderView = backView;
}

// 得到最后消息文字或者类型
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

-(void)tapGestureRecognizerAction
{
    [_message.conversation markAllMessagesAsRead:YES];
    [[MessageManager sharedInstance] setupUnreadMessageCount];
    XYSystemMessageViewController * systemMessageViewController = [[XYSystemMessageViewController alloc] init];
    [self.myController.navigationController pushViewController:systemMessageViewController animated:YES needHiddenBottomBar:YES];
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMMessage *)model
{
    NSString *ret = @"";
    ret = [YUtils distanceTimeToday:[NSDate dateWithTimeIntervalSince1970:model.timestamp/1000]];
    
    return ret;
}

// 得到未读消息条数
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMConversation *converation = [_messageDataSource objectAtIndex:indexPath.row];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:converation.chatter deleteMessages:YES append2Chat:YES];
        [_messageDataSource removeObjectAtIndex:indexPath.row];
        [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0)
//    {
//        XYSystemMessageViewController * systemMessageViewController = [[XYSystemMessageViewController alloc] init];
//        [self.myController.navigationController pushViewController:systemMessageViewController animated:YES needHiddenBottomBar:YES];
//    }
//    else
    {
        EMConversation *converation = [_messageDataSource objectAtIndex:indexPath.row];
        
        NSDictionary *ext = converation.latestMessageFromOthers.ext;
        if ([ext[@"server_flag"] boolValue]) {
            //非聊天消息
            if (FRIEND_APPLY == [ext[@"type"] integerValue]) {
                [_myController.navigationController pushViewController:[[XYFriendApplyViewController alloc] init] animated:YES needHiddenBottomBar:YES];
            } else if (GROUP_APPLY == [ext[@"type"] integerValue]) {
                [_myController.navigationController pushViewController:[[XYGroupApplyViewController alloc] initWithGroupId:[NSString stringWithFormat:@"%d", [ext[@"group_id"] intValue]]] animated:YES needHiddenBottomBar:YES];
            }
            [converation markAllMessagesAsRead:YES];
        } else {
            MessageTableViewCell * cell = (MessageTableViewCell *)[self cellForRowAtIndexPath:indexPath];
            self.myController.hidesBottomBarWhenPushed = YES;
            
            if ([cell.studentDic[@"linkType"] doubleValue] == 0) {
                ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:cell.conversation.chatter isGroup:NO];
                chatVC.isSystemMessage = NO;
                chatVC.studentDic = [cell.studentDic  mutableCopy];
                [self.myController.navigationController pushViewController:chatVC animated:YES];
            }
            else
            {
                ChatViewController * chatVC = [[ChatViewController alloc] initWithChatter:cell.conversation.chatter isGroup:YES];
                chatVC.isSystemMessage = NO;
                chatVC.studentDic = [cell.studentDic mutableCopy];
                [self.myController.navigationController pushViewController:chatVC animated:YES];
            }
        }
    }
}



@end
