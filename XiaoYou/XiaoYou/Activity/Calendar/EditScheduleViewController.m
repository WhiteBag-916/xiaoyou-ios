//
//  EditScheduleViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/19.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "EditScheduleViewController.h"
#import "YTextField.h"
#import "CommonPopView.h"
#import "YKeyBoard.h"

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


#define K_TAG_NAME            80000       //课程名称
#define K_TAG_LECTURER        80001       //授课人
#define K_TAG_BCLASS          80002       //上课时间
#define K_TAG_FCLASS          80003       //下课时间
#define K_TAG_LOCATION        80004       //地点
#define K_TAG_DEPARTMENTS     80005       //院系

@interface EditScheduleViewController ()
<UITextFieldDelegate
,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIDatePicker *datePicker; //时间选择器

@property (nonatomic, strong) UIView *nameView;         //课程名称
@property (nonatomic, strong) UIView *lecturerView;     //授课人
@property (nonatomic, strong) UIView *bClassView;       //上课时间
@property (nonatomic, strong) UIView *fClassView;       //下课时间
@property (nonatomic, strong) UIView *locationView;     //地点
@property (nonatomic, strong) UIView *departmentsView;  //院系

@property (nonatomic, assign) NSInteger chooesTag;      //tag选择

@end

@implementation EditScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = KCOLOR_B2;
    
    [self initTitle];
    [self initView];
    
    [YKeyBoard registerKeyBoardShow:self];
    [YKeyBoard registerKeyBoardHide:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

- (void)initTitle {
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, K_TITLE_H)];
    //错号
    UIButton * dissMissBtn = [[UIButton alloc] init];
    [dissMissBtn setImage:[UIImage imageNamed:@"build_btn_cancel"] forState:UIControlStateNormal];
    [dissMissBtn addTarget:self action:@selector(clickBtnForCancel) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:dissMissBtn];
    [dissMissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleView);
        make.leading.mas_equalTo(SCALE_NUM(12));
        make.height.width.mas_equalTo(SCALE_NUM(30));
    }];
    
    //对号
    UIButton * finishBtn = [[UIButton alloc] init];
    [finishBtn setImage:[UIImage imageNamed:@"build_btn_finish"] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(clickBtnForChoice) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:finishBtn];
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleView);
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    
    //title
    UILabel * centerLabel = [[UILabel alloc] init];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.text = @"编辑课程";
    centerLabel.font = CONTENT_FONT(15);
    [_titleView addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    backgroundImageView.image = [[UIImage imageNamed:@"build_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 6, 6, 6) resizingMode:UIImageResizingModeStretch];
    [_contentView addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentView).insets(UIEdgeInsetsMake(0, K_BACK_LR, K_BACK_B, K_BACK_LR));
    }];
    
    //课程名称
    _nameView = [UIView new];
    [_contentView addSubview:_nameView];
    [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundImageView).offset(K_CONTENT_T);
        make.left.equalTo(backgroundImageView).offset(K_CONTENT_LR);
        make.right.equalTo(backgroundImageView).offset(-K_CONTENT_LR);
        make.height.mas_equalTo(K_CONTENT_H);
    }];
    
    [self initField:@"havetime_icon_classname" labelName:@"课程名称" fieldTag:K_TAG_NAME backView:_nameView];
    
    //授课人
    _lecturerView = [UIView new];
    [_contentView addSubview:_lecturerView];
    [_lecturerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameView.mas_bottom).offset(K_CONTENT_T);
        make.left.right.equalTo(_nameView);
        make.height.mas_equalTo(K_CONTENT_H);
    }];
    
    [self initField:@"havetime_icon_teacher" labelName:@"授课人" fieldTag:K_TAG_LECTURER backView:_lecturerView];
    
    //上课时间
    _bClassView = [UIView new];
    [_contentView addSubview:_bClassView];
    [_bClassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lecturerView.mas_bottom).offset(K_CONTENT_T);
        make.left.right.equalTo(_nameView);
        make.height.mas_equalTo(K_CONTENT_H);
    }];
    
    [self initTime:@"build_icon_start" labelName:@"上课时间" timeTag:K_TAG_BCLASS backView:_bClassView];
    
    //下课时间
    _fClassView = [UIView new];
    [_contentView addSubview:_fClassView];
    [_fClassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bClassView.mas_bottom).offset(K_CONTENT_T);
        make.left.right.equalTo(_nameView);
        make.height.mas_equalTo(K_CONTENT_H);
    }];
    
    [self initTime:@"build_icon_stop" labelName:@"下课时间" timeTag:K_TAG_FCLASS backView:_fClassView];
    
    //上课地点
    _locationView = [UIView new];
    [_contentView addSubview:_locationView];
    [_locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fClassView.mas_bottom).offset(K_CONTENT_T);
        make.left.right.equalTo(_nameView);
        make.height.mas_equalTo(K_CONTENT_H);
    }];
    
    [self initField:@"build_icon_location" labelName:@"上课地点" fieldTag:K_TAG_LOCATION backView:_locationView];
    
    //院系
    _departmentsView = [UIView new];
    [_contentView addSubview:_departmentsView];
    [_departmentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_locationView.mas_bottom).offset(K_CONTENT_T);
        make.left.right.equalTo(_nameView);
        make.height.mas_equalTo(K_CONTENT_H);
        make.bottom.equalTo(backgroundImageView).offset(-K_CONTENT_B);
    }];
    
    [self initField:@"havetime_icon_academy" labelName:@"院系" fieldTag:K_TAG_DEPARTMENTS backView:_departmentsView];
}

