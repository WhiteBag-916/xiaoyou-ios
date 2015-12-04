//
//  ApplySuccessSystemMessageTableViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ConvertToCommonEmoticonsHelper.h"
#import "RobotManager.h"
#import "ApplySuccessSystemMessageTableViewCell.h"

#define kHeadImageViewHeightAndWidth        40
#define kPaddingDistance                    5
#define kHeadCornerRadius                   20
#define kBackTopAndBottom                   10
#define kBackLeft                           20
#define kBackRight                          16
#define kChatButtonHeight                   20

NSString *const kApplySuccessSystemMessageTableViewCell = @"ApplySuccessSystemMessageTableViewCellId";

@interface ApplySuccessSystemMessageTableViewCell ()

@property(nonatomic,strong)UIImageView      *headImageView;
@property(nonatomic,strong)UIImageView      *backImageView;
@property(nonatomic,strong)UILabel          *contentLabel;
@property(nonatomic,strong)UIButton         *chatButton;
@property(nonatomic,strong)UILabel          *defaultLabel;
@property (nonatomic,strong)NSDictionary    *groupDic;

@end

@implementation ApplySuccessSystemMessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    //头像
    self.headImageView = [YUtils initImageViewWithBackgroundColor:[UIColor clearColor]
                                                     cornerRadius:kHeadCornerRadius
                                                    clipsToBounds:YES
                                                            image:nil];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3*kPaddingDistance);
        make.left.mas_equalTo(2*kPaddingDistance);
        make.width.height.mas_equalTo(kHeadImageViewHeightAndWidth);
    }];
    
    //头像上的默认字
    self.defaultLabel = [YUtils initLabelWithBackgroundColor:[UIColor clearColor]
                                                    font:CONTENT_FONT(17)
                                           numberOfLines:1
                                           textAlignment:NSTextAlignmentCenter
                                               textColor:[UIColor whiteColor]
                                                    text:@""];
    [self.contentView addSubview:_defaultLabel];
    [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3*kPaddingDistance);
        make.left.mas_equalTo(2*kPaddingDistance);
        make.width.height.mas_equalTo(kHeadImageViewHeightAndWidth);
    }];
    //默认气泡
    _backImageView = [[UIImageView alloc] init];
    _backImageView.image =
    [[UIImage imageNamed:@"chat_receiver_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 24,
                                                                                           30, 24)
                                                             resizingMode:UIImageResizingModeStretch];;
    [self.contentView addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3*kPaddingDistance);
        make.right.mas_equalTo(-4*kPaddingDistance);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.height.mas_equalTo(55);
    }];
    //进入群聊按钮
    self.chatButton = [YUtils initButtonWithBackgroundColor:[UIColor clearColor]
                                                      title:@"进入群聊"
                                              clipsToBounds:YES
                                               cornerRadius:3
                                                       font:CONTENT_FONT(12)
                                                  tintColor:[UIColor whiteColor]
                                                      image:[UIImage imageNamed:@"contacts_bottom"]
                                                     target:self
                                                     action:@selector(tapChatButton)];

    [self.contentView addSubview:_chatButton];
    [_chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kPaddingDistance);
        make.height.mas_equalTo(kChatButtonHeight);
        make.left.mas_equalTo(_backImageView.mas_left).offset(4*kPaddingDistance);
        make.right.mas_equalTo(-6*kPaddingDistance);
    }];
    //文字内容Label
    self.contentLabel = [YUtils initLabelWithBackgroundColor:[UIColor clearColor]
                                                        font:CONTENT_FONT(12)
                                               numberOfLines:0
                                               textAlignment:NSTextAlignmentLeft
                                                   textColor:[UIColor blackColor]
                                                        text:@""];
    [_backImageView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kBackTopAndBottom);
        make.left.mas_equalTo(kBackLeft);
        make.height.mas_equalTo(kPaddingDistance*7);
        make.right.mas_equalTo(-kBackRight);
    }];
}

-(void)tapChatButton
{
    if (nil != _delegat && [_delegat respondsToSelector:@selector(turnToGroupChat:)]) {
        [_delegat turnToGroupChat:_groupDic];
    }
}
#pragma mark - 进入群聊点击事件
-(void)setCellInfo:(EMMessage *) message
{
    if (message.ext)
    {
        _groupDic = message.ext ;
    }
    _contentLabel.text = [self subTitleMessageByConversation:message];
    _chatButton.backgroundColor = [UIColor clearColor];
    if ([message.ext[@"group_icon"] isEqualToString:@""])
    {
        _headImageView.backgroundColor = KCOLOR_009688;
        _defaultLabel.text = [message.ext[@"group_name" ] substringWithRange:NSMakeRange(0, 1)];
    }
    else
    {
        [_headImageView setFaceImageWithUrl:message.ext[@"group_icon"]];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
