//
//  ActivityReleaseController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityReleaseController.h"
#import "ActivityReleaseCollectionView.h"
#import "ActivityReleaseDataManager.h"
#import "ActivityManager.h"
#import "YDirectory+Data.h"
#import "ActivityInfoModel.h"
#import "YKeyBoard.h"

typedef enum : NSUInteger {
    POSITION1 = 1,
    POSITION2 = 2,
    POSITION3 = 3,
    POSITION4 = 4,
    POSITION5 = 5,
    POSITION6 = 6,
} MyPositionNum;

@interface ActivityReleaseController ()<UIScrollViewDelegate>

@property (nonatomic,strong) ActivityReleaseCollectionView * releaseCollectionView;

//背景scrollView
@property (nonatomic,strong)UIScrollView * scrollView;
//发布按钮
@property (nonatomic,strong) UIButton * releaseButton;
//五个可变状态的点
@property (nonatomic,strong) UIView * point1View;
@property (nonatomic,strong) UIView * point2View;
@property (nonatomic,strong) UIView * point3View;
@property (nonatomic,strong) UIView * point4View;
@property (nonatomic,strong) UIView * point5View;
@property (nonatomic,strong) UIView * point6View;

//五个名称
@property (nonatomic,strong) UILabel * typeLabel1;
@property (nonatomic,strong) UILabel * typeLabel2;
@property (nonatomic,strong) UILabel * typeLabel3;
@property (nonatomic,strong) UILabel * typeLabel4;
@property (nonatomic,strong) UILabel * typeLabel5;
@property (nonatomic,strong) UILabel * typeLabel6;

@property (nonatomic,strong) UIButton * btn1;
@property (nonatomic,strong) UIButton * btn2;
@property (nonatomic,strong) UIButton * btn3;
@property (nonatomic,strong) UIButton * btn4;
@property (nonatomic,strong) UIButton * btn5;
@property (nonatomic,strong) UIButton * btn6;

//是否为社长
@property (nonatomic,assign) BOOL isIdentity;

@property (nonatomic,assign) BOOL isKeyBoardShow;

//数据Manager
@property (nonatomic,strong) ActivityReleaseDataManager * dataManager;

@end

@implementation ActivityReleaseController


- (instancetype)initWithIsIdentity:(BOOL) isIdentity
{
    self = [super init];
    if (self) {
        _isIdentity = isIdentity;
        _isKeyBoardShow = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    _dataManager = [ActivityReleaseDataManager shareActivityReleaseDataManager];
    _dataManager.isIdentity = _isIdentity;
    
    [self removeManagerData];
    
    //设置初始审核值
    if (_isIdentity)
    {
        _dataManager.ActivityCheckStatus = @"need_check";
    }
    else
    {
        _dataManager.ActivityCheckStatus = @"no_check";
    }
    
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEnabelStateForReleaseBtn:) name:KNotification_Enabel_ReleaseBtn object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollPosition:) name:KNotification_Activity_Release_ScrollTo object:nil];
    
    [YKeyBoard registerKeyBoardWithTarget:self];
}

-(void)keyboardWillShowNotification:(NSNotification *)note{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    // Need to translate the bounds to account for rotation.
    NSInteger scrollHeight = self.view.height-keyboardBounds.size.height;
    
//    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(scrollHeight);
//    }];
    
    _scrollView.height = scrollHeight;
}

- (void)keyboardWillHideNotification:(NSNotification *)note {
    _scrollView.height = self.view.bounds.size.height - SCALE_NUM(46);
    _scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)removeManagerData
{
    _dataManager.ActivityNameText = nil;
    _dataManager.ActivityDesciptionText = nil;
    _dataManager.ActivityDesciptionImage = nil;
    _dataManager.ActivityDateEndApplyText = nil;
    _dataManager.ActivityDateBeginApplyText = nil;
    _dataManager.ActivityDateBeginText = nil;
    _dataManager.ActivityDateEndText = nil;
    _dataManager.ActivityPlaceText = nil;
    _dataManager.ActivityTypeStr = nil;
    _dataManager.ActivityCheckStr = nil;
}

