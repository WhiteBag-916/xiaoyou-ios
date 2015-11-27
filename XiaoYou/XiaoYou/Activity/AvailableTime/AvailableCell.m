//
//  AvailableCell.m
//  XiaoYou
//
//  Created by sheng on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AvailableCell.h"
#import "FeedImageGroup.h"
#import "ActivityImageTextModels.h"
#import "ActivityCoverageModels.h"
#import "TimeFormatterConvert.h"

#define REUSEID @"AvailableCell"
@interface AvailableCell ()<UITextViewDelegate>

@property (nonatomic,strong) UIImageView    *startImageView; //开始图
@property (nonatomic,strong) UILabel        *titleLabel;    //标题
@property (nonatomic,strong) UILabel        *typeLabel;     //类型
@property (nonatomic,strong) UITextView     *descriptionLabel;//描述
//中间图片部分
@property (nonatomic,strong) FeedImageGroup *imageGroupView;   //图片
//底部部分View描述
@property (nonatomic,strong) UILabel        *signUpTimeDes;     //报名截止时间
@property (nonatomic,strong) UILabel        *activityTimeDes;   //活动开始时间
@property (nonatomic,strong) UILabel        *activityEndTimeDes;//活动结束时间
@property (nonatomic,strong) UILabel        *activityLocationDes;//活动地点
@property (nonatomic,strong) UILabel        *oranizerDes;       //组织者
//底部部分view数据
@property (nonatomic,strong) UILabel        *signUpTimeLabel;       //报名截止时间
@property (nonatomic,strong) UILabel        *activityStartTimeLabel;//活动开始时间
@property (nonatomic,strong) UILabel        *activityEndTimeLabel;  //活动结束时间
@property (nonatomic,strong) UILabel        *activityLocationLabel; //活动地点
@property (nonatomic,strong) UILabel        *organizerLabel;        //组织者

@end


@implementation AvailableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

#pragma mark 协议
-(BOOL)needLine
{
    return YES;
}

-(CGFloat)lineX
{
    return 20;
}

//初始化相关控件
-(void)initView
{
    _startImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_startImageView];
    _startImageView.image = [UIImage imageNamed:@"green_bar"];
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(0));
        make.top.mas_equalTo(SCALE_NUM(20));
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(3));
    }];
    
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.text = @"大型历史音乐剧《和平使者——抗战中的宋庆龄》奋斗史";
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = KCOLOR_B4;
    _titleLabel.font = CONTENT_FONT(15);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(15));
        if (IS_IPHONE_6)
            make.trailing.mas_equalTo(SCALE_NUM(-45));
        else
            make.trailing.mas_equalTo(SCALE_NUM(-55));
        make.top.equalTo(_startImageView).offset(SCALE_NUM(-5));
    }];
    
    
    _typeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_typeLabel];
    [_typeLabel setTextColor:[UIColor whiteColor]];
    _typeLabel.layer.cornerRadius = 3;
    _typeLabel.clipsToBounds = YES;
    _typeLabel.backgroundColor = RGBACOLOR(180, 50, 80, 1);
    _typeLabel.text = @"  活动  ";
    _typeLabel.font = CONTENT_FONT(10);
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(15));
        make.trailing.mas_equalTo(SCALE_NUM(-15));
        make.top.equalTo(_startImageView).offset(SCALE_NUM(-3));
    }];
    
