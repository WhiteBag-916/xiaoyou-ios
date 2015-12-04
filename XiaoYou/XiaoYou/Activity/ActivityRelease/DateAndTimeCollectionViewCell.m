//
//  DateAndTimeCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "DateAndTimeCollectionViewCell.h"
#import "CommonPopView.h"
#import "YVIew+Ext.h"
#import "ActivityReleaseDataManager.h"

NSString *const kDateAndTimeCollectionViewCell = @"DateAndTimeCollectionViewCellId";

@interface DateAndTimeCollectionViewCell ()

@property (nonatomic,strong)UILabel * applayTimeLabel;
@property (nonatomic,strong)UILabel * beginTimeLabel;
@property (nonatomic,strong)UILabel * endTimeLabel;
@property (nonatomic,strong)UIDatePicker * datePicker;
@property(nonatomic,strong)ActivityReleaseDataManager * dataManager;

@end

@implementation DateAndTimeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changUI];
        self.dataManager = [ActivityReleaseDataManager shareActivityReleaseDataManager];
    }
    return self;
}

- (void)changUI
{
    //设置每个cell的不同部分
    self.numImageView.image = [UIImage imageNamed:@"img_num3"];
    self.typeLabel.text = @"时间";
    
    //报名时间
    UILabel * applyLabel = [YUtils initLabelWithBackgroundColor:[UIColor clearColor]
                                                           font:CONTENT_FONT(12)
                                                  numberOfLines:1
                                                  textAlignment:NSTextAlignmentLeft
                                                      textColor:KCOLOR_B3
                                                           text:@"报名截止时间"];
    [self.backView addSubview:applyLabel];
    [applyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(80));
        make.left.equalTo(self.numImageView);
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(140));
    }];
    
    _applayTimeLabel = [YUtils initLabelWithBackgroundColor:[UIColor whiteColor]
                                                       font:CONTENT_FONT(12)
                                              numberOfLines:1
                                              textAlignment:NSTextAlignmentCenter
                                                  textColor:KCOLOR_B5
                                                       text:@"请选择活动报名时间"];
    _applayTimeLabel.userInteractionEnabled = YES;
    [self.backView addSubview:_applayTimeLabel];
    [_applayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(applyLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(self.backView).offset(SCALE_NUM(10));
        make.right.equalTo(self.backView).offset(SCALE_NUM(-10));
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    UITapGestureRecognizer * applayTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applayChoiceTime)];
    [_applayTimeLabel addGestureRecognizer:applayTapGesture];
    
    //活动时间
    UILabel * activityLabel = [YUtils initLabelWithBackgroundColor:[UIColor clearColor]
                                                              font:CONTENT_FONT(12)
                                                     numberOfLines:1
                                                     textAlignment:NSTextAlignmentLeft
                                                         textColor:KCOLOR_B3
                                                              text:@"活动时间"];
    [self.backView addSubview:activityLabel];
    [activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_applayTimeLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(self.numImageView);
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(100));
    }];
    
    //开始活动时间
    _beginTimeLabel = [YUtils initLabelWithBackgroundColor:[UIColor whiteColor]
                                                      font:CONTENT_FONT(12)
                                             numberOfLines:1
                                             textAlignment:NSTextAlignmentCenter
                                                 textColor:KCOLOR_B5
                                                      text:@"请选择活动开始时间"];
    _beginTimeLabel.userInteractionEnabled = YES;
    [self.backView addSubview:_beginTimeLabel];
    [_beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(activityLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(self.backView).offset(SCALE_NUM(10));
        make.right.equalTo(self.backView).offset(SCALE_NUM(-10));
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    UITapGestureRecognizer * beginTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginChoiceTime)];
    [_beginTimeLabel addGestureRecognizer:beginTapGesture];
    
    //至Label
    UILabel * toLabel =[YUtils initLabelWithBackgroundColor:[UIColor clearColor]
                                                       font:CONTENT_FONT(12)
                                              numberOfLines:1
                                              textAlignment:NSTextAlignmentCenter
                                                  textColor:KCOLOR_B3
                                                       text:@"至"];
    [self.backView addSubview:toLabel];
    [toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beginTimeLabel.mas_bottom).offset(SCALE_NUM(10));
        make.centerX.equalTo(self.backView);
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(20));
    }];
    
    //结束活动时间
    _endTimeLabel = [YUtils initLabelWithBackgroundColor:[UIColor whiteColor]
                                                    font:CONTENT_FONT(12)
                                           numberOfLines:1
                                           textAlignment:NSTextAlignmentCenter
                                               textColor:KCOLOR_B5
                                                    text:@"请选择活动结束时间"];
    _endTimeLabel.userInteractionEnabled = YES;
    [self.backView addSubview:_endTimeLabel];
    [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(self.backView).offset(SCALE_NUM(10));
        make.right.equalTo(self.backView).offset(SCALE_NUM(-10));
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    UITapGestureRecognizer * endTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endChoiceTime)];
    [_endTimeLabel addGestureRecognizer:endTapGesture];
    
    //日期选择
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 160)];
    
}

