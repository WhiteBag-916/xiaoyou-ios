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

typedef enum : NSUInteger {
    POINT1 = 1,
    POINT2 = 2,
    POINT3 = 3,
    POINT4 = 4,
    POINT5 = 5,
} MyPointNum;

@interface ActivityReleaseController ()

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

//五个名称
@property (nonatomic,strong) UILabel * typeLabel1;
@property (nonatomic,strong) UILabel * typeLabel2;
@property (nonatomic,strong) UILabel * typeLabel3;
@property (nonatomic,strong) UILabel * typeLabel4;
@property (nonatomic,strong) UILabel * typeLabel5;

//数据Manager
@property (nonatomic,strong) ActivityReleaseDataManager * dataManager;

@end

@implementation ActivityReleaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataManager = [ActivityReleaseDataManager shareActivityReleaseDataManager];
    
    _dataManager.ActivityNameText = nil;
    _dataManager.ActivityDesciptionText = nil;
    _dataManager.ActivityDesciptionImage = nil;
    _dataManager.ActivityDateApplyText = nil;
    _dataManager.ActivityDateBeginText = nil;
    _dataManager.ActivityDateEndText = nil;
    _dataManager.ActivityPlaceText = nil;
    
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEnabelStateForReleaseBtn:) name:KNotification_Enabel_ReleaseBtn object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 改变发布按钮是否可点击状态方法
-(void)changeEnabelStateForReleaseBtn:(NSNotification *) notification
{
    if ([notification.object[@"isEnabel"] boolValue])
    {
        _releaseButton.enabled = YES;
        _releaseButton.backgroundColor = KCOLORGREEN_g1;
        [_releaseButton addTarget:self action:@selector(clickReleaseBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        _releaseButton.enabled = NO;
        _releaseButton.backgroundColor = KCOLORGREEN_B5;
        [_releaseButton removeTarget:self action:@selector(clickReleaseBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.bounds.size.height - SCALE_NUM(46));
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
    topLabel.text = @"有创意的文案会吸引到更多参与者喔";
    topLabel.textColor = KCOLORGREEN_B5;
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
    _releaseCollectionView = [[ActivityReleaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _releaseCollectionView.backgroundColor = [UIColor clearColor];
    _releaseCollectionView.myController = self;
    [_scrollView addSubview:_releaseCollectionView];
    [_releaseCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCALE_NUM(305));
    }];
    
    //.........
    //Point1
    _point1View = [[UIView alloc] init];
    _point1View.backgroundColor = KCOLORGREEN_g1;
    _point1View.layer.cornerRadius = 4;
    _point1View.clipsToBounds = YES;
    [_scrollView addSubview:_point1View];
    [_point1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    UIImageView * line1 = [[UIImageView alloc] init];
    line1.image = [UIImage imageNamed:@"line_dot"];
    [_scrollView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point1View.mas_right);
        make.centerY.equalTo(_point1View);
        make.width.mas_equalTo((SCREEN_WIDTH - 80)/4);
        make.height.mas_equalTo(2);
    }];
    _typeLabel1 = [[UILabel alloc]init];
    _typeLabel1.text = @"名称";
    _typeLabel1.textAlignment = NSTextAlignmentCenter;
    _typeLabel1.textColor = KCOLORGREEN_g1;
    _typeLabel1.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel1];
    [_typeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point1View);
        make.top.equalTo(_point1View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    UIButton * btn1 = [[UIButton alloc] init];
    btn1.tag = 000000001;
    btn1.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point1View);
        make.right.bottom.left.equalTo(_typeLabel1);
    }];
    [btn1 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //Point2
    _point2View = [[UIImageView alloc] init];
    _point2View.backgroundColor = KCOLORGREEN_B5;
    _point2View.layer.cornerRadius = 4;
    _point2View.clipsToBounds = YES;
    [_scrollView addSubview:_point2View];
    [_point2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    UIImageView * line2 = [[UIImageView alloc] init];
    line2.image = [UIImage imageNamed:@"line_dot"];
    [_scrollView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point2View.mas_right);
        make.centerY.equalTo(_point2View);
        make.width.mas_equalTo((SCREEN_WIDTH - 80)/4);
        make.height.mas_equalTo(2);
    }];
    _typeLabel2 = [[UILabel alloc]init];
    _typeLabel2.text = @"描述";
    _typeLabel2.textAlignment = NSTextAlignmentCenter;
    _typeLabel2.textColor = KCOLORGREEN_B5;
    _typeLabel2.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel2];
    [_typeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point2View);
        make.top.equalTo(_point2View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    UIButton * btn2 = [[UIButton alloc] init];
    btn2.tag = 000000002;
    btn2.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point2View);
        make.right.bottom.left.equalTo(_typeLabel2);
    }];
    [btn2 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //Point3
    _point3View = [[UIImageView alloc] init];
    _point3View.backgroundColor = KCOLORGREEN_B5;
    _point3View.layer.cornerRadius = 4;
    _point3View.clipsToBounds = YES;
    [_scrollView addSubview:_point3View];
    [_point3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    UIImageView * line3 = [[UIImageView alloc] init];
    line3.image = [UIImage imageNamed:@"line_dot"];
    [_scrollView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point3View.mas_right);
        make.centerY.equalTo(_point3View);
        make.width.mas_equalTo((SCREEN_WIDTH - 80)/4);
        make.height.mas_equalTo(2);
    }];
    _typeLabel3 = [[UILabel alloc]init];
    _typeLabel3.text = @"时间";
    _typeLabel3.textAlignment = NSTextAlignmentCenter;
    _typeLabel3.textColor = KCOLORGREEN_B5;
    _typeLabel3.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel3];
    [_typeLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point3View);
        make.top.equalTo(_point3View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    UIButton * btn3 = [[UIButton alloc] init];
    btn3.tag = 000000003;
    btn3.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point3View);
        make.right.bottom.left.equalTo(_typeLabel3);
    }];
    [btn3 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    //Point4
    _point4View = [[UIImageView alloc] init];
    _point4View.backgroundColor = KCOLORGREEN_B5;
    _point4View.layer.cornerRadius = 4;
    _point4View.clipsToBounds = YES;
    [_scrollView addSubview:_point4View];
    [_point4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line3.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    UIImageView * line4 = [[UIImageView alloc] init];
    line4.image = [UIImage imageNamed:@"line_dot"];
    [_scrollView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point4View.mas_right);
        make.centerY.equalTo(_point4View);
        make.width.mas_equalTo((SCREEN_WIDTH - 80)/4);
        make.height.mas_equalTo(2);
    }];
    _typeLabel4 = [[UILabel alloc]init];
    _typeLabel4.text = @"地点";
    _typeLabel4.textAlignment = NSTextAlignmentCenter;
    _typeLabel4.textColor = KCOLORGREEN_B5;
    _typeLabel4.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel4];
    [_typeLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point4View);
        make.top.equalTo(_point4View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    UIButton * btn4 = [[UIButton alloc] init];
    btn4.tag = 000000004;
    btn4.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:btn4];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point4View);
        make.right.bottom.left.equalTo(_typeLabel4);
    }];
    [btn4 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    //Point5
    _point5View = [[UIImageView alloc] init];
    _point5View.backgroundColor = KCOLORGREEN_B5;
    _point5View.layer.cornerRadius = 4;
    _point5View.clipsToBounds = YES;
    [_scrollView addSubview:_point5View];
    [_point5View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line4.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    _typeLabel5 = [[UILabel alloc]init];
    _typeLabel5.text = @"类型";
    _typeLabel5.textAlignment = NSTextAlignmentCenter;
    _typeLabel5.textColor = KCOLORGREEN_B5;
    _typeLabel5.font = CONTENT_FONT(12);
    [_scrollView addSubview:_typeLabel5];
    [_typeLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point5View);
        make.top.equalTo(_point5View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    UIButton * btn5 = [[UIButton alloc] init];
    btn5.tag = 000000005;
    btn5.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:btn5];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_point5View);
        make.right.bottom.left.equalTo(_typeLabel5);
    }];
    [btn5 addTarget:self action:@selector(clickeLabelButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //这咕噜你好好想想
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = KCOLORGREEN_B2;
    backgroundView.layer.cornerRadius = 15;
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
    remindLabel.text = @"兹事体大, 别选错啦";
    remindLabel.textColor = KCOLORGREEN_g1;
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
    _releaseButton.backgroundColor = KCOLORGREEN_B5;
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
    NSLog(@"发布");
    NSLog(@"%@",_dataManager.ActivityNameText);
    NSLog(@"%@",_dataManager.ActivityDesciptionText);
    NSLog(@"%@",_dataManager.ActivityDesciptionImage);
    NSLog(@"%@",_dataManager.ActivityDateApplyText);
    NSLog(@"%@",_dataManager.ActivityDateBeginText);
    NSLog(@"%@",_dataManager.ActivityDateEndText);
    NSLog(@"%@",_dataManager.ActivityPlaceText);
    NSLog(@"%@",_dataManager.ActivityTypeStr);
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
    NSDate * applyDate = [formatter dateFromString:_dataManager.ActivityDateApplyText];
    NSDate * endDate = [formatter dateFromString:_dataManager.ActivityDateEndText];
    if ([endDate isEqualToDate:[applyDate laterDate:endDate]])
    {
        _dataManager.ActivityNameText = nil;
        _dataManager.ActivityDesciptionText = nil;
        _dataManager.ActivityDesciptionImage = nil;
        _dataManager.ActivityDateApplyText = nil;
        _dataManager.ActivityDateBeginText = nil;
        _dataManager.ActivityDateEndText = nil;
        _dataManager.ActivityPlaceText = nil;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [YUtils showTitle:@"截至时间不能在活动结束时间之后"];
    }
    
}

-(void)setPointHighlight:(NSInteger) pointNum
{
    switch (pointNum) {
        case POINT1:
            _point1View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel1.textColor = KCOLORGREEN_g1;
            _typeLabel2.textColor = KCOLORGREEN_B5;
            _typeLabel3.textColor = KCOLORGREEN_B5;
            _typeLabel4.textColor = KCOLORGREEN_B5;
            _typeLabel5.textColor = KCOLORGREEN_B5;
            break;
        case POINT2:
            _point2View.backgroundColor = KCOLORGREEN_g1;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel2.textColor = KCOLORGREEN_g1;
            _typeLabel1.textColor = KCOLORGREEN_B5;
            _typeLabel3.textColor = KCOLORGREEN_B5;
            _typeLabel4.textColor = KCOLORGREEN_B5;
            _typeLabel5.textColor = KCOLORGREEN_B5;
            break;
        case POINT3:
            _point3View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel3.textColor = KCOLORGREEN_g1;
            _typeLabel2.textColor = KCOLORGREEN_B5;
            _typeLabel1.textColor = KCOLORGREEN_B5;
            _typeLabel4.textColor = KCOLORGREEN_B5;
            _typeLabel5.textColor = KCOLORGREEN_B5;
            break;
        case POINT4:
            _point4View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel4.textColor = KCOLORGREEN_g1;
            _typeLabel2.textColor = KCOLORGREEN_B5;
            _typeLabel3.textColor = KCOLORGREEN_B5;
            _typeLabel1.textColor = KCOLORGREEN_B5;
            _typeLabel5.textColor = KCOLORGREEN_B5;
            break;
        case POINT5:
            _point5View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel5.textColor = KCOLORGREEN_g1;
            _typeLabel2.textColor = KCOLORGREEN_B5;
            _typeLabel3.textColor = KCOLORGREEN_B5;
            _typeLabel4.textColor = KCOLORGREEN_B5;
            _typeLabel1.textColor = KCOLORGREEN_B5;
            break;
            
        default:
            break;
    }
}

-(void)clickeLabelButton:(UIButton *) btn
{
    switch (btn.tag) {
        case 000000001:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _releaseCollectionView.contentOffset = CGPointMake(0, 0);
            } completion:nil];
            break;
        }
        case 000000002:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(186), 0);
//                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(270), 0);
            } completion:nil];
            break;
        }
        case 000000003:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(418), 0);
//                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(540), 0);
            } completion:nil];
            break;
        }
        case 000000004:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(646), 0);
//                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(810), 0);
            } completion:nil];
            break;
        }
        case 000000005:
        {
            [UIView animateWithDuration:0.2 animations:^{
                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(830), 0);
//                _releaseCollectionView.contentOffset = CGPointMake(SCALE_NUM(1080), 0);
            } completion:nil];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
