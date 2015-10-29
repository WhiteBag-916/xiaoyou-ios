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
#define REUSEID @"ActivityDetailCell"
#define HEADIMAGEVIEW_WIDTH         SCALE_NUM(45)
#define LEADINGOFF_HEADIMAGEVIEW    SCALE_NUM(12)

@interface ActivityDetailCell ()
//@property (nonatomic,strong) ActivityTopView        *topView;
//@property (nonatomic,strong) FeedImageGroup         *middleView;
//@property (nonatomic,strong) ActivityMiddleView     *bottomView;

#pragma mark 顶部TopView
@property (nonatomic,strong) UIImageView    *headImageView; //公告图
@property (nonatomic,strong) UIView         *sepLineView;   //分割线
@property (nonatomic,strong) UILabel        *nameLabel;     //名称
@property (nonatomic,strong) UILabel        *titleLabel;    //标题(校级活动公告)
@property (nonatomic,strong) UILabel        *staticNameLabel;//静态name
@property (nonatomic,strong) UILabel        *staticDesLabel; //简介
@property (nonatomic,strong) UILabel        *descriptionLabel;//描述,只显示一行;
#pragma mark 中间MiddleView
@property (nonatomic,strong) FeedImageGroup *middleView;
#pragma mark 底部BottomView
@property (nonatomic,strong) UIImageView    *timeImageView;             //报名截止时间
@property (nonatomic,strong) UILabel        *staticDeadLineDes;         //截止时间
@property (nonatomic,strong) UILabel        *deadLineTimeLabel;         //截止
@property (nonatomic,strong) UILabel        *staticActivityTimeDes;     //活动时间
@property (nonatomic,strong) UILabel        *activityTimeLabel;         //活动时间
@property (nonatomic,strong) UIImageView    *locationImageView;
@property (nonatomic,strong) UILabel        *locationLabel;             //地点
@property (nonatomic,strong) UIImageView    *categotyImageView;         //类别
@property (nonatomic,strong) UILabel        *categoryLabel;             //类别
@property (nonatomic,strong) UILabel        *staticActivityEndTimeDes;  //活动结束时间
@property (nonatomic,strong) UILabel        *activityEndTimeLabel;      //活动结束时间
#pragma mark 查看链接
@property (nonatomic,strong) UIButton       *jumpLinkButton;            //查看活动链接
@property (nonatomic,strong) ActivityDetailModel    *detailModel;

@end
@implementation ActivityDetailCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initTopViewWithType:DETAIL_INFO];
        [self initMiddleView];
        [self initBottomView];
    }
    return self;
}


-(void)initMiddleView {
    _middleView = [[FeedImageGroup alloc]init];
    [self.contentView addSubview:_middleView];
    
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descriptionLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(_descriptionLabel.mas_left);
        make.right.equalTo(_descriptionLabel);
    }];
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
    _nameLabel.text = publishModel.name;
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
            _descriptionLabel.text = imageText.content;
        }
    }
    if (notHaveImage) {
        [_middleView updateWithImgs:nil bigPics:nil];
    }
    
    //底部数据的初始化
    _deadLineTimeLabel.text = [TimeFormatterConvert timeConvertToFommtterAvailable:publishModel.enrollEndTime];
    _activityTimeLabel.text = [TimeFormatterConvert timeConvertToFommtterAvailable:publishModel.actStartTime];
    _activityEndTimeLabel.text = [TimeFormatterConvert timeConvertToFommtterAvailable:publishModel.actEndTime];
    _locationLabel.text = publishModel.address;
    _categoryLabel.text = info.name;
    
    //跳转活动链接
    publishModel.originalTextUrl = @"http://www.baidu.com";
//    if (publishModel.originalTextUrl == nil || [publishModel.originalTextUrl isEmpty]) {
//        [_jumpLinkButton removeFromSuperview];
//        [_categotyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(SCALE_NUM(-15));
//        }];
//    }
}



