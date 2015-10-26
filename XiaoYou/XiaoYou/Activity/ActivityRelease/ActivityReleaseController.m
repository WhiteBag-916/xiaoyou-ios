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
#import "ActivityInfoModel.h"
#import "ActivityImageTextModels.h"
#import "ImageUploadModel.h"
#import "YDirectory+Data.h"

typedef enum : NSUInteger {
    POSITION1 = 1,
    POSITION2 = 2,
    POSITION3 = 3,
    POSITION4 = 4,
    POSITION5 = 5,
    POSITION6 = 6,
} MyPositionNum;

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

//数据Manager
@property (nonatomic,strong) ActivityReleaseDataManager * dataManager;

@end

@implementation ActivityReleaseController


- (instancetype)initWithIsIdentity:(BOOL) isIdentity
{
    self = [super init];
    if (self) {
        _isIdentity = isIdentity;
    }
    return self;
}

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollPosition:) name:KNotification_Activity_Release_ScrollTo object:nil];
    
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

-(void)changeScrollPosition:(NSNotification *) notification
{
    switch ([notification.object[@"position"] integerValue])
    {
        case POSITION1:
            NSLog(@"1");
            [self clickeLabelButton:_btn1];
            [self setPointHighlight:1];
            break;
        case POSITION2:
            NSLog(@"2");
            [self clickeLabelButton:_btn2];
            [self setPointHighlight:2];
            break;
        case POSITION3:
            NSLog(@"3");
            [self clickeLabelButton:_btn3];
            [self setPointHighlight:3];
            break;
        case POSITION4:
            NSLog(@"4");
            [self clickeLabelButton:_btn4];
            [self setPointHighlight:4];
            break;
        case POSITION5:
            NSLog(@"5");
            [self clickeLabelButton:_btn5];
            [self setPointHighlight:5];
            break;
        case POSITION6:
            NSLog(@"6");
            [self clickeLabelButton:_btn6];
            [self setPointHighlight:6];
            break;
            
        default:
            break;
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
    
    //.........
    //Point1
    _point1View = [[UIView alloc] init];
    _point1View.backgroundColor = KCOLORGREEN_g1;
    _point1View.layer.cornerRadius = SCALE_NUM(4);
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
        if (_isIdentity)
        {
            make.width.mas_equalTo(SCALE_NUM((SCREEN_WIDTH - 78)/5));
        }
        else
        {
            make.width.mas_equalTo(SCALE_NUM((SCREEN_WIDTH - 70)/4));
        }
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
    _point2View.backgroundColor = KCOLORGREEN_B5;
    _point2View.layer.cornerRadius = SCALE_NUM(4);
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
        if (_isIdentity)
        {
            make.width.mas_equalTo(SCALE_NUM((SCREEN_WIDTH - 78)/5));
        }
        else
        {
            make.width.mas_equalTo(SCALE_NUM((SCREEN_WIDTH - 70)/4));
        }
        make.height.mas_equalTo(2);
    }];
    _typeLabel2 = [[UILabel alloc]init];
    _typeLabel2.text = @"描述";
    _typeLabel2.textAlignment = NSTextAlignmentCenter;
    _typeLabel2.textColor = KCOLORGREEN_B3;
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
    _point3View.backgroundColor = KCOLORGREEN_B5;
    _point3View.layer.cornerRadius = SCALE_NUM(4);
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
        if (_isIdentity)
        {
            make.width.mas_equalTo(SCALE_NUM((SCREEN_WIDTH - 78)/5));
        }
        else
        {
            make.width.mas_equalTo(SCALE_NUM((SCREEN_WIDTH - 70)/4));
        }
        make.height.mas_equalTo(2);
    }];
    _typeLabel3 = [[UILabel alloc]init];
    _typeLabel3.text = @"时间";
    _typeLabel3.textAlignment = NSTextAlignmentCenter;
    _typeLabel3.textColor = KCOLORGREEN_B3;
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
    _point4View.backgroundColor = KCOLORGREEN_B5;
    _point4View.layer.cornerRadius = SCALE_NUM(4);
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
        if (_isIdentity)
        {
            make.width.mas_equalTo(SCALE_NUM((SCREEN_WIDTH - 78)/5));
        }
        else
        {
            make.width.mas_equalTo(SCALE_NUM((SCREEN_WIDTH - 70)/4));
        }
        make.height.mas_equalTo(2);
    }];
    _typeLabel4 = [[UILabel alloc]init];
    _typeLabel4.text = @"地点";
    _typeLabel4.textAlignment = NSTextAlignmentCenter;
    _typeLabel4.textColor = KCOLORGREEN_B3;
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
    _point5View.backgroundColor = KCOLORGREEN_B5;
    _point5View.layer.cornerRadius = SCALE_NUM(4);
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
    _typeLabel5.textColor = KCOLORGREEN_B3;
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
            make.width.mas_equalTo(SCALE_NUM((SCREEN_WIDTH - 78)/5));
            make.height.mas_equalTo(2);
        }];
        
        _point6View = [[UIImageView alloc] init];
        _point6View.backgroundColor = KCOLORGREEN_B5;
        _point6View.layer.cornerRadius = SCALE_NUM(4);
        _point6View.clipsToBounds = YES;
        [_scrollView addSubview:_point6View];
        [_point6View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line5.mas_right);
            make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
            make.width.height.mas_equalTo(SCALE_NUM(8));
        }];
        _typeLabel6 = [[UILabel alloc]init];
        _typeLabel6.text = @"审核";
        _typeLabel6.textAlignment = NSTextAlignmentCenter;
        _typeLabel6.textColor = KCOLORGREEN_B3;
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
    backgroundView.backgroundColor = KCOLORGREEN_B2;
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
    NSLog(@"%@",_dataManager.ActivityCheckStr);
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    
    [self savePic:_dataManager.ActivityDesciptionImage];
    
    if (_dataManager.ActivityDesciptionImage != nil)
    {
        NSString *keyStr = @"activityRelease.png";
        NSString *fullPath = [[YDirectory newImgCache] stringByAppendingPathComponent:keyStr];
        
        [[ActivityManager sharedInstance] commonImgUpload:@"activity" needSnap:@"true" imagePath:fullPath block:^(YActionMessage *message) {
            NSLog(@"%@",message);
        }];
    }
    