//    _contentLabel = [[UITextView alloc] init];
//    _contentLabel.textColor = [UIColor blackColor];
//    _contentLabel.editable = false;
//    //        _contentLabel.dataDetectorTypes = UIDataDetectorTypeLink;
//    _contentLabel.scrollEnabled = false;
//    _contentLabel.font = CONTENT_FONT(12);
//    _contentLabel.textContainer.lineFragmentPadding = 0;
//    _contentLabel.textContainerInset = UIEdgeInsetsZero;
//    _contentLabel.delegate = self;
//    [self addSubview:_contentLabel];
//    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//    }];
    
    _descriptionLabel = [[UITextView alloc]init];
    [self.contentView addSubview:_descriptionLabel];
    _descriptionLabel.editable = NO;
    _descriptionLabel.scrollEnabled = false;
    _descriptionLabel.font = CONTENT_FONT(12);
    //_descriptionLabel.dataDetectorTypes = UIDataDetectorTypeLink;
    _descriptionLabel.textContainer.lineFragmentPadding = 0;
    _descriptionLabel.textContainerInset = UIEdgeInsetsZero;
    _descriptionLabel.delegate = self;
    
    //_descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    //_descriptionLabel.font = CONTENT_FONT(12);
    //_descriptionLabel.textColor = KCOLOR_B5;
    
    NSString *desTextString = @"描述：";
    //[_descriptionLabel setText:desTextString lineSpacing:SCALE_NUM(10.f)];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(SCALE_NUM(18));
        make.left.equalTo(_titleLabel);
        make.trailing.mas_equalTo(SCALE_NUM(-12));
    }];
    
    _imageGroupView = [[FeedImageGroup alloc]init];
    [self.contentView addSubview:_imageGroupView];
    [_imageGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_descriptionLabel.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_descriptionLabel);
        make.right.equalTo(_descriptionLabel.mas_right);
    }];
    
    _signUpTimeDes = [[UILabel alloc]init];
    [self.contentView addSubview:_signUpTimeDes];
    _signUpTimeDes.text = @"报名截止时间：";
    _signUpTimeDes.font = CONTENT_FONT(12);
    _signUpTimeDes.numberOfLines = 1;
    _signUpTimeDes.textColor = KCOLOR_B5;
    [_signUpTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(14));
        make.top.equalTo(_imageGroupView.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_imageGroupView);
    }];
    
    _signUpTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_signUpTimeLabel];
    _signUpTimeLabel.text = @"2015/10/25 06:00";
    _signUpTimeLabel.font = CONTENT_FONT(12);
    _signUpTimeLabel.textColor = KCOLOR_B5;
    [_signUpTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(14));
        make.centerY.equalTo(_signUpTimeDes);
        make.left.equalTo(_signUpTimeDes.mas_right).offset(SCALE_NUM(15)).priorityHigh();
    }];
    
    if (IS_IOS7) {
        [_signUpTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(SCALE_NUM(130)).priorityHigh();
        }];
    }
    
    
    _activityTimeDes = [[UILabel alloc]init];
    [self.contentView addSubview:_activityTimeDes];
    _activityTimeDes.font = CONTENT_FONT(12);
    _activityTimeDes.textColor = KCOLOR_B5;
    _activityTimeDes.text = @"活动开始时间：";
    [_activityTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_signUpTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_signUpTimeDes);
        make.height.mas_equalTo(SCALE_NUM(14));
    }];
    
    _activityStartTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_activityStartTimeLabel];
    _activityStartTimeLabel.font = CONTENT_FONT(12);
    _activityStartTimeLabel.textColor = KCOLOR_B5;
    _activityStartTimeLabel.text = @"2015/10/05 06:00";
    [_activityStartTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(14));
        make.centerY.equalTo(_activityTimeDes);
        make.left.equalTo(_signUpTimeLabel);
    }];
    
    _activityEndTimeDes = [[UILabel alloc]init];
    [self.contentView addSubview:_activityEndTimeDes];
    _activityEndTimeDes.font = CONTENT_FONT(12);
    _activityEndTimeDes.textColor = KCOLOR_B5;
    _activityEndTimeDes.text = @"活动结束时间：";
    [_activityEndTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(14));
        make.top.equalTo(_activityTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityTimeDes);
    }];
    
    _activityEndTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_activityEndTimeLabel];
    _activityEndTimeLabel.font = CONTENT_FONT(12);
    _activityEndTimeLabel.textColor = KCOLOR_B5;
    _activityEndTimeLabel.text = @"2015/10/25 06:00";
    [_activityEndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(14));
        make.centerY.equalTo(_activityEndTimeDes);
        make.left.equalTo(_activityStartTimeLabel);
    }];
    
    _activityLocationDes = [[UILabel alloc]init];
    [self.contentView addSubview:_activityLocationDes];
    _activityLocationDes.font = CONTENT_FONT(12);
    _activityLocationDes.textColor = KCOLOR_B5;
    _activityLocationDes.text = @"活动地点：";
    [_activityLocationDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(14));
        make.top.equalTo(_activityEndTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityEndTimeDes);
    }];
    
    _activityLocationLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_activityLocationLabel];
    _activityLocationLabel.font = CONTENT_FONT(12);
    _activityLocationLabel.textColor = KCOLOR_B5;
    _activityLocationLabel.text = @"大脚超市门口";
    [_activityLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(14));
        make.top.equalTo(_activityLocationDes.mas_top);
        make.left.equalTo(_activityEndTimeLabel);
        make.trailing.mas_equalTo(SCALE_NUM(-5));
    }];
    
    _oranizerDes = [[UILabel alloc]init];
    [self.contentView addSubview:_oranizerDes];
    _oranizerDes.numberOfLines = 1;
    _oranizerDes.font = CONTENT_FONT(12);
    _oranizerDes.textColor = KCOLOR_B5;
    _oranizerDes.text = @"组织者：";
    [_oranizerDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(14));
        make.top.equalTo(_activityLocationDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityLocationDes);
        make.bottom.mas_equalTo(SCALE_NUM(-15));
    }];
    
    _organizerLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_organizerLabel];
    _organizerLabel.numberOfLines = 1;
    _organizerLabel.font = CONTENT_FONT(12);
    _organizerLabel.textColor = KCOLOR_B5;
    _organizerLabel.text = @"话剧社";
    [_organizerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_oranizerDes);
        make.left.equalTo(_activityStartTimeLabel);
    }];
}


