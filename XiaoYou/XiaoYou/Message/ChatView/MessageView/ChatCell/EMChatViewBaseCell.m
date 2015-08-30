/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "EMChatViewBaseCell.h"
#import "UIImageView+EMWebCache.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"
#import "ContactManager.h"

NSString *const kRouterEventChatHeadImageTapEventName = @"kRouterEventChatHeadImageTapEventName";

@interface EMChatViewBaseCell()

@end

@implementation EMChatViewBaseCell

- (id)initWithMessageModel:(MessageModel *)model reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImagePressed:)];
        CGFloat originX = HEAD_PADDING;
        if (model.isSender) {
            originX = self.bounds.size.width - HEAD_SIZE - HEAD_PADDING;
        }
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, CELLPADDING, HEAD_SIZE, HEAD_SIZE)];
        [_headImageView addGestureRecognizer:tap];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.multipleTouchEnabled = YES;
        _headImageView.layer.cornerRadius = 20;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor clearColor];
//        UIGestureRecognizer * gestureRecognizer = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeadImageView:)];
//        [_headImageView addGestureRecognizer:gestureRecognizer];
        
        [self.contentView addSubview:_headImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_nameLabel];
        
        [self setupSubviewsForMessageModel:model];
    }
    return self;
}

-(void)tapHeadImageView:(MessageModel *)model
{
    //    if ([cell.studentDic[@"linkType"] doubleValue] == 0) {
    //        XYContactsInfoDetailViewController * contactsInfoDetailVC = [[XYContactsInfoDetailViewController alloc] init];
    //        contactsInfoDetailVC.studentDic = cell.studentDic;
    //        contactsInfoDetailVC.uid = cell.studentDic[@"uid"];
    //        [self.myController.navigationController pushViewController:contactsInfoDetailVC animated:YES needHiddenBottomBar:YES];
    //    }
    //    else
    //    {
    //        XYGroupInfoDetailViewController * groupInfoDetailViewController = [[XYGroupInfoDetailViewController alloc] init];
    //        groupInfoDetailViewController.studentDic = cell.studentDic;
    //        [self.myController.navigationController pushViewController:groupInfoDetailViewController animated:YES needHiddenBottomBar:YES];
    //    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = _headImageView.frame;
    frame.origin.x = _messageModel.isSender ? (self.bounds.size.width - _headImageView.frame.size.width - HEAD_PADDING) : HEAD_PADDING;
    _headImageView.frame = frame;

    [_nameLabel sizeToFit];
    frame = _nameLabel.frame;
    frame.origin.x = HEAD_PADDING * 2 + CGRectGetWidth(_headImageView.frame) + NAME_LABEL_PADDING;
    frame.origin.y = CGRectGetMinY(_headImageView.frame);
    frame.size.width = NAME_LABEL_WIDTH;
    _nameLabel.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter

- (void)setMessageModel:(MessageModel *)messageModel
{
    _messageModel = messageModel;
    
    _nameLabel.hidden = (messageModel.messageType == eMessageTypeChat);

    
    if (messageModel.isSender == NO) {
//        UIImage *placeholderImage = [UIImage imageNamed:@"default_head"];
//        [self.headImageView sd_setImageWithURL:_messageModel.headImageURL placeholderImage:placeholderImage];
//        NSLog(@"%@",_messageModel.message.ext[@"headImage"]);
        if (messageModel.messageType == eMessageTypeChat) {
            if (nil != _messageModel.headImageURL) {
                [self.headImageView sd_setImageWithURL:_messageModel.headImageURL placeholderImage:[UIImage imageNamed:@"default_head"]];
            } else {
                [self.headImageView setFaceImageWithUrl:_messageModel.message.ext[@"headImage"]];
            }
        } else if (messageModel.messageType == eMessageTypeGroupChat) {
            LinkManList *manModel = [[ContactManager sharedInstance] getManByThirdCode:_messageModel.message.groupSenderName];
            if (nil != manModel) {
                [self.headImageView setFaceImageWithUrl:manModel.icon];
            } else {
                [self.headImageView setFaceImageWithUrl:_messageModel.message.ext[@"headImage"]];
            }
        }
    }
    else
    {
        NSLog(@"%@",[[ProvisionManager sharedInstance] getProfile].headPic);
        [self.headImageView setFaceImageWithUrl:[[ProvisionManager sharedInstance] getProfile].headPic];

    }
    
}

#pragma mark - private

-(void)headImagePressed:(id)sender
{
    [super routerEventWithName:kRouterEventChatHeadImageTapEventName userInfo:@{KMESSAGEKEY:self.messageModel}];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [super routerEventWithName:eventName userInfo:userInfo];
}

#pragma mark - public

- (void)setupSubviewsForMessageModel:(MessageModel *)model
{
    if (model.isSender) {
        self.headImageView.frame = CGRectMake(self.bounds.size.width - HEAD_SIZE - HEAD_PADDING, CELLPADDING, HEAD_SIZE, HEAD_SIZE);
    }
    else{
        self.headImageView.frame = CGRectMake(0, CELLPADDING, HEAD_SIZE, HEAD_SIZE);
    }
}

+ (NSString *)cellIdentifierForMessageModel:(MessageModel *)model
{
    NSString *identifier = @"MessageCell";
    if (model.isSender) {
        identifier = [identifier stringByAppendingString:@"Sender"];
    }
    else{
        identifier = [identifier stringByAppendingString:@"Receiver"];
    }
    
    switch (model.type) {
        case eMessageBodyType_Text:
        {
            identifier = [identifier stringByAppendingString:@"Text"];
        }
            break;
        case eMessageBodyType_Image:
        {
            identifier = [identifier stringByAppendingString:@"Image"];
        }
            break;
        case eMessageBodyType_Voice:
        {
            identifier = [identifier stringByAppendingString:@"Audio"];
        }
            break;
        case eMessageBodyType_Location:
        {
            identifier = [identifier stringByAppendingString:@"Location"];
        }
            break;
        case eMessageBodyType_Video:
        {
            identifier = [identifier stringByAppendingString:@"Video"];
        }
            break;
            
        default:
            break;
    }
    
    return identifier;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(MessageModel *)model
{
    return HEAD_SIZE + CELLPADDING;
}

@end