//    ActivityInfoModel * model = [ActivityInfoModel new];
//    ActivityImageTextModels * imageTextModel = [ActivityImageTextModels new];
//    imageTextModel.content =
//    model.activityImageTextModels = 
//    [ActivityManager sharedInstance] editActivity:(*) block:<#^(YActionMessage *message)block#>
    
//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy年MM月dd日 a HH:mm"];
//    NSDate * applyDate = [formatter dateFromString:_dataManager.ActivityDateApplyText];
//    NSDate * endDate = [formatter dateFromString:_dataManager.ActivityDateEndText];
//    if ([endDate isEqualToDate:[applyDate laterDate:endDate]])
//    {
//        _dataManager.ActivityNameText = nil;
//        _dataManager.ActivityDesciptionText = nil;
//        _dataManager.ActivityDesciptionImage = nil;
//        _dataManager.ActivityDateApplyText = nil;
//        _dataManager.ActivityDateBeginText = nil;
//        _dataManager.ActivityDateEndText = nil;
//        _dataManager.ActivityPlaceText = nil;
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else
//    {
//        [YUtils showTitle:@"截至时间不能在活动结束时间之后"];
//    }
    
}

- (void)savePic:(UIImage *)image
{
    if (nil == image)
    {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *keyStr = @"activityRelease.png";
        
        //写入文件
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSString *fullPath = [[YDirectory newImgCache] stringByAppendingPathComponent:keyStr];
        
        //保存到沙盒
        [imageData writeToFile:fullPath atomically:NO];
        
    });
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
            _point6View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel6.textColor = KCOLORGREEN_B3;
            _typeLabel1.textColor = KCOLORGREEN_g1;
            _typeLabel2.textColor = KCOLORGREEN_B3;
            _typeLabel3.textColor = KCOLORGREEN_B3;
            _typeLabel4.textColor = KCOLORGREEN_B3;
            _typeLabel5.textColor = KCOLORGREEN_B3;
            break;
        case POINT2:
            _point2View.backgroundColor = KCOLORGREEN_g1;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            _point6View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel6.textColor = KCOLORGREEN_B3;
            _typeLabel2.textColor = KCOLORGREEN_g1;
            _typeLabel1.textColor = KCOLORGREEN_B3;
            _typeLabel3.textColor = KCOLORGREEN_B3;
            _typeLabel4.textColor = KCOLORGREEN_B3;
            _typeLabel5.textColor = KCOLORGREEN_B3;
            break;
        case POINT3:
            _point3View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            _point6View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel6.textColor = KCOLORGREEN_B3;
            _typeLabel3.textColor = KCOLORGREEN_g1;
            _typeLabel2.textColor = KCOLORGREEN_B3;
            _typeLabel1.textColor = KCOLORGREEN_B3;
            _typeLabel4.textColor = KCOLORGREEN_B3;
            _typeLabel5.textColor = KCOLORGREEN_B3;
            break;
        case POINT4:
            _point4View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            _point6View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel6.textColor = KCOLORGREEN_B3;
            _typeLabel4.textColor = KCOLORGREEN_g1;
            _typeLabel2.textColor = KCOLORGREEN_B3;
            _typeLabel3.textColor = KCOLORGREEN_B3;
            _typeLabel1.textColor = KCOLORGREEN_B3;
            _typeLabel5.textColor = KCOLORGREEN_B3;
            break;
        case POINT5:
            _point5View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point6View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel6.textColor = KCOLORGREEN_B3;
            _typeLabel5.textColor = KCOLORGREEN_g1;
            _typeLabel2.textColor = KCOLORGREEN_B3;
            _typeLabel3.textColor = KCOLORGREEN_B3;
            _typeLabel4.textColor = KCOLORGREEN_B3;
            _typeLabel1.textColor = KCOLORGREEN_B3;
            break;
        case POINT6:
            _point6View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            _typeLabel6.textColor = KCOLORGREEN_g1;
            _typeLabel5.textColor = KCOLORGREEN_B3;
            _typeLabel2.textColor = KCOLORGREEN_B3;
            _typeLabel3.textColor = KCOLORGREEN_B3;
            _typeLabel4.textColor = KCOLORGREEN_B3;
            _typeLabel1.textColor = KCOLORGREEN_B3;
            break;
            
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
