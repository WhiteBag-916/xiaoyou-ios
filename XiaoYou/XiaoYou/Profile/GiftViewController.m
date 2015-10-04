//
//  GiftViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/10/3.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "GiftViewController.h"
#import "YStripeView.h"

typedef NS_ENUM(NSInteger, GiftType) {
    /**
     *  @author 李思良, 15-10-04
     *
     *  @brief  打折类型
     */
    GiftTypeDiscount,
    /**
     *  @author 李思良, 15-10-04
     *
     *  @brief  金额类型
     */
    GiftTypeMoney,
    /**
     *  @author 李思良, 15-10-04
     *
     *  @brief  优惠券类型
     */
    GiftTypeTicket,
};

/**
 *  @author 李思良, 15-10-03
 *
 *  @brief  校友礼券
 */
@interface GiftViewController ()

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) UIView *seperateLine;
@property (nonatomic, strong) UIView *infoView;


@property (nonatomic, strong) NSArray *infoData;//填充数据
@property (nonatomic, assign) GiftType type;//礼券类型
@property (nonatomic, strong) UILabel *leftInfoLabel;//左侧数据

@end

@implementation GiftViewController

- (id)initWithCode:(NSString *)code {
    if (self = [super init]) {
        _code = code;
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"校园礼券";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showCustomNavigationBackButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [YUtils showHUDAddedTo:self.view title:@"正在加载" animated:true];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [YUtils hiddenProgressHUD:self.view];
        _infoData = @[@"名字", @"200000000000", @"敬酒数100"];
        [self initView];
    });
}

- (void)initView {
    [self initTop];
    [self initMiddle];
}
- (void)initTop {
    UIView *shadowView = [UIView new];
    shadowView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(SCALE_NUM(12));
        make.centerX.equalTo(self.view);
    }];
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOpacity = 0.2;
    shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor hexChangeFloat:@"f9f9f9"];
    [shadowView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(shadowView);
    }];
    topView.layer.cornerRadius = 4;
    topView.clipsToBounds = true;
    [self initTicket:topView];
    
    
    _seperateLine = [[UIView alloc] init];
    [self.view addSubview:_seperateLine];
    [_seperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerX.equalTo(shadowView);
        make.top.equalTo(shadowView.mas_bottom).offset(20);
        make.height.mas_equalTo(1);
    }];
    _seperateLine.backgroundColor = KCOLORWHITE_b8b7b7;
}