#pragma mark - 改变发布按钮是否可点击状态方法
-(void)changeEnabelStateForReleaseBtn:(NSNotification *) notification
{
    if ([notification.object[@"isEnabel"] boolValue])
    {
        _releaseButton.enabled = YES;
        _releaseButton.backgroundColor = KCOLOR_g1;
        [_releaseButton addTarget:self action:@selector(clickReleaseBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        _releaseButton.enabled = NO;
        _releaseButton.backgroundColor = KCOLOR_B5;
        [_releaseButton removeTarget:self action:@selector(clickReleaseBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)changeScrollPosition:(NSNotification *) notification
{
    NSInteger positionNum = [notification.object[@"position"] integerValue];
    switch (positionNum)
    {
        case POSITION1:
            NSLog(@"1");
            [self showkeyword:_btn1];
            [self setPointHighlight:1];
            break;
        case POSITION2:
            NSLog(@"2");
            [self showkeyword:_btn2];
            [self setPointHighlight:2];
            break;
        case POSITION3:
            NSLog(@"3");
            [self showkeyword:_btn3];
            [self setPointHighlight:3];
            break;
        case POSITION4:
            NSLog(@"4");
            [self showkeyword:_btn4];
            [self setPointHighlight:4];
            break;
        case POSITION5:
            NSLog(@"5");
            [self showkeyword:_btn5];
            [self setPointHighlight:5];
            break;
        case POSITION6:
            NSLog(@"6");
            [self showkeyword:_btn6];
            [self setPointHighlight:6];
            break;
            
        default:
            break;
    }
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.bounds.size.height - SCALE_NUM(46));
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCALE_NUM(460));
    
}

-(void)setUpUI
{
    [self showCustomNavigationBackButton];
    self.title = @"发布活动";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.bounds.size.height - SCALE_NUM(46))];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.scrollEnabled = YES;
    [self.view addSubview:_scrollView];
    
    
    //顶部Label
    UILabel * topLabel = [[UILabel alloc] init];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.text = @"活动发布后不能修改删除，请慎重呦";
    topLabel.textColor = KCOLOR_B5;
    topLabel.font = CONTENT_FONT(12);
    [_scrollView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.left.mas_equalTo(SCALE_NUM(12));
        make.height.mas_equalTo(SCALE_NUM(40));
    }];
    
    //CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _releaseCollectionView = [[ActivityReleaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout andIsIdentity:_isIdentity];
    _releaseCollectionView.backgroundColor = [UIColor clearColor];
    _releaseCollectionView.myController = self;
    [_scrollView addSubview:_releaseCollectionView];
    [_releaseCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCALE_NUM(305));
    }];
    
    //Point1
    _point1View = [[UIView alloc] init];
    _point1View.backgroundColor = KCOLOR_g1;
    _point1View.layer.cornerRadius = SCALE_NUM(4);
    _point1View.clipsToBounds = YES;
    [_scrollView addSubview:_point1View];
    [_point1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(8);
    }];
    UIImageView * line1 = [[UIImageView alloc] init];
    line1.image = [UIImage imageNamed:@"line_dot"];
    [_scrollView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point1View.mas_right);
        make.centerY.equalTo(_point1View);
        if (_isIdentity)
        {
            make.width.mas_equalTo((SCREEN_WIDTH - 78)/5);
        }
        else
        {
            make.width.mas_equalTo((SCREEN_WIDTH - 70)/4);
        }
        make.height.mas_equalTo(2);
    }];
    _typeLabel1 = [[UILabel alloc]init];
    _typeLabel1.text = @"名称";
    _typeLabel1.textAlignment = NSTextAlignmentCenter;
    _typeLabel1.textColor = KCOLOR_g1;
    _typeLabel1.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel1];
    [_typeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point1View);
        make.top.equalTo(_point1View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    _btn1 = [[UIButton alloc] init];
    _btn1.tag = 100000001;
    _btn1.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_btn1];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point1View);
        make.right.bottom.left.equalTo(_typeLabel1);
    }];
    [_btn1 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //Point2
    _point2View = [[UIImageView alloc] init];
    _point2View.backgroundColor = KCOLOR_B5;
    _point2View.layer.cornerRadius = SCALE_NUM(4);
    _point2View.clipsToBounds = YES;
    [_scrollView addSubview:_point2View];
    [_point2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(8);
    }];
    UIImageView * line2 = [[UIImageView alloc] init];
    line2.image = [UIImage imageNamed:@"line_dot"];
    [_scrollView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point2View.mas_right);
        make.centerY.equalTo(_point2View);
        if (_isIdentity)
        {
            make.width.mas_equalTo((SCREEN_WIDTH - 78)/5);
        }
        else
        {
            make.width.mas_equalTo((SCREEN_WIDTH - 70)/4);
        }
        make.height.mas_equalTo(2);
    }];
    _typeLabel2 = [[UILabel alloc]init];
    _typeLabel2.text = @"描述";
    _typeLabel2.textAlignment = NSTextAlignmentCenter;
    _typeLabel2.textColor = KCOLOR_B3;
    _typeLabel2.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel2];
    [_typeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point2View);
        make.top.equalTo(_point2View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    _btn2 = [[UIButton alloc] init];
    _btn2.tag = 100000002;
    _btn2.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_btn2];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point2View);
        make.right.bottom.left.equalTo(_typeLabel2);
    }];
    [_btn2 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //Point3
    _point3View = [[UIImageView alloc] init];
    _point3View.backgroundColor = KCOLOR_B5;
    _point3View.layer.cornerRadius = SCALE_NUM(4);
    _point3View.clipsToBounds = YES;
    [_scrollView addSubview:_point3View];
    [_point3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(8);
    }];
    UIImageView * line3 = [[UIImageView alloc] init];
    line3.image = [UIImage imageNamed:@"line_dot"];
    [_scrollView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point3View.mas_right);
        make.centerY.equalTo(_point3View);
        if (_isIdentity)
        {
            make.width.mas_equalTo((SCREEN_WIDTH - 78)/5);
        }
        else
        {
            make.width.mas_equalTo((SCREEN_WIDTH - 70)/4);
        }
        make.height.mas_equalTo(2);
    }];
    _typeLabel3 = [[UILabel alloc]init];
    _typeLabel3.text = @"时间";
    _typeLabel3.textAlignment = NSTextAlignmentCenter;
    _typeLabel3.textColor = KCOLOR_B3;
    _typeLabel3.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel3];
    [_typeLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point3View);
        make.top.equalTo(_point3View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    _btn3 = [[UIButton alloc] init];
    _btn3.tag = 100000003;
    _btn3.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_btn3];
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point3View);
        make.right.bottom.left.equalTo(_typeLabel3);
    }];
    [_btn3 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    //Point4
    _point4View = [[UIImageView alloc] init];
    _point4View.backgroundColor = KCOLOR_B5;
    _point4View.layer.cornerRadius = SCALE_NUM(4);
    _point4View.clipsToBounds = YES;
    [_scrollView addSubview:_point4View];
    [_point4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line3.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(8);
    }];
    UIImageView * line4 = [[UIImageView alloc] init];
    line4.image = [UIImage imageNamed:@"line_dot"];
    [_scrollView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point4View.mas_right);
        make.centerY.equalTo(_point4View);
        if (_isIdentity)
        {
            make.width.mas_equalTo((SCREEN_WIDTH - 78)/5);
        }
        else
        {
            make.width.mas_equalTo((SCREEN_WIDTH - 70)/4);
        }
        make.height.mas_equalTo(2);
    }];
    _typeLabel4 = [[UILabel alloc]init];
    _typeLabel4.text = @"地点";
    _typeLabel4.textAlignment = NSTextAlignmentCenter;
    _typeLabel4.textColor = KCOLOR_B3;
    _typeLabel4.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel4];
    [_typeLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point4View);
        make.top.equalTo(_point4View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    _btn4 = [[UIButton alloc] init];
    _btn4.tag = 100000004;
    _btn4.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_btn4];
    [_btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point4View);
        make.right.bottom.left.equalTo(_typeLabel4);
    }];
    [_btn4 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    //Point5
    _point5View = [[UIImageView alloc] init];
    _point5View.backgroundColor = KCOLOR_B5;
    _point5View.layer.cornerRadius = SCALE_NUM(4);
    _point5View.clipsToBounds = YES;
    [_scrollView addSubview:_point5View];
    [_point5View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line4.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(8);
    }];

    _typeLabel5 = [[UILabel alloc]init];
    _typeLabel5.text = @"类型";
    _typeLabel5.textAlignment = NSTextAlignmentCenter;
    _typeLabel5.textColor = KCOLOR_B3;
    _typeLabel5.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel5];
    [_typeLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point5View);
        make.top.equalTo(_point5View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    _btn5 = [[UIButton alloc] init];
    _btn5.tag = 100000005;
    _btn5.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_btn5];
    [_btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point5View);
        make.right.bottom.left.equalTo(_typeLabel5);
    }];
    [_btn5 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //Point6
    if (_isIdentity)
    {
        UIImageView * line5 = [[UIImageView alloc] init];
        line5.image = [UIImage imageNamed:@"line_dot"];
        [_scrollView addSubview:line5];
        [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_point5View.mas_right);
            make.centerY.equalTo(_point5View);
            make.width.mas_equalTo((SCREEN_WIDTH - 78)/5);
            make.height.mas_equalTo(2);
        }];
        
        _point6View = [[UIImageView alloc] init];
        _point6View.backgroundColor = KCOLOR_B5;
        _point6View.layer.cornerRadius = SCALE_NUM(4);
        _point6View.clipsToBounds = YES;
        [_scrollView addSubview:_point6View];
        [_point6View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line5.mas_right);
            make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
            make.width.height.mas_equalTo(8);
        }];
        _typeLabel6 = [[UILabel alloc]init];
        _typeLabel6.text = @"审核";
        _typeLabel6.textAlignment = NSTextAlignmentCenter;
        _typeLabel6.textColor = KCOLOR_B3;
        _typeLabel6.font = CONTENT_FONT(12);
        [_scrollView addSubview:_typeLabel6];
        [_typeLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_point6View);
            make.top.equalTo(_point5View.mas_bottom).offset(SCALE_NUM(8));
            make.width.mas_equalTo(SCALE_NUM(30));
            make.height.mas_equalTo(SCALE_NUM(12));
        }];
        _btn6 = [[UIButton alloc] init];
        _btn6.tag = 100000006;
        _btn6.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:_btn6];
        [_btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_point5View);
            make.right.bottom.left.equalTo(_typeLabel6);
        }];
        [_btn6 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //这咕噜你好好想想
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = KCOLOR_B2;
    backgroundView.layer.cornerRadius = SCALE_NUM(17);
    backgroundView.clipsToBounds = YES;
    [_scrollView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_releaseCollectionView).offset(SCALE_NUM(20));
        make.right.equalTo(self.view).offset(30);
        make.top.equalTo(_typeLabel1.mas_bottom).offset(SCALE_NUM(15));
        make.height.mas_equalTo(SCALE_NUM(34));
    }];
    
    //提示部分
    UIImageView * remindImageView = [[UIImageView alloc] init];
    remindImageView.image = [UIImage imageNamed:@"icon_info"];
    [backgroundView addSubview:remindImageView];
    [remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backgroundView);
        make.leading.mas_equalTo(SCALE_NUM(20));
        make.height.width.mas_equalTo(SCALE_NUM(13));
    }];
    
    UILabel * remindLabel = [[UILabel alloc] init];
    remindLabel.text = @"兹事体大, 别写错啦";
    remindLabel.textColor = KCOLOR_g1;
    remindLabel.font = CONTENT_FONT(12);
    [backgroundView addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backgroundView);
        make.left.equalTo(remindImageView.mas_right).offset(SCALE_NUM(12));
        make.height.mas_equalTo(SCALE_NUM(12));
        make.width.mas_equalTo(SCALE_NUM(150));
    }];
    
    
    //发布按钮
    _releaseButton = [[UIButton alloc] init];
    _releaseButton.hidden = NO;
    _releaseButton.backgroundColor = KCOLOR_B5;
    [_releaseButton setTitle:@"发布" forState:UIControlStateNormal];
    [_releaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_releaseButton];
    [_releaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(46));
    }];
    
}

