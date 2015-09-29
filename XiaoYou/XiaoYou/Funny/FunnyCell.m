//
//  FunnyCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/28.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "FunnyCell.h"
#import "FunnyTopView.h"
#import "FunnyMiddleView.h"
#import "FunnyBottomView.h"
#define REUSEFUNNNYCELL @"funnycell"
@interface FunnyCell ()
@property (nonatomic,strong) FunnyTopView       *funnyTopView;
@property (nonatomic,strong) FunnyMiddleView    *funnyMiddleView;
@property (nonatomic,strong) FunnyBottomView    *funnyBottomView;
@property (nonatomic,strong) UIView             *middleDashLineView;//中间虚线
@property (nonatomic,strong) UIView             *bottomDashLineView;//下方虚线
@end

@implementation FunnyCell

+(FunnyCell *)cellWithTableView:(UITableView *)tableView
{
    FunnyCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEFUNNNYCELL];
    if (!cell) {
        cell = [[FunnyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEFUNNNYCELL];
    }
    return cell;
}

-(instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initFunnyTopView];
        [self initMiddleDashLineView];
        [self initFunnyMiddleView];
        [self initBottomDashLineView];
        [self initFunnyBottomView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)initFunnyTopView {
    _funnyTopView = [[FunnyTopView alloc]init];
    [self.contentView addSubview:_funnyTopView];
    [_funnyTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
}

-(void)initFunnyMiddleView {
    _funnyMiddleView = [[FunnyMiddleView alloc]init];
    [self.contentView addSubview:_funnyMiddleView];
    [_funnyMiddleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_funnyTopView.mas_bottom).offset(10);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(130);
    }];
}

-(void)initFunnyBottomView {
    _funnyBottomView = [[FunnyBottomView alloc]init];
    [self.contentView addSubview:_funnyBottomView];
    [_funnyBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_funnyMiddleView.mas_bottom).offset(10);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
}

-(void)initMiddleDashLineView {
    _middleDashLineView = [[UIView alloc]init];
    [self.contentView addSubview:_middleDashLineView];
    [_middleDashLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_funnyTopView.mas_bottom).offset(5);
        make.height.mas_equalTo(2);
        make.leading.mas_equalTo(SCALE_NUM(70));
        make.trailing.mas_equalTo(0);
    }];
    [_middleDashLineView.layer addSublayer:[self drawDashLine]];
    _middleDashLineView.layer.masksToBounds = YES;
}

-(void)initBottomDashLineView {
    _bottomDashLineView = [[UIView alloc]init];
    [self.contentView addSubview:_bottomDashLineView];
    [_bottomDashLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(SCALE_NUM(70));
        make.top.equalTo(_funnyMiddleView.mas_bottom).offset(5);
        make.height.mas_equalTo(2);
        make.trailing.mas_equalTo(0);
    }];
    [_bottomDashLineView.layer addSublayer:[self drawDashLine]];
    _bottomDashLineView.layer.masksToBounds = YES;
}

//画出一条虚线
-(CAShapeLayer*)drawDashLine {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];

    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor]];

    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:2.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=每条线的宽度 1=每条线的间距 － － － －
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:
                                    [NSNumber numberWithInt:3],
                                    [NSNumber numberWithInt:1],nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置初始起点和终点
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 1000,0);

    [shapeLayer setPath:path];
    CGPathRelease(path);
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    //[self.dashLineView.layer addSublayer:shapeLayer];
    return shapeLayer;
}

@end
