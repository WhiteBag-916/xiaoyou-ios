//
//  SystemMessageTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SystemMessageTableView.h"
#import "NormalSystemMessageTableViewCell.h"
#import "ApplySuccessSystemMessageTableViewCell.h"
#import "EMMessage.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "RobotManager.h"
#import "ChatViewController.h"
#import "ClassList.h"
#import "ContactManager.h"
#import "PPLabel.h"

@interface SystemMessageTableView ()
<UITableViewDataSource,UITableViewDelegate,ApplySuccessSystemMessageTableViewCellDelegat>

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

@end

@implementation SystemMessageTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        //cell的分割线
        self.separatorStyle = NO;

        [self registerClass:[NormalSystemMessageTableViewCell class]
     forCellReuseIdentifier:kNormalSystemMessageTableViewCell];
        [self registerClass:[ApplySuccessSystemMessageTableViewCell class]
     forCellReuseIdentifier:kApplySuccessSystemMessageTableViewCell];
    }
    return self;
}

-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
    _dataSouceArr = dataSouceArr;
    [self reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EMMessage * message = _dataSouceArr[indexPath.row];
    
    if ([[message.ext[@"sub_type"] stringValue] isEqualToString:@"1"])
    {
        NormalSystemMessageTableViewCell * cell =
        [self dequeueReusableCellWithIdentifier:kNormalSystemMessageTableViewCell
                                   forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellInfo:_dataSouceArr[indexPath.row]];
        
        return cell;
    }
    else
    {
        ApplySuccessSystemMessageTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kApplySuccessSystemMessageTableViewCell forIndexPath:indexPath];
        cell.delegat = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellInfo:_dataSouceArr[indexPath.row]];
        
        return cell;
    }  
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    EMMessage * message = _dataSouceArr[indexPath.row];
    
    UIFont * font = CONTENT_FONT(12);
    CGSize titleSize = [[self subTitleMessageByConversation:message] sizeWithFont:font
                       constrainedToSize:CGSizeMake(SCREEN_WIDTH - 103, MAXFLOAT)];
    if (titleSize.height < 25)
    {
        if ([[message.ext[@"sub_type"] stringValue] isEqualToString:@"1"])
        {
            return 75;
        }
        else
        {
            return 100;
        }
        
    }
    else
    {
        if ([[message.ext[@"sub_type"] stringValue] isEqualToString:@"1"])
        {
             return titleSize.height + 70;
        }
        else
        {
             return 100;
        }
        
    }
    return 75;
   
}

#pragma mark -  得到最后消息文字或者类型
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

#pragma mark - ApplySuccessSystemMessageTableViewCellDelegat

-(void)turnToGroupChat:(NSDictionary *) groupDic
{
    ClassList * model =  [[ContactManager sharedInstance] getClassByThirdCode:groupDic[@"group_id"]];
    if (nil != model) {
        [YAnalysis trackEvent:@"进入群聊_消息" withPara:@{@"名称":model.name, @"学校":model.schoolCode}];
        ChatViewController * chatVC =
        [[ChatViewController alloc] initWithChatter:groupDic[@"third_code"] isGroup:YES];
        chatVC.isSystemMessage = NO;
        chatVC.studentDic = [[model dictionaryRepresentation] mutableCopy];
        [self.myController.navigationController pushViewController:chatVC
                                                          animated:YES needHiddenBottomBar:YES];
    } else {
        [YUtils showTitle:@"您已不在此社团群聊中"];
    }
    
}

@end
