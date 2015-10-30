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
        _dataManager = [ActivityReleaseDataManager shareActivityReleaseDataManager];
    }
    return self;
}

-(void)changUI
{
    //设置每个cell的不同部分
    self.numImageView.image = [UIImage imageNamed:@"img_num3"];
    self.typeLabel.text = @"时间";
    
    //报名时间
    UILabel * applyLabel = [[UILabel alloc] init];
    applyLabel.backgroundColor = [UIColor clearColor];
    applyLabel.font = CONTENT_FONT(12);
    applyLabel.textColor = KCOLOR_B3;
    applyLabel.text = @"报名截止时间";
    [self.backView addSubview:applyLabel];
    [applyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(80));
        make.left.equalTo(self.numImageView);
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(140));
    }];
    
    _applayTimeLabel = [[UILabel alloc] init];
    _applayTimeLabel.userInteractionEnabled = YES;
    _applayTimeLabel.backgroundColor = [UIColor whiteColor];
    _applayTimeLabel.font = CONTENT_FONT(12);
    _applayTimeLabel.text = @"请选择活动报名时间";
    _applayTimeLabel.textAlignment = NSTextAlignmentCenter;
    _applayTimeLabel.textColor = KCOLOR_B5;
    [self.backView addSubview:_applayTimeLabel];
    [_applayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(applyLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(self.backView).offset(SCALE_NUM(10));
        make.right.equalTo(self.backView).offset(SCALE_NUM(-10));
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    UITapGestureRecognizer * applayTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applayChoiceTime)];
    [_applayTimeLabel addGestureRecognizer:applayTapGesture];
    
    //活动时间
    UILabel * activityLabel = [[UILabel alloc] init];
    activityLabel.backgroundColor = [UIColor clearColor];
    activityLabel.font = CONTENT_FONT(12);
    activityLabel.textColor = KCOLOR_B3;
    activityLabel.text = @"活动时间";
    [self.backView addSubview:activityLabel];
    [activityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_applayTimeLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(self.numImageView);
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(100));
    }];
    
    //开始活动时间
    _beginTimeLabel = [[UILabel alloc] init];
    _beginTimeLabel.userInteractionEnabled = YES;
    _beginTimeLabel.backgroundColor = [UIColor whiteColor];
    _beginTimeLabel.font = CONTENT_FONT(12);
    _beginTimeLabel.text = @"请选择活动开始时间";
    _beginTimeLabel.textAlignment = NSTextAlignmentCenter;
    _beginTimeLabel.textColor = KCOLOR_B5;
    [self.backView addSubview:_beginTimeLabel];
    [_beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(activityLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(self.backView).offset(SCALE_NUM(10));
        make.right.equalTo(self.backView).offset(SCALE_NUM(-10));
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    UITapGestureRecognizer * beginTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginChoiceTime)];
    [_beginTimeLabel addGestureRecognizer:beginTapGesture];
    
    //至Label
    UILabel * toLabel =[[UILabel alloc] init];
    toLabel.backgroundColor = [UIColor clearColor];
    toLabel.textAlignment = NSTextAlignmentCenter;
    toLabel.font = CONTENT_FONT(12);
    toLabel.textColor = KCOLOR_B3;
    toLabel.text = @"至";
    [self.backView addSubview:toLabel];
    [toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beginTimeLabel.mas_bottom).offset(SCALE_NUM(10));
        make.centerX.equalTo(self.backView);
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(20));
    }];
    
    //结束活动时间
    _endTimeLabel = [[UILabel alloc] init];
    _endTimeLabel.userInteractionEnabled = YES;
    _endTimeLabel.backgroundColor = [UIColor whiteColor];
    _endTimeLabel.font = CONTENT_FONT(12);
    _endTimeLabel.text = @"请选择活动结束时间";
    _endTimeLabel.textAlignment = NSTextAlignmentCenter;
    _endTimeLabel.textColor = KCOLOR_B5;
    [self.backView addSubview:_endTimeLabel];
    [_endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toLabel.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(self.backView).offset(SCALE_NUM(10));
        make.right.equalTo(self.backView).offset(SCALE_NUM(-10));
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    UITapGestureRecognizer * endTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endChoiceTime)];
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

//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
//    if ([_dataManager.ActivityDateEndText isEqualToString:@"请选择活动结束时间"] || _dataManager.ActivityDateEndText == nil)
//    {
//        _datePicker.minimumDate = [[NSDate date] dateByAddingTimeInterval:900];
//        _datePicker.maximumDate = nil;
//    }
//    else
//    {
//        _datePicker.minimumDate = [[NSDate date] dateByAddingTimeInterval:900];
//        _datePicker.maximumDate = [formatter dateFromString:_dataManager.ActivityDateEndText];
//    }
    
    
    NSDictionary * dic = @{@"position":@3};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];

    
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
    