-(void)clickReleaseBtn
{
    [YUtils showHUDWithTitle];
    
    if (_dataManager.ActivityDesciptionImage != nil)
    {
        NSString *keyStr = @"activityRelease.png";
        NSString *fullPath = [[YDirectory newImgCache] stringByAppendingPathComponent:keyStr];
        
        [[ActivityManager sharedInstance] commonImgUpload:@"activity" needSnap:@"true" imagePath:fullPath block:^(YActionMessage *message) {
            NSLog(@"%@",message);
            
            [YUtils hiddenProgressHUD];
//            [YUtils showTitle:message.desc hideAfter:2];
            if (message.isSuccess)
            {
                [self sendReleaseRequest:message];
            }
            else
            {
                [YUtils showTitle:message.desc hideAfter:2];
            }
        }];
    }
    else
    {
        [self sendReleaseRequest:nil];
    }
    
}

//去掉字符串开头结尾空格和回车

-(NSString *)removeSpaceAndNewLine:(NSString *) text
{
    //去除两端空格
    NSString *temp = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //去除两端空格和回车
    NSString *reutrnText = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return reutrnText;
}


//发布活动请求
-(void)sendReleaseRequest:(YActionMessage *) message
{
    _dataManager.ActivityNameText = [self removeSpaceAndNewLine:_dataManager.ActivityNameText];
    _dataManager.ActivityPlaceText = [self removeSpaceAndNewLine:_dataManager.ActivityPlaceText];
    _dataManager.ActivityDesciptionText = [self removeSpaceAndNewLine:_dataManager.ActivityDesciptionText];
    
    NSMutableDictionary *modelDic = [@{} mutableCopy];
    NSMutableDictionary *activityModelDic = [@{} mutableCopy];
    
    [activityModelDic setObject:[self transformDate:_dataManager.ActivityDateEndText] forKey:@"actEndTime"];
    [activityModelDic setObject:[self transformDate:_dataManager.ActivityDateBeginText] forKey:@"actStartTime"];
    [activityModelDic setObject:_dataManager.ActivityCheckStatus forKey:@"checkStatus"];
    if (_isIdentity)
    {
        [activityModelDic setObject:@"group_activity" forKey:@"activityDirection"];
        [activityModelDic setObject:_dataManager.ActivityOrganizer forKey:@"activityOrganizer"];
        [activityModelDic setObject:_dataManager.ActivityOrganizerId forKey:@"activityOrganizerId"];
        if ([_dataManager.ActivityCheckStr isEqualToString:@"需要报名审核"])
        {
            [activityModelDic setObject:@"true" forKey:@"enrollCheck"];
        }
        else
        {
            [activityModelDic setObject:@"false" forKey:@"enrollCheck"];
        }
        
    }
    else
    {
        [activityModelDic setObject:@"user_activity" forKey:@"activityDirection"];
        [activityModelDic setObject:@"false" forKey:@"enrollCheck"];
    }
    [activityModelDic setObject:_dataManager.ActivityPlaceText forKey:@"address"];
    [activityModelDic setObject:@"true" forKey:@"enroll"];
    [activityModelDic setObject:[self transformDate:_dataManager.ActivityDateEndApplyText] forKey:@"enrollEndTime"];
    [activityModelDic setObject:[self transformDate:_dataManager.ActivityDateBeginApplyText] forKey:@"enrollStartTime"];
    [activityModelDic setObject:_dataManager.ActivityNameText forKey:@"name"];
    [activityModelDic setObject:_dataManager.ActivityTypeStr forKey:@"type"];
    
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    [arr addObject:@{@"content":_dataManager.ActivityDesciptionText,@"displayOrder":@2,@"type":@"text"}];
    if (message != nil)
    {
        [arr addObject:@{@"content":[message.object valueForKey:@"images"][0],@"displayOrder":@1,@"type":@"image"}];
    }
    else
    {
        [arr addObject:@{@"content":@"",@"displayOrder":@1,@"type":@"image"}];
    }
    
    [modelDic setObject:arr forKey:@"activityImageTextModels"];
    [modelDic setObject:activityModelDic forKey:@"activityModel"];
    
    
    [[ActivityManager sharedInstance] editActivity:modelDic block:^(YActionMessage *message) {
        NSLog(@"%@",message);
        [YUtils hiddenProgressHUD];
        [YUtils showTitle:message.desc hideAfter:2];
        if (message.isSuccess)
        {
            if ([[message.object valueForKey:@"code"] integerValue] == 1)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_Success object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    }];
}

//转换成标准时间
-(NSString *)transformDate:(NSString *) date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    NSDate * tempDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr = [formatter stringFromDate:tempDate];
    
    return dateStr;
}
//获取当前标准时间
-(NSString *)getNowDate
{
    NSDate * now = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr = [formatter stringFromDate:now];
    
    return dateStr;
}

