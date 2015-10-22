//
//  FunnyDetailCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityDetailCell.h"
#import "ActivityTopView.h"
#import "ActivityMiddleView.h"
#import "FeedImageGroup.h"
#import "YLabel+Ext.h"
#import "UIImageView+WebCache.h"
#define REUSEID @"activitydetail"
@interface ActivityDetailCell ()
@property (nonatomic,strong) ActivityTopView        *topView;
@property (nonatomic,strong) FeedImageGroup         *middleView;
@property (nonatomic,strong) ActivityMiddleView     *bottomView;
@end
@implementation ActivityDetailCell

+(ActivityDetailCell *)cellWithTableView:(UITableView *)tableView
{
    ActivityDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:REUSEID];
    if (!detailCell) {
        detailCell = [[ActivityDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEID];
    }
    return detailCell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initTopView];
        [self initMiddleView];
        [self initBottomView];
    }
    return self;
}


-(void)initTopView {
    _topView = [[ActivityTopView alloc]initWithType:DETAIL_INFO];
    [self.contentView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(_topView.descriptionLabel.mas_bottom);
    }];
}

-(void)initMiddleView {
    _middleView = [[FeedImageGroup alloc]init];
    [self.contentView addSubview:_middleView];
    
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).offset(SCALE_NUM(10));
        make.left.equalTo(_topView.descriptionLabel.mas_left);
        make.right.equalTo(_topView.descriptionLabel);
    }];
    
    NSArray *smallImages    = @[@"/dev/feed/s/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png"];
    NSArray *bigImages      = @[@"/dev/feed/c2cfe0e7-ba38-43e0-b345-3d14ff2f2bcf.png"];
    [_middleView updateWithImgs:smallImages bigPics:bigImages];
}

#pragma mark －需要改进
-(void)initBottomView {
    _bottomView = [[ActivityMiddleView alloc]init];
    [self.contentView addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleView.mas_bottom).offset(SCALE_NUM(5));
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)setData:(ActivityModel*)data
{
    [_topView.headImageView sd_setImageWithURL:[NSURL URLWithString:data.acHeadImage]];
    _topView.titleLabel.text = data.acName;
    _topView.nameLabel.text = data.acTitle;
    //_topView.descriptionLabel.text = data.acBrief;
    [_topView.descriptionLabel setText:data.acBrief lineSpacing:10.0f];
    
    _bottomView.locationLabel.text = data.acLocation;
}

@end