-(void)setData:(ActivityInfoModel *)model
{
    ActivityPublishedModel  *publishModel   = model.activityPublishedModel;
    NSArray *imageTextModels =  model.activityImageTextModels;
    
    BOOL isNotHaveImage = YES;
    [_titleLabel setText:publishModel.name lineSpacing:5];
    //图文混排
    for (ActivityImageTextModels *imageText in imageTextModels) {
        if ([imageText.type isEqualToString:@"text"]) {
            NSString *desContent = [NSString stringWithFormat:@"%@%@",@"描述:",imageText.content];
            //[_descriptionLabel setText:desContent lineSpacing:SCALE_NUM(5)];
            
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = SCALE_NUM(10);// 字体的行间距
            
            NSDictionary *attributes = @{
                                         NSFontAttributeName:CONTENT_FONT(12),
                                         NSParagraphStyleAttributeName:paragraphStyle
                                         };
            _descriptionLabel.attributedText = [[NSAttributedString alloc] initWithString:desContent attributes:attributes];
        }
        else if ([imageText.type isEqualToString:@"image"]) {
            if (![imageText.content isEmpty]) {
                [_imageGroupView updateWithImgs:@[imageText.content] bigPics:@[imageText.content]];
                isNotHaveImage = NO;
            }
        }
    }
    if (isNotHaveImage) {
        [_imageGroupView updateWithImgs:nil bigPics:nil];
    }
    
    _signUpTimeLabel.text = [TimeFormatterConvert timeConvertToFommtterAvailable:publishModel.enrollEndTime];
    _activityStartTimeLabel.text = [TimeFormatterConvert timeConvertToFommtterAvailable:publishModel.actStartTime];
    _activityEndTimeLabel.text = [TimeFormatterConvert timeConvertToFommtterAvailable:publishModel.actEndTime];
    _activityLocationLabel.text = publishModel.address;
    _organizerLabel.text = publishModel.activityOrganizer;
}

@end
