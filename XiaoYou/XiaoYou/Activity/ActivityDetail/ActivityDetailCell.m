//
//  FunnyDetailCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityDetailCell.h"
#import "ActivityTopView.h"
#import "ActivityMiddleView.h"
#import "FeedImageGroup.h"
#import "ActivityImageTextModels.h"
#import "TimeFormatterConvert.h"
#import "XYContactsInfoDetailViewController.h"
#import "XYGroupInfoDetailViewController.h"
#import "ActivityPublishedModel.h"
#import "YWebViewController.h"
#import "ProfileMyViewController.h"
#import "ProfileViewController.h"
#import "YTextView.h"
#import "ActivityDetailListView.h"

#define HEADIMAGEVIEW_WIDTH         SCALE_NUM(45)
#define LEADINGOFF_HEADIMAGEVIEW    SCALE_NUM(12)

@interface ActivityDetailCell ()<UITextViewDelegate, FeedImageGroupDelegate>

#pragma mark 顶部TopView
@property (nonatomic,strong) UIImageView    *headImageView; //公告图
@property (nonatomic,strong) UIView         *sepLineView;   //分割线
@property (nonatomic,strong) UITextView     *nameLabel;     //名称
@property (nonatomic,strong) UITextView     *titleLabel;    //标题(校级活动公告)
@property (nonatomic,strong) UILabel        *staticNameLabel;//静态name
@property (nonatomic,strong) UILabel        *staticDesLabel; //简介
@property (nonatomic,strong) YTextView      *descriptionLabel;//描述,只显示一行;
#pragma mark 中间MiddleView
@property (nonatomic,strong) FeedImageGroup *middleView;
#pragma mark 底部BottomView
@property (nonatomic,strong) UIImageView    *timeImageView;             //报名截止时间
@property (nonatomic,strong) UITextView     *staticDeadLineDes;         //截止时间
@property (nonatomic,strong) UITextView     *deadLineTimeLabel;         //截止
@property (nonatomic,strong) UITextView     *staticActivityTimeDes;     //活动时间
@property (nonatomic,strong) UITextView     *activityTimeLabel;         //活动时间
@property (nonatomic,strong) UIImageView    *locationImageView;
@property (nonatomic,strong) UITextView     *locationLabel;             //地点
@property (nonatomic,strong) UIImageView    *categotyImageView;         //类别
@property (nonatomic,strong) UITextView     *categoryLabel;             //类别
@property (nonatomic,strong) UITextView     *staticActivityEndTimeDes;  //活动结束时间
@property (nonatomic,strong) UITextView     *activityEndTimeLabel;      //活动结束时间
#pragma mark 查看链接
@property (nonatomic,strong) UIButton               *jumpLinkButton;            //查看活动链接
@property (nonatomic,strong) ActivityDetailModel    *detailModel;

@property (nonatomic,copy) NSString *contentStr;

@end
@implementation ActivityDetailCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initTopView];
        [self initMiddleView];
        [self initBottomView];
    }
    return self;
}


-(void)initMiddleView {
    _middleView = [[FeedImageGroup alloc]init];
    _middleView.delegate = self;
    [self.contentView addSubview:_middleView];
    
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descriptionLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(_descriptionLabel.mas_left);
        make.right.equalTo(_descriptionLabel);
    }];
}

- (void)didOpenPhoto {
    [YAnalysis trackEvent:@"活动图片_活动详情" withPara:@{@"名称":_nameLabel.text}];
}

#pragma mark 重载
-(BOOL)needLine
{
    return YES;
}

-(void)setData:(ActivityDetailModel *)model
{
    _detailModel = model;
    ActivityOrganizer *organizer = model.activityOrganizer;
    ActivityTypeInfo *info = model.activityTypeInfo;
    ActivityPublishedModel *publishModel = model.activityPublishedDto.activityPublishedModel;
    [_headImageView setFaceImageWithUrl:organizer.headPic];
    _titleLabel.text = organizer.name;
    
    [YUtils setTextViewDataWithTextView:_nameLabel text:publishModel.name
                                   Font:CONTENT_FONT(13) textColor:KCOLOR_B4 linespaing:5];
    
    NSArray *imageTextModels = model.activityPublishedDto.activityImageTextModels;
    //图片内容是否为空
    BOOL notHaveImage = YES;
    for (ActivityImageTextModels *imageText in imageTextModels) {
        
        if ([imageText.type isEqualToString:@"image"]) {
            if (imageText.content != nil && ![imageText.content isEmpty]) {
                [_middleView updateWithImgs:@[imageText.content] bigPics:@[imageText.content]];
                notHaveImage = NO;
            }
        } else if ([imageText.type isEqualToString:@"text"]) {
            [_descriptionLabel setTextViewDataWithText:imageText.content font:CONTENT_FONT(12)
                                             textColor:KCOLOR_B4 lineSpace:SCALE_NUM(10)];
        }
    }
    if (notHaveImage) {
        [_middleView updateWithImgs:nil bigPics:nil];
    }
    
    //底部数据的初始化
    _deadLineTimeLabel.text = [TimeFormatterConvert
                               timeConvertToFommtterAvailable:publishModel.enrollEndTime];
    _activityTimeLabel.text = [TimeFormatterConvert
                               timeConvertToFommtterAvailable:publishModel.actStartTime];
    _activityEndTimeLabel.text = [TimeFormatterConvert
                                  timeConvertToFommtterAvailable:publishModel.actEndTime];
    
    [YUtils setTextViewDataWithTextView:_locationLabel text:publishModel.address
                                   Font:CONTENT_FONT(12) textColor:KCOLOR_B4 linespaing:5];
    
    _categoryLabel.text = info.name;
    
    //跳转活动链接
    if (publishModel.originalTextUrl == nil || [publishModel.originalTextUrl isEmpty]) {
        [_jumpLinkButton removeFromSuperview];
        [_categotyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(SCALE_NUM(-15));
        }];
    }
}