- (void)initTicket:(UIView *)topView {
    _type = GiftTypeTicket;
    YStripeView *leftBar = [[YStripeView alloc] init];
    [topView addSubview:leftBar];
    [leftBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(topView);
        make.width.mas_equalTo(13);
    }];
    _leftInfoLabel = [YUtils initLabel:CONTENT_FONT(15) color:[UIColor hexChangeFloat:@"009F93"] text:@"" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [topView addSubview:_leftInfoLabel];
    if (_type == GiftTypeTicket) {
        [_leftInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBar.mas_right).offset(10);
            make.top.bottom.equalTo(topView);
            make.width.mas_equalTo(SCALE_NUM(75));
        }];
        _leftInfoLabel.numberOfLines = 0;
        _leftInfoLabel.text = @"优惠券优惠券优惠券优惠券";
    } else {
        [_leftInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBar.mas_right).offset(10);
            make.centerY.equalTo(topView);
        }];
        _leftInfoLabel.font = CONTENT_FONT(38);
        _leftInfoLabel.text = @"8.5";
    }
    
    UILabel *rightHint;
    if (_type != GiftTypeTicket) {
        rightHint = [YUtils initLabel:CONTENT_FONT(17) color:[UIColor hexChangeFloat:@"009F93"] text:@"" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [topView addSubview:rightHint];
        [rightHint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftInfoLabel.mas_right).offset(2);
            make.bottom.equalTo(_leftInfoLabel).offset(-8);
        }];
        if (_type == GiftTypeDiscount) {
            rightHint.text = @"折";
        } else {
            rightHint.text = @"元";
        }
    }
    
    UIImageView *seperate = [[UIImageView alloc] init];
    [topView addSubview:seperate];
    [seperate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(8);
        make.top.bottom.equalTo(topView);
        if (_type == GiftTypeTicket) {
            make.left.equalTo(_leftInfoLabel.mas_right).offset(10);
        } else {
            make.left.equalTo(rightHint.mas_right).offset(10);
        }
    }];
    seperate.image = [[UIImage imageNamed:@"gift_line"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 0, 6, 0)];
    
    
    
    UIImageView *hint = [[UIImageView alloc] init];
    [topView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(12);
        make.top.mas_equalTo(10);
        make.left.equalTo(seperate.mas_right).offset(10);
    }];
    hint.image = [UIImage imageNamed:@"gift_home"];
    
    UILabel *title = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor hexChangeFloat:@"333333"] text:@"咖啡馆咖啡馆咖啡馆咖啡馆咖啡馆咖啡馆" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [topView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hint.mas_right).offset(5);
        make.right.equalTo(topView).offset(-10);
        make.top.bottom.equalTo(hint);
    }];
    
    UIColor *textColor = [UIColor hexChangeFloat:@"999999"];
    
    UILabel *addressIcon = [YUtils initLabel:CONTENT_FONT(11) color:textColor text:@"商家地址：" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [topView addSubview:addressIcon];
    [addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hint);
        make.width.mas_equalTo(65);
        make.top.equalTo(hint.mas_bottom).offset(19);
    }];
    
    UILabel *address = [YUtils initLabel:CONTENT_FONT(11) color:textColor text:@"北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区北京市海淀区" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [topView addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressIcon.mas_right);
        make.top.equalTo(addressIcon);
        make.right.equalTo(title);
    }];
    address.numberOfLines = 0;
    
    UILabel *timeIcon = [YUtils initLabel:CONTENT_FONT(11) color:textColor text:@"有效期限：" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [topView addSubview:timeIcon];
    [timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(address.mas_bottom).offset(10);
        make.left.width.height.equalTo(addressIcon);
    }];
    
    UILabel *time = [YUtils initLabel:CONTENT_FONT(11) color:textColor text:@"2015年10月20日前2015年10月20日前2015年10月20日前2015年10月20日前" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [topView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(address);
        make.top.equalTo(timeIcon);
    }];
    time.numberOfLines = 0;
    
    UILabel *methodIcon = [YUtils initLabel:CONTENT_FONT(11) color:textColor text:@"使用方式：" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [topView addSubview:methodIcon];
    [methodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(time.mas_bottom).offset(10);
        make.left.width.height.equalTo(addressIcon);
    }];
    
    UILabel *method = [YUtils initLabel:CONTENT_FONT(11) color:textColor text:@"在此页出示店员在此页出示店员在此页出示店员在此页出示店员在此页出示店员在此页出示店员在此页出示店员在此页出示店员" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [topView addSubview:method];
    [method mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(address);
        make.top.equalTo(methodIcon);
        make.bottom.equalTo(topView).offset(-10);
    }];
    method.numberOfLines = 0;

}

- (void)initMiddle {
    UILabel *hint = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor hexChangeFloat:@"666666"] text:@"基于你在校友网上的如下信息与表现：" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [self.view addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_seperateLine);
        make.top.equalTo(_seperateLine.mas_bottom).offset(15);
    }];
    
    UIView *middleView = [[UIView alloc] init];
    [self.view addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_seperateLine);
        make.top.equalTo(hint.mas_bottom).offset(12);
        make.height.mas_equalTo(100);
    }];
    middleView.backgroundColor = [UIColor hexChangeFloat:@"f9f9f9"];
    
    NSArray *pics = @[@"gift_head", @"gift_id", @"gift_respect"];
    
    for (int i = 0; i < 3; i ++) {
        UIImageView *tint = [[UIImageView alloc] init];
        [middleView addSubview:tint];
        [tint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(13);
            make.height.mas_equalTo(12);
            make.centerX.equalTo(middleView.mas_left).offset(16);
            make.top.mas_equalTo(16+i*28);
        }];
        tint.contentMode = UIViewContentModeCenter;
        tint.image = [UIImage imageNamed:pics[i]];
        
        UILabel *label = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor hexChangeFloat:@"333333"] text:_infoData[i] frame:CGRectZero alignment:NSTextAlignmentLeft];
        [middleView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.top.bottom.equalTo(tint);
        }];
    }
    
    UILabel *hint2 = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor hexChangeFloat:@"666666"] text:@"更多的敬酒数将为你带来更多的折扣" frame:CGRectZero alignment:NSTextAlignmentLeft];
    [self.view addSubview:hint2];
    [hint2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_seperateLine);
        make.top.equalTo(middleView.mas_bottom).offset(15);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}


@end
