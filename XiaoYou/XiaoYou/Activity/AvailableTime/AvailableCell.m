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
@property (nonatomic,strong) UITextView     *titleLabel;    //标题
@property (nonatomic,strong) UILabel        *typeLabel;     //类型
@property (nonatomic,strong) UILabel        *descriptionLabel;//描述
//中间图片部分
@property (nonatomic,strong) FeedImageGroup *imageGroupView;   //图片
//底部部分View描述
@property (nonatomic,strong) UITextView        *signUpTimeDes;     //报名截止时间
@property (nonatomic,strong) UITextView        *activityTimeDes;   //活动开始时间
@property (nonatomic,strong) UITextView        *activityEndTimeDes;//活动结束时间
@property (nonatomic,strong) UITextView        *activityLocationDes;//活动地点
@property (nonatomic,strong) UITextView        *oranizerDes;       //组织者
//底部部分view数据
@property (nonatomic,strong) UITextView        *signUpTimeLabel;       //报名截止时间
@property (nonatomic,strong) UITextView        *activityStartTimeLabel;//活动开始时间
@property (nonatomic,strong) UITextView        *activityEndTimeLabel;  //活动结束时间
@property (nonatomic,strong) UITextView        *activityLocationLabel; //活动地点
@property (nonatomic,strong) UITextView        *organizerLabel;        //组织者

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
    _startImageView = [YUtils initImageViewWithImageName:@"green_bar"];
    [self.contentView addSubview:_startImageView];
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(0));
        make.top.mas_equalTo(SCALE_NUM(20));
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(3));
    }];
    
    _titleLabel = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(12) textColor:KCOLOR_B4];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(15));
        if (IS_IPHONE_6)
            make.trailing.mas_equalTo(SCALE_NUM(-45));
        else
            make.trailing.mas_equalTo(SCALE_NUM(-55));
        make.top.equalTo(_startImageView).offset(SCALE_NUM(-5));
    }];
    
    _typeLabel = [YUtils initLabel:CONTENT_FONT(10) color:[UIColor whiteColor] text:@"  活动  "];
    [self.contentView addSubview:_typeLabel];
    _typeLabel.layer.cornerRadius = 3;
    _typeLabel.clipsToBounds = YES;
    _typeLabel.backgroundColor = RGBACOLOR(180, 50, 80, 1);
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(SCALE_NUM(-15));
        make.top.equalTo(_startImageView).offset(SCALE_NUM(-3));
    }];
    
    _descriptionLabel = [YUtils initLabel:CONTENT_FONT(12) color:KCOLOR_B5 text:@""];
    [self.contentView addSubview:_descriptionLabel];
    _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _descriptionLabel.numberOfLines = 3;
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
    
    
    _signUpTimeDes = [YUtils initDisplayTextViewWithFont:CONTENT_FONT(12) textColor:KCOLOR_B5];
    [self.contentView addSubview:_signUpTimeDes];
    _signUpTimeDes.text = @"报名截止时间：";
    [_signUpTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageGroupView.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_imageGroupView);
    }];
    
    _signUpTimeLabel = [YUtils ]
    _signUpTimeLabel = [[UITextView alloc]init];
    _signUpTimeLabel.userInteractionEnabled = NO;
    _signUpTimeLabel.editable = NO;
    _signUpTimeLabel.scrollEnabled = false;
    _signUpTimeLabel.textContainer.lineFragmentPadding = 0;
    _signUpTimeLabel.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_signUpTimeLabel];
    _signUpTimeLabel.text = @"2015/10/25 06:00";
    _signUpTimeLabel.font = CONTENT_FONT(12);
    _signUpTimeLabel.textColor = KCOLOR_B5;
    [_signUpTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_signUpTimeDes);
        make.left.equalTo(_signUpTimeDes.mas_right).offset(SCALE_NUM(15)).priorityHigh();
    }];
    
    if (IS_IOS7) {
        [_signUpTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(SCALE_NUM(130)).priorityHigh();
        }];
    }
    
    _activityTimeDes = [[UITextView alloc]init];
    _activityTimeDes.userInteractionEnabled = NO;
    _activityTimeDes.editable = NO;
    _activityTimeDes.scrollEnabled = false;
    _activityTimeDes.textContainer.lineFragmentPadding = 0;
    _activityTimeDes.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_activityTimeDes];
    _activityTimeDes.font = CONTENT_FONT(12);
    _activityTimeDes.textColor = KCOLOR_B5;
    _activityTimeDes.text = @"活动开始时间：";
    [_activityTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_signUpTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_signUpTimeDes);
    }];
    
    _activityStartTimeLabel = [[UITextView alloc]init];
    _activityStartTimeLabel.userInteractionEnabled = NO;
    _activityStartTimeLabel.editable = NO;
    _activityStartTimeLabel.scrollEnabled = false;
    _activityStartTimeLabel.textContainer.lineFragmentPadding = 0;
    _activityStartTimeLabel.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_activityStartTimeLabel];
    _activityStartTimeLabel.font = CONTENT_FONT(12);
    _activityStartTimeLabel.textColor = KCOLOR_B5;
    [_activityStartTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_activityTimeDes);
        make.left.equalTo(_signUpTimeLabel);
    }];
    
    _activityEndTimeDes = [[UITextView alloc]init];
    _activityEndTimeDes.userInteractionEnabled = NO;
    _activityEndTimeDes.editable = NO;
    _activityEndTimeDes.scrollEnabled = false;
    _activityEndTimeDes.textContainer.lineFragmentPadding = 0;
    _activityEndTimeDes.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_activityEndTimeDes];
    _activityEndTimeDes.font = CONTENT_FONT(12);
    _activityEndTimeDes.textColor = KCOLOR_B5;
    _activityEndTimeDes.text = @"活动结束时间：";
    [_activityEndTimeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_activityTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityTimeDes);
    }];
    
    _activityEndTimeLabel = [[UITextView alloc]init];
    _activityEndTimeLabel.userInteractionEnabled = NO;
    _activityEndTimeLabel.editable = NO;
    _activityEndTimeLabel.scrollEnabled = false;
    _activityEndTimeLabel.textContainer.lineFragmentPadding = 0;
    _activityEndTimeLabel.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_activityEndTimeLabel];
    _activityEndTimeLabel.font = CONTENT_FONT(12);
    _activityEndTimeLabel.textColor = KCOLOR_B5;
    _activityEndTimeLabel.text = @"2015/10/25 06:00";
    [_activityEndTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_activityEndTimeDes);
        make.left.equalTo(_activityStartTimeLabel);
    }];
    
    _activityLocationDes = [[UITextView alloc]init];
    _activityLocationDes.userInteractionEnabled = NO;
    _activityLocationDes.editable = NO;
    _activityLocationDes.scrollEnabled = false;
    _activityLocationDes.textContainer.lineFragmentPadding = 0;
    _activityLocationDes.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_activityLocationDes];
    _activityLocationDes.font = CONTENT_FONT(12);
    _activityLocationDes.textColor = KCOLOR_B5;
    _activityLocationDes.text = @"活动地点：";
    [_activityLocationDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_activityEndTimeDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityEndTimeDes);
    }];
    
    _activityLocationLabel = [[UITextView alloc]init];
    _activityLocationLabel.userInteractionEnabled = NO;
    _activityLocationLabel.editable = NO;
    _activityLocationLabel.scrollEnabled = false;
    _activityLocationLabel.textContainer.lineFragmentPadding = 0;
    _activityLocationLabel.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_activityLocationLabel];
    _activityLocationLabel.font = CONTENT_FONT(12);
    _activityLocationLabel.textColor = KCOLOR_B5;
    _activityLocationLabel.text = @"大脚超市门口";
    [_activityLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCALE_NUM(16));
        make.top.equalTo(_activityLocationDes.mas_top);
        make.left.equalTo(_activityEndTimeLabel);
        make.trailing.mas_equalTo(SCALE_NUM(-5));
    }];
    
    _oranizerDes = [[UITextView alloc]init];
    _oranizerDes.userInteractionEnabled = NO;
    _oranizerDes.editable = NO;
    _oranizerDes.scrollEnabled = false;
    _oranizerDes.textContainer.lineFragmentPadding = 0;
    _oranizerDes.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_oranizerDes];
    _oranizerDes.font = CONTENT_FONT(12);
    _oranizerDes.textColor = KCOLOR_B5;
    _oranizerDes.text = @"组织者：";
    [_oranizerDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_activityLocationDes.mas_bottom).offset(SCALE_NUM(15));
        make.left.equalTo(_activityLocationDes);
        make.bottom.mas_equalTo(SCALE_NUM(-15));
    }];
    
    _organizerLabel = [[UITextView alloc]init];
    _organizerLabel.userInteractionEnabled = NO;
    _organizerLabel.editable = NO;
    _organizerLabel.scrollEnabled = false;
    _organizerLabel.textContainer.lineFragmentPadding = 0;
    _organizerLabel.textContainerInset = UIEdgeInsetsZero;
    [self.contentView addSubview:_organizerLabel];
    _organizerLabel.font = CONTENT_FONT(12);
    _organizerLabel.textColor = KCOLOR_B5;
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
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = SCALE_NUM(5);// 字体的行间距

    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName:KCOLOR_B4,
                                 NSFontAttributeName:CONTENT_FONT(15),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _titleLabel.attributedText = [[NSAttributedString alloc]
                                  initWithString:publishModel.name attributes:attributes];
    
    
    
    //图文混排
    for (ActivityImageTextModels *imageText in imageTextModels) {
        if ([imageText.type isEqualToString:@"text"]) {
            NSString *desContent = [NSString stringWithFormat:@"%@%@",@"描述:",imageText.content];
                [_descriptionLabel setText:desContent lineSpacing:SCALE_NUM(5)];
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
    
    _signUpTimeLabel.text = [TimeFormatterConvert timeConvertToFommtterAvailable:
                             publishModel.enrollEndTime];
    _activityStartTimeLabel.text = [TimeFormatterConvert timeConvertToFommtterAvailable:
                                    publishModel.actStartTime];
    _activityEndTimeLabel.text = [TimeFormatterConvert
                                  timeConvertToFommtterAvailable:publishModel.actEndTime];
    _activityLocationLabel.text = publishModel.address;
    _organizerLabel.text = publishModel.activityOrganizer;
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_OpenBrowser
                                                        object:nil userInfo:@{@"url":[URL absoluteString], @"title":@""}];
    return false;
}


-(CGFloat)getTextHeight:(NSString*)text
{
    NSDictionary *attributes = @{NSFontAttributeName:CONTENT_FONT(12)};
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(screenWidth - SCALE_NUM(27), 9999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return textSize.height;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    //内容（滚动视图）高度大于一定数值时
    if (textView.contentSize.height > 60)
    {
        //删除最后一行的第一个字符，以便减少一行。
        textView.text = [textView.text substringToIndex:[textView.text length]-1];
        return NO;
    }
    return YES;
    
}


-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.contentSize.height > 60)
    {
        //删除最后一行的第一个字符，以便减少一行。
        textView.text = [textView.text substringToIndex:[textView.text length]-1];
    }
}


@end