-(void)setPointHighlight:(NSInteger) pointNum
{
    switch (pointNum) {
        case POINT1:
            _point1View.backgroundColor = KCOLOR_g1;
            _point2View.backgroundColor = KCOLOR_B5;
            _point3View.backgroundColor = KCOLOR_B5;
            _point4View.backgroundColor = KCOLOR_B5;
            _point5View.backgroundColor = KCOLOR_B5;
            _point6View.backgroundColor = KCOLOR_B5;
            _typeLabel6.textColor = KCOLOR_B3;
            _typeLabel1.textColor = KCOLOR_g1;
            _typeLabel2.textColor = KCOLOR_B3;
            _typeLabel3.textColor = KCOLOR_B3;
            _typeLabel4.textColor = KCOLOR_B3;
            _typeLabel5.textColor = KCOLOR_B3;
            break;
        case POINT2:
            _point2View.backgroundColor = KCOLOR_g1;
            _point1View.backgroundColor = KCOLOR_B5;
            _point3View.backgroundColor = KCOLOR_B5;
            _point4View.backgroundColor = KCOLOR_B5;
            _point5View.backgroundColor = KCOLOR_B5;
            _point6View.backgroundColor = KCOLOR_B5;
            _typeLabel6.textColor = KCOLOR_B3;
            _typeLabel2.textColor = KCOLOR_g1;
            _typeLabel1.textColor = KCOLOR_B3;
            _typeLabel3.textColor = KCOLOR_B3;
            _typeLabel4.textColor = KCOLOR_B3;
            _typeLabel5.textColor = KCOLOR_B3;
            break;
        case POINT3:
            _point3View.backgroundColor = KCOLOR_g1;
            _point2View.backgroundColor = KCOLOR_B5;
            _point1View.backgroundColor = KCOLOR_B5;
            _point4View.backgroundColor = KCOLOR_B5;
            _point5View.backgroundColor = KCOLOR_B5;
            _point6View.backgroundColor = KCOLOR_B5;
            _typeLabel6.textColor = KCOLOR_B3;
            _typeLabel3.textColor = KCOLOR_g1;
            _typeLabel2.textColor = KCOLOR_B3;
            _typeLabel1.textColor = KCOLOR_B3;
            _typeLabel4.textColor = KCOLOR_B3;
            _typeLabel5.textColor = KCOLOR_B3;
            break;
        case POINT4:
            _point4View.backgroundColor = KCOLOR_g1;
            _point2View.backgroundColor = KCOLOR_B5;
            _point3View.backgroundColor = KCOLOR_B5;
            _point1View.backgroundColor = KCOLOR_B5;
            _point5View.backgroundColor = KCOLOR_B5;
            _point6View.backgroundColor = KCOLOR_B5;
            _typeLabel6.textColor = KCOLOR_B3;
            _typeLabel4.textColor = KCOLOR_g1;
            _typeLabel2.textColor = KCOLOR_B3;
            _typeLabel3.textColor = KCOLOR_B3;
            _typeLabel1.textColor = KCOLOR_B3;
            _typeLabel5.textColor = KCOLOR_B3;
            break;
        case POINT5:
            _point5View.backgroundColor = KCOLOR_g1;
            _point2View.backgroundColor = KCOLOR_B5;
            _point3View.backgroundColor = KCOLOR_B5;
            _point4View.backgroundColor = KCOLOR_B5;
            _point1View.backgroundColor = KCOLOR_B5;
            _point6View.backgroundColor = KCOLOR_B5;
            _typeLabel6.textColor = KCOLOR_B3;
            _typeLabel5.textColor = KCOLOR_g1;
            _typeLabel2.textColor = KCOLOR_B3;
            _typeLabel3.textColor = KCOLOR_B3;
            _typeLabel4.textColor = KCOLOR_B3;
            _typeLabel1.textColor = KCOLOR_B3;
            break;
        case POINT6:
            _point6View.backgroundColor = KCOLOR_g1;
            _point2View.backgroundColor = KCOLOR_B5;
            _point3View.backgroundColor = KCOLOR_B5;
            _point4View.backgroundColor = KCOLOR_B5;
            _point1View.backgroundColor = KCOLOR_B5;
            _point5View.backgroundColor = KCOLOR_B5;
            _typeLabel6.textColor = KCOLOR_g1;
            _typeLabel5.textColor = KCOLOR_B3;
            _typeLabel2.textColor = KCOLOR_B3;
            _typeLabel3.textColor = KCOLOR_B3;
            _typeLabel4.textColor = KCOLOR_B3;
            _typeLabel1.textColor = KCOLOR_B3;
            break;
            
        default:
            break;
    }
}

