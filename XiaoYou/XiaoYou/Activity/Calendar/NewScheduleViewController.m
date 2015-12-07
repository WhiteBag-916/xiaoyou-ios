//
//  NewScheduleViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NewScheduleViewController.h"
#import "YTextField.h"
#import "CommonPopView.h"
#import "YKeyBoard.h"
#import "YCommonPickerView.h"
#import "CommonPopView.h"
#import "ActivityManager.h"
#import "UserSchedulingInfo.h"

#define K_TITLE_H         SCALE_NUM(52)
#define K_BACK_LR         SCALE_NUM(10)
#define K_BACK_B         SCALE_NUM(33)
#define K_CONTENT_T         SCALE_NUM(16)   //内容
#define K_CONTENT_H         SCALE_NUM(63)
#define K_CONTENT_B         SCALE_NUM(10)
#define K_CONTENT_LR         SCALE_NUM(12)
#define K_IMG_LWH           SCALE_NUM(12)   //图标左、宽、高
#define K_LABEL_T           SCALE_NUM(12)   //文案
#define K_LABEL_L           SCALE_NUM(4)
#define K_FIELD_T           SCALE_NUM(24)   //textfieldbg


#define K_TAG_NAME            70000       //日程名称
#define K_TAG_BCLASS          70001       //开始时间
#define K_TAG_FCLASS          70002       //结束时间
#define K_TAG_LOCATION        70003       //地点
#define K_TAG_REMIND          70004       //提醒

@interface NewScheduleViewController ()
<UITextFieldDelegate
,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIDatePicker *datePicker; //时间选择器

@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIView *nameView;         //日程名称
@property (nonatomic, strong) UIView *bClassView;       //开始时间
@property (nonatomic, strong) UIView *fClassView;       //开始时间
@property (nonatomic, strong) UIView *locationView;     //地点
@property (nonatomic, strong) UIView *remindView;       //提醒

@property (nonatomic, strong) YCommonPickerView *remindPicker; //提醒选择

@property (nonatomic, assign) NSInteger chooesTag;      //tag选择

@property (nonatomic, strong) UserSchedulingInfo *userSchedulingInfo;

@end

@implementation NewScheduleViewController

- (id)initWithInfo:(UserSchedulingInfo *)info {
    if (self = [super init]) {
        self.userSchedulingInfo = info;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = KCOLOR_B2;
    
    [self initTitle];
    [self initView];
    [self initData];
    
    [YKeyBoard registerKeyBoardShow:self];
    [YKeyBoard registerKeyBoardHide:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationSlide];
}

- (void)initTitle {
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, K_TITLE_H)];
    //错号
    UIButton * dissMissBtn = [[UIButton alloc] init];
    [dissMissBtn setImage:[UIImage imageNamed:@"build_btn_cancel"] forState:UIControlStateNormal];
    [dissMissBtn addTarget:self
                    action:@selector(clickBtnForCancel)
          forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:dissMissBtn];
    [dissMissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleView);
        make.leading.mas_equalTo(SCALE_NUM(12));
        make.height.width.mas_equalTo(SCALE_NUM(30));
    }];
    
    //对号
    UIButton * finishBtn = [[UIButton alloc] init];
    [finishBtn setImage:[UIImage imageNamed:@"build_btn_finish"] forState:UIControlStateNormal];
    [finishBtn addTarget:self
                  action:@selector(clickBtnForChoice)
        forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:finishBtn];
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleView);
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    
    //title
    _centerLabel = [[UILabel alloc] init];
    _centerLabel.textAlignment = NSTextAlignmentCenter;
    _centerLabel.text = @"新建日程";
    _centerLabel.font = CONTENT_FONT(15);
    [_titleView addSubview:_centerLabel];
    [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_titleView);
        make.height.mas_equalTo(SCALE_NUM(20));
        make.width.mas_equalTo(SCALE_NUM(200));
    }];
    
    [self.view addSubview:_titleView];
}