-(void)initTopView {
    _headImageView = [YUtils initImageViewWithImageName:@"default_head"
                                           cornerRadius:HEADIMAGEVIEW_WIDTH/2.0];
    [self.contentView addSubview:_headImageView];
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(gotoPersonDetail)];
    [_headImageView addGestureRecognizer:tap];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(12));
        make.top.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(HEADIMAGEVIEW_WIDTH);
        make.height.mas_equalTo(HEADIMAGEVIEW_WIDTH);
    }];
    
    _titleLabel = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(15)
                                            textColor:KCOLOR_B4];
    _titleLabel.text = @"校级活动公告";
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(SCALE_NUM(12));
        make.centerY.equalTo(_headImageView.mas_centerY);
    }];
    
    _sepLineView = [YUtils initLineViewWithbackgroundColor:KCOLOR_B2];
    [self.contentView addSubview:_sepLineView];
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom).offset(SCALE_NUM(12));
        make.left.equalTo(_titleLabel);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(1));
    }];
    
    _staticNameLabel = [YUtils initLabel:CONTENT_FONT(13) color:nil text:@"名称:"];
    [self.contentView addSubview:_staticNameLabel];
    [_staticNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sepLineView.mas_bottom).offset(SCALE_NUM(15));
        make.leading.mas_equalTo(SCALE_NUM(22));
    }];
    
    _nameLabel = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(13) textColor:nil];
    [self.contentView addSubview:_nameLabel];
    _nameLabel.dataDetectorTypes = UIDataDetectorTypeLink;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_sepLineView.mas_bottom).offset(SCALE_NUM(14));
        make.trailing.mas_equalTo(SCALE_NUM(-12));
    }];
    
    _staticDesLabel = [YUtils initLabel:CONTENT_FONT(13) color:nil text:@"简介:"];
    [self.contentView addSubview:_staticDesLabel];
    [_staticDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_staticNameLabel);
    }];
    
    _descriptionLabel = [YUtils initLinkDisplayTextViewWithFont:CONTENT_FONT(13) textColor:nil];
    _descriptionLabel.delegate = self;
    [self.contentView addSubview:_descriptionLabel];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.top.equalTo(_nameLabel.mas_bottom).offset(SCALE_NUM(14));
    }];
}