-(void)showkeyword:(UIButton *) btn {
    switch (btn.tag) {
        case 100000001:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _releaseCollectionView.contentOffset = CGPointMake(0, 0);
            } completion:^(BOOL finished) {
                //键盘弹起
                [UIView animateWithDuration:0.2 animations:^{
                    CGFloat offY = SCALE_NUM(110);
                    _scrollView.contentOffset = CGPointMake(0, offY);
                }];
                
            }];
            break;
        }
        case 100000002:
        {
            [UIView animateWithDuration:0.2 animations:^{
                //                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(186), 0);
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(230), 0);
            } completion:^(BOOL finished) {
                //键盘弹起
                [UIView animateWithDuration:0.2 animations:^{
                    CGFloat offY = SCALE_NUM(162);
                    _scrollView.contentOffset = CGPointMake(0, offY);
                }];
                
            }];
            break;
        }
        case 100000003:
        {
            [UIView animateWithDuration:0.2 animations:^{
                //                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(418), 0);
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(460), 0);
            } completion:nil];
            break;
        }
        case 100000004:
        {
            [UIView animateWithDuration:0.2 animations:^{
                //                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(646), 0);
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(690), 0);
            } completion:^(BOOL finished) {
                //键盘弹起
                [UIView animateWithDuration:0.2 animations:^{
                    CGFloat offY = SCALE_NUM(110);
                    _scrollView.contentOffset = CGPointMake(0, offY);
                }];
            }];
            break;
        }
        case 100000005:
        {
            [UIView animateWithDuration:0.2 animations:^{
                if (_isIdentity)
                {
                    _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(920), 0);
                }
                else{
                    _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(830), 0);
                }
                
            } completion:nil];
            break;
        }
        case 100000006:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(1060), 0);
                //                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(920), 0);
            } completion:nil];
            break;
        }
            
        default:
            break;
    }
}

-(void)clickeLabelButton:(UIButton *) btn
{
    switch (btn.tag) {
        case 100000001:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _releaseCollectionView.contentOffset = CGPointMake(0, 0);
            } completion:nil];
            break;
        }
        case 100000002:
        {
            [UIView animateWithDuration:0.2 animations:^{
//                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(186), 0);
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(230), 0);
            } completion:nil];
            break;
        }
        case 100000003:
        {
            [UIView animateWithDuration:0.2 animations:^{
//                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(418), 0);
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(460), 0);
            } completion:nil];
            break;
        }
        case 100000004:
        {
            [UIView animateWithDuration:0.2 animations:^{
//                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(646), 0);
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(690), 0);
            } completion:nil];
            break;
        }
        case 100000005:
        {
            [UIView animateWithDuration:0.2 animations:^{
                if (_isIdentity)
                {
                    _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(920), 0);
                }
                else{
                    _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(830), 0);
                }
                
            } completion:nil];
            break;
        }
        case 100000006:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(1060), 0);
                //                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(920), 0);
            } completion:nil];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
