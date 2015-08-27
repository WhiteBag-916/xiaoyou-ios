//
//  MessageTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "Masonry.h"
#import "YSystemDefine.h"
#import "RobotManager.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "UIImageView+WebCache.h"
#import "NSDate+Category.h"
#import "ContactManager.h"
#import "LinkManList.h"
#import "ClassList.h"

#define kHeadWidthAndHeight            40
#define kNameLabelWidth                80
#define kTimeLabelWidth                60
#define kHeadCornerRadius              20
#define kPaddingDistance               10
#define kLabelHeightDistacnce          14
#define kBadgeWidthDistance            21
#define kClassLabelDistance            5
#define kClassLabelWidthAndHeight      30


typedef enum : NSUInteger {
    LINKkMAN_TYPE,
    CLASS_TYPE,
    UNION_TYPE,
} LinkManModel_TYPE;

NSString *const kMessageTableViewCell = @"MessageTableViewCellId";

@interface MessageTableViewCell ()

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *badgeNumberLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *messageLabel;
@property (nonatomic,strong)  UILabel * defaultLabel;

@property (nonatomic,assign) NSInteger * badgeNum;

@end

@implementation MessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = kHeadCornerRadius;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(kPaddingDistance);
            make.width.height.mas_equalTo(kHeadWidthAndHeight);
        }];
        //defaultLabel
        _defaultLabel = [[UILabel alloc] init];
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
        _defaultLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_defaultLabel];
        [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headImageView.mas_top).offset(kClassLabelDistance);
            make.left.mas_equalTo(_headImageView.mas_left).offset(kClassLabelDistance);
            make.width.height.mas_equalTo(kClassLabelWidthAndHeight);
        }];
        //姓名
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = CONTENT_FONT(14);
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kPaddingDistance);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
            make.width.mas_equalTo(kNameLabelWidth);
            make.height.mas_equalTo(kLabelHeightDistacnce);
        }];
        //消息数
        _badgeNumberLabel = [[UILabel alloc] init];
        _badgeNumberLabel.hidden = YES;
        _badgeNumberLabel.font = CONTENT_FONT(10);
        _badgeNumberLabel.textColor = [UIColor whiteColor];
        _badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
        _badgeNumberLabel.backgroundColor = [UIColor hexChangeFloat:@"258f74"];
        [self.contentView addSubview:_badgeNumberLabel];
        [_badgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kPaddingDistance);
            make.right.equalTo(self.contentView).offset(-kPaddingDistance);
            make.height.mas_equalTo(kLabelHeightDistacnce);
            make.width.mas_equalTo(kBadgeWidthDistance);
        }];
        //时间
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = CONTENT_FONT(9);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_timeLabel];
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
        [self.contentView addSubview:_messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kPaddingDistance);
            make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
            make.right.equalTo(_badgeNumberLabel.mas_left).offset(-kPaddingDistance);
            make.height.mas_equalTo(kLabelHeightDistacnce);
        }];
        
    }
    return self;
}

-(void)setCellInfo:(id) dic
{
    EMConversation * conversation = dic;
    
    NSDictionary * userInfoDic = [self getUserInfo:conversation];
    
    _studentDic = userInfoDic;
    //消息内容
    _messageLabel.text = [self subTitleMessageByConversation:conversation];
    
    //昵称
//    _nameLabel.text = userInfoDic[@"name"];
    _nameLabel.text = conversation.latestMessage.ext[@"userName"];

    
    //头像
    [_headImageView setFaceImageWithUrl:userInfoDic[@"icon"]];
   
    //未读数
    if (![[self unreadMessageCountByConversation:conversation] isEqualToString:@"0"]) {
        _badgeNumberLabel.hidden = NO;
        _badgeNumberLabel.text = [self unreadMessageCountByConversation:conversation];
    }
    else
    {
        _badgeNumberLabel.hidden = YES;
    }
    //时间
    _timeLabel.text = [self lastMessageTimeByConversation:conversation];


    
}

-(NSDictionary *)getUserInfo:(EMConversation *) conversation
{
    LinkManModel * model = [[ContactManager sharedInstance] getContactsListData];
    
    NSMutableArray * modelLinkMan = [[NSMutableArray alloc] initWithArray:model.linkManList];
    NSMutableArray * modelClass = [[NSMutableArray alloc] initWithArray:model.classList];
    NSMutableArray * modelUnion = [[NSMutableArray alloc] initWithArray:model.unionList];

    
    for (LinkManList * obj in modelLinkMan) {
        if ([conversation.chatter isEqualToString:obj.thirdCode])
        {
            return [obj dictionaryRepresentation];
        }
    }
    for (ClassList * obj in modelClass) {
        if ([conversation.chatter isEqualToString:obj.thirdCode])
        {
            return [obj dictionaryRepresentation];
        }
    }
    for (ClassList * obj in modelUnion) {
        if ([conversation.chatter isEqualToString:obj.thirdCode])
        {
            return [obj dictionaryRepresentation];
        }
    }
    return nil;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
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

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSString *)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    NSString * count = [NSString stringWithFormat:@"%ld",ret];
    
    return  count;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