-(void)initBottomView {
    _timeImageView = [YUtils initImageViewWithImageName:@"schedule_time"];
    [self.contentView addSubview:_timeImageView];
    [_timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(31));
        make.top.equalTo(_middleView.mas_bottom).offset(SCALE_NUM(10));
    }];
    
    _staticDeadLineDes = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(13)
                                                   textColor:KCOLOR_B3];
    [self.contentView addSubview:_staticDeadLineDes];
    _staticDeadLineDes.text = @"报名截止时间";
    [_staticDeadLineDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_middleView);
        make.centerY.equalTo(_timeImageView.mas_centerY);
    }];
    
    _deadLineTimeLabel = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(13)
                                                   textColor:KCOLOR_B3];
    [self.contentView addSubview:_deadLineTimeLabel];
    [_deadLineTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_staticDeadLineDes.mas_right).offset(SCALE_NUM(10));
        make.centerY.equalTo(_staticDeadLineDes.mas_centerY);
    }];
    
    _staticActivityTimeDes = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(13)
                                                       textColor:KCOLOR_B3];
    [self.contentView addSubview:_staticActivityTimeDes];
    _staticActivityTimeDes.text = @"活动开始时间";
    [_staticActivityTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_deadLineTimeLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_staticDeadLineDes);
    }];
    
    _activityTimeLabel = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(13)
                                                   textColor:KCOLOR_B3];
    [self.contentView addSubview:_activityTimeLabel];
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_staticActivityTimeDes);
        make.left.equalTo(_deadLineTimeLabel);
    }];
    
    _staticActivityEndTimeDes = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(13)
                                                          textColor:KCOLOR_B3];
    [self.contentView addSubview:_staticActivityEndTimeDes];
    _staticActivityEndTimeDes.text = @"活动结束时间";
    [_staticActivityEndTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_staticActivityTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_staticActivityTimeDes);
    }];
    
    _activityEndTimeLabel = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(13)
                                                      textColor:KCOLOR_B3];
    [self.contentView addSubview:_activityEndTimeLabel];
    [_activityEndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_staticActivityEndTimeDes.mas_right).offset(SCALE_NUM(10));
        make.centerY.equalTo(_staticActivityEndTimeDes.mas_centerY);
    }];
    
    _locationImageView = [YUtils initImageViewWithImageName:@"schedule_location"];
    [self.contentView addSubview:_locationImageView];
    [_locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_staticActivityEndTimeDes.mas_bottom).offset(SCALE_NUM(16));
        make.centerX.equalTo(_timeImageView.mas_centerX);
    }];
    
    _locationLabel = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(13)
                                               textColor:KCOLOR_B3];
    [self.contentView addSubview:_locationLabel];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_staticActivityTimeDes);
        make.top.equalTo(_locationImageView.mas_top);
        make.trailing.mas_equalTo(SCALE_NUM(-5));
    }];
    
    _categotyImageView = [YUtils initImageViewWithImageName:@"funny_detail_category"];
    [self.contentView addSubview:_categotyImageView];
    [_categotyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationLabel.mas_bottom).offset(SCALE_NUM(15));
        make.centerX.equalTo(_locationImageView);
    }];
    
    _categoryLabel = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(13)
                                               textColor:KCOLOR_B3];
    [self.contentView addSubview:_categoryLabel];
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_locationLabel);
        make.centerY.equalTo(_categotyImageView.mas_centerY);
    }];
    
    _jumpLinkButton = [YUtils initButtonWithBackgroundColor:nil target:self
                                                     action:@selector(jumpLinkAction)];
    [self.contentView addSubview:_jumpLinkButton];
    [_jumpLinkButton setTitle:@"查看活动链接" forState:UIControlStateNormal];
    _jumpLinkButton.titleLabel.font = CONTENT_FONT(12);
    [_jumpLinkButton setTitleColor:KCOLOR_BLUE_2da8e1 forState:UIControlStateNormal];
    [_jumpLinkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_categotyImageView.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(_categoryLabel);
        make.bottom.mas_equalTo(SCALE_NUM(-10));
    }];
}


/**
 *  跳转链接,查看详情
 */
-(void)jumpLinkAction
{
    ActivityPublishedModel *publishModel = self.detailModel.activityPublishedDto.activityPublishedModel;
    YWebViewController *webViewVC = [[YWebViewController alloc]
                                     initWithUrl:publishModel.originalTextUrl
                                     andTitle:publishModel.name canClick:YES];
    [self.viewController.navigationController pushViewController:webViewVC animated:YES
                                             needHiddenBottomBar:YES];
}

- (void)gotoPersonDetail {
    ActivityOrganizer *organizer = self.detailModel.activityOrganizer;
    XYContactsInfoDetailViewController *detailVC = [[XYContactsInfoDetailViewController alloc]init];
    detailVC.uid = organizer.uid;
    
    
    XYGroupInfoDetailViewController *groupVC = [[XYGroupInfoDetailViewController alloc]init];
    groupVC.gid = organizer.uid;
    
    if ([organizer.userType isEqualToString:@"user"]) {
        if ([organizer.uid isEqualToString:[[YShareData defaultData] valueForKey:kShareData_UserID]]) {
            ProfileMyViewController *myVC = [[ProfileMyViewController alloc]init];
            [self.viewController.navigationController pushViewController:myVC animated:YES
                                                     needHiddenBottomBar:YES];
        } else {
            [self.viewController.navigationController pushViewController:detailVC animated:YES
                                                     needHiddenBottomBar:YES];
        }
    } else if([organizer.userType isEqualToString:@"group_user"])
    {
        [self.viewController.navigationController pushViewController:groupVC animated:YES
                                                 needHiddenBottomBar:YES];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL
         inRange:(NSRange)characterRange {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_OpenBrowser object:nil
                                                      userInfo:@{@"url":[URL absoluteString],
                                                                 @"title":@""}];
    return false;
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSRange range = NSMakeRange(textView.selectedRange.location, textView.selectedRange.length + 30);
    [textView scrollRangeToVisible:range];
}


@end