- (void)initView {
    //滚动
    _contentScrollView = [UIScrollView new];
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
    [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(_titleView.bottomY, 0, 0, 0));
    }];
    
    //contentView
    _contentView = [UIView new];
    [_contentScrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentScrollView);
        make.width.equalTo(_contentScrollView);
    }];
    
    //背景图
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.image = [[UIImage imageNamed:@"build_background"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(10, 6, 6, 6)
                                 resizingMode:UIImageResizingModeStretch];
    [_contentView addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentView)
        .insets(UIEdgeInsetsMake(0, K_BACK_LR, K_BACK_B, K_BACK_LR));
    }];

    //日程名称
    _nameView = [UIView new];
    [_contentView addSubview:_nameView];
    [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundImageView).offset(K_CONTENT_T);
        make.left.equalTo(backgroundImageView).offset(K_CONTENT_LR);
        make.right.equalTo(backgroundImageView).offset(-K_CONTENT_LR);
        make.height.mas_equalTo(K_CONTENT_H);
    }];
    
    [self initField:@"build_icon_name"
          labelName:@"日程名称"
           fieldTag:K_TAG_NAME
           backView:_nameView];

    //上课时间
    _bClassView = [UIView new];
    [_contentView addSubview:_bClassView];
    [_bClassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameView.mas_bottom).offset(K_CONTENT_T);
        make.left.right.equalTo(_nameView);
        make.height.mas_equalTo(K_CONTENT_H);
    }];
    
    [self initTime:@"build_icon_start"
         labelName:@"开始时间"
           timeTag:K_TAG_BCLASS
          backView:_bClassView];
    
    //下课时间
    _fClassView = [UIView new];
    [_contentView addSubview:_fClassView];
    [_fClassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bClassView.mas_bottom).offset(K_CONTENT_T);
        make.left.right.equalTo(_nameView);
        make.height.mas_equalTo(K_CONTENT_H);
    }];
    
    [self initTime:@"build_icon_stop"
         labelName:@"结束时间"
           timeTag:K_TAG_FCLASS
          backView:_fClassView];
    
    //上课地点
    _locationView = [UIView new];
    [_contentView addSubview:_locationView];
    [_locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fClassView.mas_bottom).offset(K_CONTENT_T);
        make.left.right.equalTo(_nameView);
        make.height.mas_equalTo(K_CONTENT_H);
    }];
    
    [self initField:@"build_icon_location"
          labelName:@"活动地点"
           fieldTag:K_TAG_LOCATION
           backView:_locationView];
    
    //提醒
    _remindView = [UIView new];
    [_contentView addSubview:_remindView];
    [_remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationView.mas_bottom).offset(K_CONTENT_T);
        make.left.right.equalTo(_nameView);
        make.height.mas_equalTo(K_CONTENT_H);
        make.bottom.equalTo(backgroundImageView).offset(-K_CONTENT_B);
    }];
    
    [self initButton:@"havetime_icon_remind"
           labelName:@"提醒"
           buttonTag:K_TAG_REMIND
            backView:_remindView buttonText:@"不设置提醒"];
}

- (void)initHead:(NSString *)imageName labelName:(NSString *)labelName backView:(UIView *)backView {
    //image
    UIImageView *courseImageView = [[UIImageView alloc]
                                    initWithImage:[UIImage imageNamed:imageName]];
    courseImageView.contentMode = UIViewContentModeTopLeft;
    [backView addSubview:courseImageView];
    
    [courseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(K_IMG_LWH);
        make.left.top.equalTo(backView);
    }];
    
    //label
    UILabel *courseLabel = [YUtils initLabel:CONTENT_FONT(12)
                                       color:KCOLOR_B5
                                        text:labelName
                                   alignment:NSTextAlignmentLeft];
    [backView addSubview:courseLabel];
    
    [courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(courseImageView);
        make.left.equalTo(courseImageView.mas_right).offset(K_LABEL_L);
    }];
}