//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
//    if ([_dataManager.ActivityDateEndText isEqualToString:@"请选择活动结束时间"] || _dataManager.ActivityDateEndText == nil)
//    {
//        _datePicker.minimumDate = [[NSDate date] dateByAddingTimeInterval:900];
//        _datePicker.maximumDate = nil;
//    }
//    else
//    {
//        _datePicker.minimumDate = [[NSDate date] dateByAddingTimeInterval:900];
//        _datePicker.maximumDate = [[formatter dateFromString:_dataManager.ActivityDateEndText] dateByAddingTimeInterval:-900];
//    }
    
    //重置开始时间
//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
//    if ([_dataManager.ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] || _dataManager.ActivityDateBeginText == nil)
//    {
//        if ([_dataManager.ActivityDateEndText isEqualToString:@"请选择活动结束时间"] || _dataManager.ActivityDateEndText == nil)
//        {
//            _datePicker.minimumDate = [NSDate date];
//            _datePicker.maximumDate = nil;
//        }
//        else
//        {
//            _datePicker.minimumDate = [NSDate date];
////            _datePicker.minimumDate = nil;
//            _datePicker.maximumDate = [formatter dateFromString:_dataManager.ActivityDateEndText];
//        }
//    }
//    else
//    {
//        _datePicker.minimumDate = nil;
//        _datePicker.maximumDate = [formatter dateFromString:_dataManager.ActivityDateEndText];
//        
//    }
    
    NSDictionary * dic = @{@"position":@3};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
    
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
    
 
//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
//    if ([_dataManager.ActivityDateBeginText isEqualToString:@"请选择活动结束时间"] || _dataManager.ActivityDateBeginText == nil)
//    {
//        _datePicker.minimumDate = [[NSDate date] dateByAddingTimeInterval:1800];
//        _datePicker.maximumDate = nil;
//    }
//    else
//    {
//        _datePicker.minimumDate = [[formatter dateFromString:_dataManager.ActivityDateBeginText] dateByAddingTimeInterval:900];
//        _datePicker.maximumDate = nil;
//    }
    
    //重置结束时间
//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
//    if ([_dataManager.ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] || _dataManager.ActivityDateBeginText == nil)
//    {
//        if ([_dataManager.ActivityDateEndText isEqualToString:@"请选择活动结束时间"] || _dataManager.ActivityDateEndText == nil)
//        {
//             _datePicker.minimumDate = [NSDate date];
//             _datePicker.maximumDate = nil;
//        }
//        else
//        {
//            _datePicker.minimumDate = [NSDate date];
////            _datePicker.minimumDate = nil;
//            _datePicker.maximumDate = [formatter dateFromString:_dataManager.ActivityDateEndText];
//        }
//    }
//    else
//    {
//        _datePicker.maximumDate = nil;
//        _datePicker.minimumDate = [formatter dateFromString:_dataManager.ActivityDateBeginText];
//        
//    }
    NSDictionary * dic = @{@"position":@3};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
    
    [popView showView];
}

#pragma mark - 确定选择日期
-(void)applayChooseDate
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    NSString * showStr = [formatter stringFromDate:_datePicker.date];
    NSString * BeginApplyStr = [formatter stringFromDate:[NSDate dateWithTimeInterval:-300 sinceDate:_datePicker.date]];
    _applayTimeLabel.text = showStr;
    _dataManager.ActivityDateEndApplyText = showStr;
    _dataManager.ActivityDateBeginApplyText = BeginApplyStr;
    [_dataManager isEnableToRelease];
}
-(void)heginChooseDate
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    NSString * showStr = [formatter stringFromDate:_datePicker.date];
    _beginTimeLabel.text = showStr;
    _dataManager.ActivityDateBeginText = showStr;
    
    [self isSmallTo15Minites];
    
}
-(void)endChooseDate
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    NSString * showStr = [formatter stringFromDate:_datePicker.date];
    _endTimeLabel.text = showStr;
    _dataManager.ActivityDateEndText = showStr;
    
    [self isSmallTo15Minites];
}

-(void)isSmallTo15Minites
{
    if (![_dataManager.ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] && _dataManager.ActivityDateBeginText != nil &&
        ![_dataManager.ActivityDateEndText isEqualToString:@"请选择活动开始时间"] && _dataManager.ActivityDateEndText != nil)
    {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
        NSTimeInterval timeBetween1 = [[formatter dateFromString:_dataManager.ActivityDateEndText] timeIntervalSinceDate:[formatter dateFromString:_dataManager.ActivityDateBeginText]];
        if (timeBetween1 < 900)
        {
            NSDictionary * dic = @{@"isEnabel":@NO};
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Enabel_ReleaseBtn object:dic];
            [YUtils showTitle:@"活动时长不能小于15分钟" hideAfter:2];
        }
        else
        {
            if (![_dataManager.ActivityDateBeginText isEqualToString:@"请选择活动开始时间"] && _dataManager.ActivityDateBeginText != nil)
            {
                NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
                NSTimeInterval timeBetween2 = [[formatter dateFromString:_dataManager.ActivityDateBeginText] timeIntervalSinceDate:[NSDate date]];
                if (timeBetween2 < 0)
                {
                    NSDictionary * dic = @{@"isEnabel":@NO};
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Enabel_ReleaseBtn object:dic];
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