- (void)initHead:(NSString *)imageName labelName:(NSString *)labelName backView:(UIView *)backView {
    //image
    UIImageView *courseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
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

- (void)initField:(NSString *)imageName labelName:(NSString *)labelName fieldTag:(NSInteger)fieldTag backView:(UIView *)backView {
    
    [self initHead:imageName labelName:labelName backView:backView];
    
    //fieldBg
    UIImageView *fieldBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [fieldBgImageView setImage:[[UIImage imageNamed:@"build_put_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]];
    [backView addSubview:fieldBgImageView];
    [fieldBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(backView);
        make.top.mas_equalTo(K_FIELD_T);
    }];
    
    //field
    YTextField *textField = [[YTextField alloc] init];
    [textField placeHolderColor:[NSString stringWithFormat:@"请输入%@", labelName] fontColor:KCOLOR_B5];
    textField.font = CONTENT_FONT(12);
    textField.textColor = KCOLOR_B4;
    textField.delegate = self;
    textField.tag = fieldTag;
    [textField registerChanged:self action:@selector(textFieldValueChanged:)];
    [backView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(fieldBgImageView).insets(UIEdgeInsetsMake(0, K_CONTENT_LR, 0, K_CONTENT_LR));
    }];
}

- (void)initTime:(NSString *)imageName labelName:(NSString *)labelName timeTag:(NSInteger)timeTag backView:(UIView *)backView {
    
    [self initHead:imageName labelName:labelName backView:backView];
    
    //timeBg
    UIImageView *fieldBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [fieldBgImageView setImage:[[UIImage imageNamed:@"build_put_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]];
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
        make.edges.equalTo(fieldBgImageView).insets(UIEdgeInsetsMake(0, K_CONTENT_LR, 0, K_CONTENT_LR));
    }];
    
    UITapGestureRecognizer *beginTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showChoiceTime:)];
    [timeLabel addGestureRecognizer:beginTapGesture];
}

-(void)clickBtnForCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickBtnForChoice
{
}

#pragma mark - 选择日期
- (void)showChoiceTime:(UITapGestureRecognizer*)gesture
{
    _chooesTag = gesture.view.tag;
    
    if (nil == _datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 160)];
    }
    
    CommonPopView * popView = [[CommonPopView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                        showButton:YES
                                                            addSub:_datePicker
                                                             isTop:NO
                                                            isRoot:YES
                                                           addSelf:[UIApplication sharedApplication].keyWindow];
    [popView comSet:self action:@selector(choiceTime) params:nil];
    [popView showView];
    
}

//选择时间后
-(void)choiceTime {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    NSString * showStr = [formatter stringFromDate:_datePicker.date];
    //耦合性很高
    if (K_TAG_BCLASS == _chooesTag) {
        UILabel *timeLabel = (UILabel *)[_bClassView viewWithTag:_chooesTag];
        timeLabel.text = showStr;
        timeLabel.textColor = KCOLOR_B4;
    } else if (K_TAG_FCLASS == _chooesTag) {
        UILabel *timeLabel = (UILabel *)[_fClassView viewWithTag:_chooesTag];
        timeLabel.text = showStr;
        timeLabel.textColor = KCOLOR_B4;
    }
    
}

#pragma mark - UITextFieldDelegate  键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldValueChanged:(UITextField *)sender{

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
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(_titleView.bottomY, 0, keyboardBounds.size.height, 0));
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