- (void)initField:(NSString *)imageName
        labelName:(NSString *)labelName
         fieldTag:(NSInteger)fieldTag
         backView:(UIView *)backView
{
    
    [self initHead:imageName labelName:labelName backView:backView];
    
    //fieldBg
    UIImageView *fieldBgImageView = [[UIImageView alloc] init];
    [fieldBgImageView setImage:[[UIImage imageNamed:@"build_put_bg"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)
                                resizingMode:UIImageResizingModeStretch]];
    [backView addSubview:fieldBgImageView];
    [fieldBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(backView);
        make.top.mas_equalTo(K_FIELD_T);
    }];
    
    //field
    YTextField *textField = [[YTextField alloc] init];
    [textField placeHolderColor:[NSString stringWithFormat:@"请输入%@", labelName]
                      fontColor:KCOLOR_B5];
    textField.font = CONTENT_FONT(12);
    textField.textColor = KCOLOR_B4;
    textField.delegate = self;
    textField.tag = fieldTag;
    [textField registerChanged:self action:@selector(textFieldValueChanged:)];
    [backView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(fieldBgImageView)
        .insets(UIEdgeInsetsMake(0, K_CONTENT_LR, 0, K_CONTENT_LR));
    }];
}

- (void)initTime:(NSString *)imageName
       labelName:(NSString *)labelName
         timeTag:(NSInteger)timeTag
        backView:(UIView *)backView
{
    
    [self initHead:imageName labelName:labelName backView:backView];
    
    //timeBg
    UIImageView *fieldBgImageView = [[UIImageView alloc] init];
    [fieldBgImageView setImage:[[UIImage imageNamed:@"build_put_bg"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)
                                resizingMode:UIImageResizingModeStretch]];
    [backView addSubview:fieldBgImageView];
    [fieldBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(backView);
        make.top.mas_equalTo(K_FIELD_T);
    }];
    
    //timeLabel
    UILabel *timeLabel = [YUtils initLabel:CONTENT_FONT(12)
                                     color:KCOLOR_B5
                                      text:[NSString stringWithFormat:@"请选择%@", labelName]
                                 alignment:NSTextAlignmentLeft];
    timeLabel.tag = timeTag;
    timeLabel.userInteractionEnabled = YES;
    [backView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(fieldBgImageView)
        .insets(UIEdgeInsetsMake(0, K_CONTENT_LR, 0, K_CONTENT_LR));
    }];
    
    UITapGestureRecognizer *beginTapGesture = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(showChoiceTime:)];
    [timeLabel addGestureRecognizer:beginTapGesture];
}


- (void)initButton:(NSString *)imageName
         labelName:(NSString *)labelName
         buttonTag:(NSInteger)buttonTag
          backView:(UIView *)backView
        buttonText:(NSString *)buttonText
{
    
    [self initHead:imageName labelName:labelName backView:backView];
    
    //fieldBg
    UIImageView *fieldBgImageView = [[UIImageView alloc] init];
    [fieldBgImageView setImage:[[UIImage imageNamed:@"build_put_bg"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)
                                resizingMode:UIImageResizingModeStretch]];
    [backView addSubview:fieldBgImageView];
    [fieldBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(backView);
        make.top.mas_equalTo(K_FIELD_T);
    }];
    
    //buttonLabel
    UILabel *timeLabel = [YUtils initLabel:CONTENT_FONT(12)
                                     color:KCOLOR_B5
                                      text:[NSString stringWithFormat:buttonText, labelName]
                                 alignment:NSTextAlignmentLeft];
    timeLabel.tag = buttonTag;
    timeLabel.userInteractionEnabled = YES;
    [backView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(fieldBgImageView)
        .insets(UIEdgeInsetsMake(0, K_CONTENT_LR, 0, K_CONTENT_LR));
    }];
    
    UITapGestureRecognizer *beginTapGesture = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(pressButton)];
    [timeLabel addGestureRecognizer:beginTapGesture];
}

