//
//  ActivityReleaseController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityReleaseController.h"
#import "ActivityReleaseCollectionView.h"

@interface ActivityReleaseController ()

@property (nonatomic,strong) ActivityReleaseCollectionView * releaseCollectionView;
@property (nonatomic,strong) UIButton * releaseButton;

@property (nonatomic,strong) UIView * point1View;
@property (nonatomic,strong) UIView * point2View;
@property (nonatomic,strong) UIView * point3View;
@property (nonatomic,strong) UIView * point4View;
@property (nonatomic,strong) UIView * point5View;

@end

@implementation ActivityReleaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

-(void)setUpUI
{
    //顶部Label
    UILabel * topLabel = [[UILabel alloc] init];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.text = @"有创意的发布文案有助于薅到更多好玩的人";
    topLabel.textColor = KCOLORGREEN_B5;
    topLabel.font = CONTENT_FONT(12);
    [self.view addSubview:topLabel];
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
    [self.view addSubview:_releaseCollectionView];
    [_releaseCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCALE_NUM(305));
    }];
    
    //.........
    //1
    _point1View = [[UIView alloc] init];
    _point1View.backgroundColor = KCOLORGREEN_g1;
    _point1View.layer.cornerRadius = 4;
    _point1View.clipsToBounds = YES;
    [self.view addSubview:_point1View];
    [_point1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    UIImageView * line1 = [[UIImageView alloc] init];
    line1.image = [UIImage imageNamed:@"line_dot"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point1View.mas_right);
        make.centerY.equalTo(_point1View);
        make.width.mas_equalTo((SCREEN_WIDTH - 80)/4);
        make.height.mas_equalTo(2);
    }];
    UILabel * typeLabel1 = [[UILabel alloc]init];
    typeLabel1.text = @"名称";
    typeLabel1.textAlignment = NSTextAlignmentCenter;
    typeLabel1.textColor = KCOLORGREEN_B5;
    typeLabel1.font = CONTENT_FONT(12);
    [self.view addSubview:typeLabel1];
    [typeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point1View);
        make.top.equalTo(_point1View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    //2
    _point2View = [[UIImageView alloc] init];
    _point2View.backgroundColor = KCOLORGREEN_B5;
    _point2View.layer.cornerRadius = 4;
    _point2View.clipsToBounds = YES;
    [self.view addSubview:_point2View];
    [_point2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    UIImageView * line2 = [[UIImageView alloc] init];
    line2.image = [UIImage imageNamed:@"line_dot"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point2View.mas_right);
        make.centerY.equalTo(_point2View);
        make.width.mas_equalTo((SCREEN_WIDTH - 80)/4);
        make.height.mas_equalTo(2);
    }];
    UILabel * typeLabel2 = [[UILabel alloc]init];
    typeLabel2.text = @"描述";
    typeLabel2.textAlignment = NSTextAlignmentCenter;
    typeLabel2.textColor = KCOLORGREEN_B5;
    typeLabel2.font = CONTENT_FONT(12);
    [self.view addSubview:typeLabel2];
    [typeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point2View);
        make.top.equalTo(_point2View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    //3
    _point3View = [[UIImageView alloc] init];
    _point3View.backgroundColor = KCOLORGREEN_B5;
    _point3View.layer.cornerRadius = 4;
    _point3View.clipsToBounds = YES;
    [self.view addSubview:_point3View];
    [_point3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    UIImageView * line3 = [[UIImageView alloc] init];
    line3.image = [UIImage imageNamed:@"line_dot"];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point3View.mas_right);
        make.centerY.equalTo(_point3View);
        make.width.mas_equalTo((SCREEN_WIDTH - 80)/4);
        make.height.mas_equalTo(2);
    }];
    UILabel * typeLabel3 = [[UILabel alloc]init];
    typeLabel3.text = @"时间";
    typeLabel3.textAlignment = NSTextAlignmentCenter;
    typeLabel3.textColor = KCOLORGREEN_B5;
    typeLabel3.font = CONTENT_FONT(12);
    [self.view addSubview:typeLabel3];
    [typeLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point3View);
        make.top.equalTo(_point3View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    //4
    _point4View = [[UIImageView alloc] init];
    _point4View.backgroundColor = KCOLORGREEN_B5;
    _point4View.layer.cornerRadius = 4;
    _point4View.clipsToBounds = YES;
    [self.view addSubview:_point4View];
    [_point4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line3.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    UIImageView * line4 = [[UIImageView alloc] init];
    line4.image = [UIImage imageNamed:@"line_dot"];
    [self.view addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_point4View.mas_right);
        make.centerY.equalTo(_point4View);
        make.width.mas_equalTo((SCREEN_WIDTH - 80)/4);
        make.height.mas_equalTo(2);
    }];
    UILabel * typeLabel4 = [[UILabel alloc]init];
    typeLabel4.text = @"地点";
    typeLabel4.textAlignment = NSTextAlignmentCenter;
    typeLabel4.textColor = KCOLORGREEN_B5;
    typeLabel4.font = CONTENT_FONT(12);
    [self.view addSubview:typeLabel4];
    [typeLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point4View);
        make.top.equalTo(_point4View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    //5
    _point5View = [[UIImageView alloc] init];
    _point5View.backgroundColor = KCOLORGREEN_B5;
    _point5View.layer.cornerRadius = 4;
    _point5View.clipsToBounds = YES;    [self.view addSubview:_point5View];
    [_point5View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line4.mas_right);
        make.top.equalTo(_releaseCollectionView.mas_bottom).offset(SCALE_NUM(20));
        make.width.height.mas_equalTo(SCALE_NUM(8));
    }];
    UILabel * typeLabel5 = [[UILabel alloc]init];
    typeLabel5.text = @"类型";
    typeLabel5.textAlignment = NSTextAlignmentCenter;
    typeLabel5.textColor = KCOLORGREEN_B5;
    typeLabel5.font = CONTENT_FONT(12);
    [self.view addSubview:typeLabel5];
    [typeLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_point5View);
        make.top.equalTo(_point5View.mas_bottom).offset(SCALE_NUM(8));
        make.width.mas_equalTo(SCALE_NUM(30));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    //这咕噜你好好想想
    UIView * backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = KCOLORGREEN_B2;
    backgroundView.layer.cornerRadius = 15;
    backgroundView.clipsToBounds = YES;
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_releaseCollectionView).offset(SCALE_NUM(20));
        make.trailing.mas_equalTo(SCALE_NUM(30));
        make.top.equalTo(typeLabel1.mas_bottom).offset(SCALE_NUM(15));
        make.height.mas_equalTo(SCALE_NUM(34));
    }];
    
    UIImageView * remindImageView = [[UIImageView alloc] init];
    remindImageView.image = [UIImage imageNamed:@"icon_info"];
    [backgroundView addSubview:remindImageView];
    [remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backgroundView);
        make.leading.mas_equalTo(SCALE_NUM(20));
        make.height.width.mas_equalTo(SCALE_NUM(13));
    }];
    
    UILabel * remindLabel = [[UILabel alloc] init];
    remindLabel.text = @"这轱辘你好好想想";
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
    _releaseButton.backgroundColor = KCOLORGREEN_B5;
    [_releaseButton setTitle:@"发布" forState:UIControlStateNormal];
    [_releaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_releaseButton addTarget:self action:@selector(clickReleaseBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_releaseButton];
    [_releaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(46));
    }];
    
}

-(void)clickReleaseBtn
{
    NSLog(@"发布");
}

-(void)setPointHighlight:(NSInteger) num
{
    switch (num) {
        case 1:
            _point1View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            break;
        case 2:
            _point2View.backgroundColor = KCOLORGREEN_g1;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            break;
        case 3:
            _point3View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            break;
        case 4:
            _point4View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            _point5View.backgroundColor = KCOLORGREEN_B5;
            break;
        case 5:
            _point5View.backgroundColor = KCOLORGREEN_g1;
            _point2View.backgroundColor = KCOLORGREEN_B5;
            _point3View.backgroundColor = KCOLORGREEN_B5;
            _point4View.backgroundColor = KCOLORGREEN_B5;
            _point1View.backgroundColor = KCOLORGREEN_B5;
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
