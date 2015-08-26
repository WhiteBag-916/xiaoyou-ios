//
//  GroupInfoDetailHeaderView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupInfoDetailHeaderView.h"
#import "GroupModel.h"

#define kTopPaddingDistance        25
#define kPaddingDistance           20
#define kNameLabelHeight           20
#define kImageViewWidthAndHeight   50


NSString *const kGroupInfoDetailHeaderView = @"GroupInfoDetailHeaderViewId";

@interface GroupInfoDetailHeaderView ()

@property (nonatomic,strong)UIImageView * groupImageView;
@property (nonatomic,strong)UILabel * grouoHeadLabel;
@property (nonatomic,strong)UILabel * groupNameLabel;

@end

@implementation GroupInfoDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        
        _groupImageView = [[UIImageView alloc] init];//WithFrame:CGRectMake(0, 0, 50, 50)];
        _groupImageView.backgroundColor = [UIColor hexChangeFloat:@"258f74"];
        _groupImageView.layer.cornerRadius = 25;
        _groupImageView.clipsToBounds = YES;
        [self addSubview:_groupImageView];
        [_groupImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(kPaddingDistance);
            make.width.height.mas_equalTo(kImageViewWidthAndHeight);
        }];
        
        _grouoHeadLabel = [[UILabel alloc] init];
        _grouoHeadLabel.textColor = [UIColor whiteColor];
        _grouoHeadLabel.textAlignment = NSTextAlignmentCenter;
        _grouoHeadLabel.font = CONTENT_FONT(20);
        _grouoHeadLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_grouoHeadLabel];
        [_grouoHeadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(kPaddingDistance);
            make.width.height.mas_equalTo(kImageViewWidthAndHeight);
        }];
        
        _groupNameLabel = [[UILabel alloc] init];
        _groupNameLabel.font = CONTENT_FONT(14);
        _groupNameLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:_groupNameLabel];
        [_groupNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_groupImageView);
            make.left.equalTo(_groupImageView.mas_right).offset(kPaddingDistance);
            make.right.equalTo(self).offset(-kPaddingDistance);
            make.height.mas_equalTo(kNameLabelHeight);
        }];
    }
    return self;
}

-(void)setHeaderViewInfo:(GroupModel *)model
{
    _grouoHeadLabel.text = [model.schoolName substringWithRange:NSMakeRange(0, 1)];
    _groupNameLabel.text = model.schoolName;

}

@end