-(void)initTopViewWithType:(TOPVIEWTYPE)type {
    _headImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_headImageView];
    _headImageView.layer.cornerRadius = HEADIMAGEVIEW_WIDTH/2.0;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoPersonDetail)];
    [_headImageView addGestureRecognizer:tap];
    _headImageView.image = [UIImage imageNamed:@"default_head"];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(12));
        make.top.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(HEADIMAGEVIEW_WIDTH);
        make.height.mas_equalTo(HEADIMAGEVIEW_WIDTH);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"校级活动公告";
    [self.contentView addSubview:_titleLabel];
    _titleLabel.font = CONTENT_FONT(15);
    _titleLabel.textColor = KCOLOR_B4;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.left.equalTo(_headImageView.mas_right).offset(SCALE_NUM(12));
        make.centerY.equalTo(_headImageView.mas_centerY);
    }];
    
    
    _sepLineView = [[UIView alloc]init];
    _sepLineView.backgroundColor = KCOLOR_B2;
    [self.contentView addSubview:_sepLineView];
    [_sepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_bottom).offset(SCALE_NUM(12));
        make.left.equalTo(_titleLabel);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(1));
    }];
    
    _staticNameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_staticNameLabel];
    _staticNameLabel.font = CONTENT_FONT(13);
    _staticNameLabel.text = @"名称:";
    [_staticNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(16));
        make.top.equalTo(_sepLineView.mas_bottom).offset(SCALE_NUM(15));
        make.leading.mas_equalTo(SCALE_NUM(22));
    }];
    
    _nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_nameLabel];
    _nameLabel.font = CONTENT_FONT(13);
    _nameLabel.numberOfLines = 0;
    _nameLabel.text = @"大型历史音乐剧《和平使者——抗战中的宋庆龄》";
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_sepLineView.mas_bottom).offset(SCALE_NUM(14));
        make.trailing.mas_equalTo(SCALE_NUM(-12));
    }];
    
    _staticDesLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_staticDesLabel];
    _staticDesLabel.font = CONTENT_FONT(13);
    _staticDesLabel.text = @"简介:";
    [_staticDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.top.equalTo(_nameLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_staticNameLabel);
    }];
    
    _descriptionLabel = [[UILabel alloc]init];
    _descriptionLabel.font = CONTENT_FONT(13);
    _descriptionLabel.textColor = KCOLOR_B3;
    if (type == DETAIL_INFO) {
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    } else {
        _descriptionLabel.numberOfLines = 1;
        _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    [self.contentView addSubview:_descriptionLabel];
    NSString *textString = @"本剧讲述了在日寇荼毒神州大地的悲壮年代，宋庆龄从中华民族的大局利益出发，积极投身抗日救亡的运动中。 从1932年1月，侵华日军突袭上海，第一次“淞沪抗战“爆发，宋庆龄亲赴前线慰问十九路军官兵；到促使“西安事变”和平解决，全国上下团结抗日局面的形成；再到香港组建“保卫中国同盟”募集物资支援抗战，参加广州火炬大游行；最后为巩固抗日统一战线，宋氏三姐妹赴重庆视察，并向世界发表广播演讲为主线。充分展示了宋庆龄在国家动荡之时，在民族危难之际，所体现出伟大的爱国主义、民主主义精神！塑造了一个“柔肩担道义、正气盈天地”的伟大女性。";
    [_descriptionLabel setText:textString lineSpacing:10.f];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.top.equalTo(_nameLabel.mas_bottom).offset(SCALE_NUM(14));
    }];
}