#pragma mark - 手势回调方法
-(void)applayChoiceTime
{
    [self.viewController.view endEditing:YES];
   
    CommonPopView * popView = [[CommonPopView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                         showButton:YES
                                             addSub:_datePicker
                                              isTop:NO
                                             isRoot:YES
                                            addSelf:[UIApplication sharedApplication].keyWindow];
    [popView comSet:self action:@selector(applayChooseDate) params:nil];

    _datePicker.minimumDate = [NSDate date];
    _datePicker.maximumDate = nil;
    
    NSDictionary * dic = @{@"position":@3};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];

    
    [popView showView];
}

-(void)beginChoiceTime
{
    [self.viewController.view endEditing:YES];
    CommonPopView * popView = [[CommonPopView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                        showButton:YES
                                                            addSub:_datePicker
                                                             isTop:NO
                                                            isRoot:YES
                                                           addSelf:[UIApplication sharedApplication].keyWindow];
    [popView comSet:self action:@selector(heginChooseDate) params:nil];
    
    _datePicker.minimumDate = [NSDate date];
    _datePicker.maximumDate = nil;
    
    NSDictionary * dic = @{@"position":@3};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
    
    [popView showView];
}

-(void)endChoiceTime
{
    [self.viewController.view endEditing:YES];
    CommonPopView * popView = [[CommonPopView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                        showButton:YES
                                                            addSub:_datePicker
                                                             isTop:NO
                                                            isRoot:YES
                                                           addSelf:[UIApplication sharedApplication].keyWindow];
    [popView comSet:self action:@selector(endChooseDate) params:nil];
    
    _datePicker.minimumDate = [NSDate date];
    _datePicker.maximumDate = nil;
    
    NSDictionary * dic = @{@"position":@3};
    [[NSNotificationCenter defaultCenter]
     postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
    
    [popView showView];
}

#pragma mark - 确定选择日期
-(void)applayChooseDate
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    NSString * showStr = [self getShowDateStr];
    NSString * BeginApplyStr = [formatter stringFromDate:[NSDate dateWithTimeInterval:-300
                                                                            sinceDate:_datePicker.date]];
    _applayTimeLabel.text = showStr;
    _applayTimeLabel.textColor = KCOLOR_B4;
    _dataManager.ActivityDateEndApplyText = showStr;
    _dataManager.ActivityDateBeginApplyText = BeginApplyStr;
    [_dataManager isEnableToRelease];
}
-(void)heginChooseDate
{
    NSString * showStr = [self getShowDateStr];
    _beginTimeLabel.text = showStr;
    _beginTimeLabel.textColor = KCOLOR_B4;
    _dataManager.ActivityDateBeginText = showStr;
    
    [self isSmallTo15Minites];
    
}
-(void)endChooseDate
{
    NSString * showStr = [self getShowDateStr];
    _endTimeLabel.text = showStr;
    _endTimeLabel.textColor = KCOLOR_B4;
    _dataManager.ActivityDateEndText = showStr;
    
    [self isSmallTo15Minites];
}

-(NSString *)getShowDateStr
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    NSString * showStr = [formatter stringFromDate:_datePicker.date];
    
    return showStr;
}

-(void)isSmallTo15Minites
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    
    if (![_dataManager.ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] &&
        _dataManager.ActivityDateBeginText != nil &&
        ![_dataManager.ActivityDateEndText isEqualToString:@"请选择活动开始时间"] &&
        _dataManager.ActivityDateEndText != nil)
    {
        NSTimeInterval timeBetween1 =
        [[formatter dateFromString:_dataManager.ActivityDateEndText]
         timeIntervalSinceDate:[formatter dateFromString:_dataManager.ActivityDateBeginText]];
        if (timeBetween1 < 900)
        {
            NSDictionary * dic = @{@"isEnabel":@NO};
            [[NSNotificationCenter defaultCenter]
             postNotificationName:KNotification_Enabel_ReleaseBtn
             object:dic];
            [YUtils showTitle:@"活动时长不能小于15分钟" hideAfter:2];
        }
        else
        {
            if (![_dataManager.ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] &&
                _dataManager.ActivityDateBeginText != nil)
            {
                NSTimeInterval timeBetween2 =
                [[formatter dateFromString:_dataManager.ActivityDateBeginText]
                 timeIntervalSinceDate:[NSDate date]];
                if (timeBetween2 < 0)
                {
                    NSDictionary * dic = @{@"isEnabel":@NO};
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:KNotification_Enabel_ReleaseBtn
                     object:dic];
                    [YUtils showTitle:@"活动开始时间要大于当前时间" hideAfter:2];
                }
                else
                {
                    [_dataManager isEnableToRelease];
                }
            }
            
        }
    }
    
    
}

@end