- (void)initData {
    if (nil != _userSchedulingInfo) {
        
        if (_userSchedulingInfo.internalBaseClassIdentifier > 0) {
            _centerLabel.text = @"编辑日程";
        }
        
        //name
        YTextField *textField = (YTextField *)[_nameView viewWithTag:K_TAG_NAME];
        textField.text = _userSchedulingInfo.content;
        
        //begintime
        UILabel *beginTimeLabel = (UILabel *)[_bClassView viewWithTag:K_TAG_BCLASS];
        NSDate *beginDate = [NSDate
                             dateWithTimeIntervalSince1970:_userSchedulingInfo.startTime/1000];
        beginTimeLabel.text = [NSDate stringFromDate:beginDate
                                          withFormat:@"yyyy年MM月dd日 HH:mm"];
        beginTimeLabel.textColor = KCOLOR_B4;
        
        //endtime
        UILabel *endTimeLabel = (UILabel *)[_fClassView viewWithTag:K_TAG_FCLASS];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:_userSchedulingInfo.endTime/1000];
        endTimeLabel.text = [NSDate stringFromDate:endDate withFormat:@"yyyy年MM月dd日 HH:mm"];
        endTimeLabel.textColor = KCOLOR_B4;
        
        //地点
        YTextField *locationTextField = (YTextField *)[_locationView viewWithTag:K_TAG_LOCATION];
        locationTextField.text = _userSchedulingInfo.address;
        
        //提醒
        NSString *remindText = [[ActivityManager sharedInstance]
                                remindTextByTime:_userSchedulingInfo.noticeTimePeriod];
        [self resetRemindLabel:remindText];
    } else {
        self.userSchedulingInfo = [[UserSchedulingInfo alloc] init];
        self.userSchedulingInfo.noticeTimePeriod = -1;
    }
}