-(void)initBottomView {
    _timeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_time"]];
    [self.contentView addSubview:_timeImageView];
    
    [_timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(31));
        make.top.equalTo(_middleView.mas_bottom).offset(SCALE_NUM(10));
    }];
    
    _staticDeadLineDes = [[UILabel alloc]init];
    [self.contentView addSubview:_staticDeadLineDes];
    _staticDeadLineDes.font = CONTENT_FONT(13);
    _staticDeadLineDes.text = @"报名截止时间";
    _staticDeadLineDes.textColor = KCOLOR_B3;
    [_staticDeadLineDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        //make.leading.mas_equalTo(SCALE_NUM(66));
        make.left.equalTo(_middleView);
        make.centerY.equalTo(_timeImageView.mas_centerY);
    }];
    
    _deadLineTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_deadLineTimeLabel];
    _deadLineTimeLabel.textColor = KCOLOR_B3;
    _deadLineTimeLabel.font = CONTENT_FONT(13);
    _deadLineTimeLabel.text = @"15/10/25 06:00";
    [_deadLineTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.left.equalTo(_staticDeadLineDes.mas_right).offset(SCALE_NUM(10));
        make.centerY.equalTo(_staticDeadLineDes.mas_centerY);
    }];
    
    _staticActivityTimeDes = [[UILabel alloc]init];
    [self.contentView addSubview:_staticActivityTimeDes];
    _staticActivityTimeDes.textColor = KCOLOR_B3;
    _staticActivityTimeDes.font = CONTENT_FONT(13);
    _staticActivityTimeDes.text = @"活动开始时间";
    [_staticActivityTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.top.equalTo(_deadLineTimeLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_staticDeadLineDes);
    }];
    
    _activityTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_activityTimeLabel];
    _activityTimeLabel.textColor = KCOLOR_B3;
    _activityTimeLabel.font = CONTENT_FONT(13);
    _activityTimeLabel.text = @"15/10/05 06:00";
    [_activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.top.equalTo(_staticActivityTimeDes);
        make.left.equalTo(_deadLineTimeLabel);
    }];
    
    _staticActivityEndTimeDes = [[UILabel alloc]init];
    [self.contentView addSubview:_staticActivityEndTimeDes];
    _staticActivityEndTimeDes.font = CONTENT_FONT(13);
    _staticActivityEndTimeDes.textColor = KCOLOR_B3;
    _staticActivityEndTimeDes.text = @"活动结束时间";
    [_staticActivityEndTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.top.equalTo(_staticActivityTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_staticActivityTimeDes);
    }];
    
    _activityEndTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_activityEndTimeLabel];
    _activityEndTimeLabel.textColor = KCOLOR_B3;
    _activityEndTimeLabel.font = CONTENT_FONT(13);
    _activityEndTimeLabel.text = @"15/10/25 06:00";
    [_activityEndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.left.equalTo(_staticActivityEndTimeDes.mas_right).offset(SCALE_NUM(10));
        make.centerY.equalTo(_staticActivityEndTimeDes.mas_centerY);
    }];
    
    _locationImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_location"]];
    [self.contentView addSubview:_locationImageView];
    [_locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_staticActivityEndTimeDes.mas_bottom).offset(SCALE_NUM(16));
        make.centerX.equalTo(_timeImageView.mas_centerX);
    }];
    
    _locationLabel = [[UILabel alloc]init];
    _locationLabel.text = @"大脚超市门口";
    [self.contentView addSubview:_locationLabel];
    _locationLabel.textColor = KCOLOR_B3;
    _locationLabel.font = CONTENT_FONT(13);
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_staticActivityTimeDes);
        make.centerY.equalTo(_locationImageView.mas_centerY);
    }];
    
    _categotyImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"funny_detail_category"]];
    [self.contentView addSubview:_categotyImageView];
    [_categotyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationImageView.mas_bottom).offset(SCALE_NUM(15));
        make.centerX.equalTo(_locationImageView);
        make.height.mas_equalTo(SCALE_NUM(17));
        make.width.mas_equalTo(SCALE_NUM(17));
        //make.bottom.mas_equalTo(SCALE_NUM(-15));
    }];
    
    _categoryLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_categoryLabel];
    _categoryLabel.font = CONTENT_FONT(13);
    _categoryLabel.text = @"学术类";
    _categoryLabel.textColor = KCOLOR_B3;
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(13));
        make.left.equalTo(_locationLabel);
        make.centerY.equalTo(_categotyImageView.mas_centerY);
    }];
    
    _jumpLinkButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:_jumpLinkButton];
    [_jumpLinkButton setTitle:@"查看活动链接" forState:UIControlStateNormal];
    [_jumpLinkButton addTarget:self action:@selector(jumpLinkAction) forControlEvents:UIControlEventTouchUpInside];
    _jumpLinkButton.titleLabel.font = CONTENT_FONT(12);
    [_jumpLinkButton setTitleColor:KCOLOR_BLUE_2da8e1 forState:UIControlStateNormal];
    [_jumpLinkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_categotyImageView.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(_categoryLabel);
        make.height.mas_equalTo(SCALE_NUM(14));
        make.bottom.mas_equalTo(SCALE_NUM(-10));
        
    }];
}


/**
 *  跳转链接,查看详情
 */
-(void)jumpLinkAction
{
    ActivityPublishedModel *publishModel = self.detailModel.activityPublishedDto.activityPublishedModel;
    YWebViewController *webViewVC = [[YWebViewController alloc]initWithUrl:publishModel.originalTextUrl andTitle:publishModel.name canClick:NO];
    [self.viewController.navigationController pushViewController:webViewVC animated:YES needHiddenBottomBar:YES];
}

- (void)gotoPersonDetail {
    ActivityOrganizer *organizer = self.detailModel.activityOrganizer;
    XYContactsInfoDetailViewController *detailVC = [[XYContactsInfoDetailViewController alloc]init];
    detailVC.uid = organizer.uid;
    
    
    XYGroupInfoDetailViewController *groupVC = [[XYGroupInfoDetailViewController alloc]init];
    groupVC.gid = organizer.uid;
    
    if ([organizer.userType isEqualToString:@"user"]) {
        [self.viewController.navigationController pushViewController:detailVC animated:YES needHiddenBottomBar:YES];
    } else
    {
        [self.viewController.navigationController pushViewController:groupVC animated:YES needHiddenBottomBar:YES];
    }
}

@end