#pragma mark - control
-(void)clickBtnForCancel
{
    [YAnalysis trackEvent:@"关闭_新建日程" withPara:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickBtnForChoice
{
    if (nil == _userSchedulingInfo.content) {
        [YUtils showTitle:@"名字不能为空"];
        
        return;
    }
    
    if (0 == _userSchedulingInfo.startTime) {
        [YUtils showTitle:@"开始时间不能为空"];
        
        return;
    }
    
    if (0 == _userSchedulingInfo.endTime) {
        [YUtils showTitle:@"结束时间不能为空"];
        
        return;
    }
    
    if (_userSchedulingInfo.endTime - _userSchedulingInfo.startTime < 0) {
        [YUtils showTitle:@"结束时间必须晚于开始时间"];
        
        return;
    }
    
    NSDictionary *dic = @{@"content":_userSchedulingInfo.content
                          , @"id":[NSString stringWithFormat:@"%g"
                                   , _userSchedulingInfo.internalBaseClassIdentifier]
                          , @"endTime": [NSString stringWithFormat:@"%lld"
                                         , _userSchedulingInfo.endTime]
                          , @"startTime": [NSString stringWithFormat:@"%lld"
                                           , _userSchedulingInfo.startTime]
                          , @"address":SStr(_userSchedulingInfo.address)
                          , @"noticeTimePeriod":[NSString stringWithFormat:@"%g"
                                                 , _userSchedulingInfo.noticeTimePeriod]};
    [YAnalysis trackEvent:@"确定_新建日程" withPara:dic];
    [YUtils showHUDWithTitle];
    [[ActivityManager sharedInstance] userSchedulingEdit:dic block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        
        if (message.isSuccess) {
            
            //抛通知告知添加成功
            UserSchedulingInfo *info = message.object;
            info.type = @"user_scheduling";
            NSDictionary *dic = @{@"state":@"add", @"info":info};
            [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Change_Schedule
                                                                object:nil
                                                              userInfo:dic];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}

#pragma mark - 按钮
- (void)pressButton
{
    [self.view endEditing:YES];
    
    if (nil == _remindPicker) {
        self.remindPicker = [[YCommonPickerView alloc] initWithType:PickerView_CalendarRemind
                                                        commonArray:[[ActivityManager
                                                                      sharedInstance]
                                                                     remindTextArray]];
    }
    
    CommonPopView *popView = [[CommonPopView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                       showButton:YES
                                                           addSub:_remindPicker
                                                            isTop:NO
                                                           isRoot:YES
                                                          addSelf:self.view];    
    [popView comSet:self action:@selector(chooseRemind) params:nil];
    [popView showView];
}

- (void)chooseRemind {
    //取值
    NSDictionary *data = [_remindPicker getData];
    NSString *remindText = data[kPickerViewCalendarRemind];
    [self resetRemindLabel:remindText];
    
    _userSchedulingInfo.noticeTimePeriod = [[ActivityManager sharedInstance]
                                            timeByRemindText:remindText];
}

- (void)resetRemindLabel:(NSString *)text {
    UILabel *label = (UILabel *)[_remindView viewWithTag:K_TAG_REMIND];
    label.text = text;
    if ([text isEqualToString:@"不设置提醒"]) {
        label.textColor = KCOLOR_B5;
    } else {
        label.textColor = KCOLOR_B4;
    }
}

#pragma mark - 选择日期
- (void)showChoiceTime:(UITapGestureRecognizer*)gesture
{
    [self.view endEditing:YES];
    
    self.chooesTag = gesture.view.tag;
    
    if (nil == _datePicker) {
        self.datePicker = [[UIDatePicker alloc]
                           initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 160)];
    }
    
    if (K_TAG_BCLASS == _chooesTag && _userSchedulingInfo.startTime > 0) {
        _datePicker.date = [NSDate
                            dateWithTimeIntervalSince1970:_userSchedulingInfo.startTime/1000];
    }else if (K_TAG_FCLASS == _chooesTag && _userSchedulingInfo.endTime > 0) {
        _datePicker.date = [NSDate dateWithTimeIntervalSince1970:_userSchedulingInfo.endTime/1000];
    }
    
    CommonPopView * popView = [[CommonPopView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                        showButton:YES
                                                            addSub:_datePicker
                                                             isTop:NO
                                                            isRoot:YES
                                                           addSelf:[UIApplication
                                                                    sharedApplication].keyWindow];
    [popView comSet:self action:@selector(choiceTime) params:nil];
    [popView showView];
    
}

//选择时间后
-(void)choiceTime {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString * showStr = [formatter stringFromDate:_datePicker.date];
    int64_t dateInt = [_datePicker.date timeIntervalSince1970]*1000;
    //耦合性很高
    if (K_TAG_BCLASS == _chooesTag) {
        UILabel *timeLabel = (UILabel *)[_bClassView viewWithTag:_chooesTag];
        timeLabel.text = showStr;
        timeLabel.textColor = KCOLOR_B4;
        
        _userSchedulingInfo.startTime = dateInt;
        
    } else if (K_TAG_FCLASS == _chooesTag) {
        UILabel *timeLabel = (UILabel *)[_fClassView viewWithTag:_chooesTag];
        timeLabel.text = showStr;
        timeLabel.textColor = KCOLOR_B4;
        
        _userSchedulingInfo.endTime = dateInt;
    }
}

#pragma mark - UITextFieldDelegate  键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSInteger fieldLen = [textField.text length];
    NSInteger rangeLen = range.length;
    NSInteger strLen = string.length;
    if (![string isEqualToString:@"\n"])
    {
        if (K_TAG_NAME == textField.tag)
        {
            //name
            if (fieldLen - rangeLen + strLen > 30)
            {
                [YUtils showTitle:@"日程名称不能大于30字"];
                return NO;
            }
        }
        else if (K_TAG_LOCATION == textField.tag)
        {
            //地点
            if (fieldLen - rangeLen + strLen > 100)
            {
                [YUtils showTitle:@"地点不能大于100字"];
                return NO;
            }
        }
    }
    return YES;
}

- (void)textFieldValueChanged:(UITextField *)sender{
    if (K_TAG_NAME == sender.tag) {
        if (sender.text.length >= 30)
        {
            [YUtils showTitle:@"日程名称不能大于30字"];
            [sender setText:[sender.text substringWithRange:NSMakeRange(0, 30)]];
        }
        _userSchedulingInfo.content = sender.text;
        
    } else if (K_TAG_LOCATION == sender.tag) {
        if (sender.text.length >= 100)
        {
            [YUtils showTitle:@"地点不能大于100字"];
            [sender setText:[sender.text substringWithRange:NSMakeRange(0, 100)]];
        }
        _userSchedulingInfo.address = sender.text;
    }
}

#pragma mark - YKeyBoardDlegate
- (void)keyboardWillShowNotification:(NSNotification *)note {
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    [_contentScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view)
        .insets(UIEdgeInsetsMake(_titleView.bottomY, 0, keyboardBounds.size.height, 0));
    }];
    
    [_contentScrollView layoutIfNeeded];
    
    [UIView commitAnimations];
}

- (void)keyboardWillHideNotification:(NSNotification *)note {
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    [_contentScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(_titleView.bottomY, 0, 0, 0));
    }];
    
    [_contentScrollView layoutIfNeeded];
    
    // commit animations
    [UIView commitAnimations];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
