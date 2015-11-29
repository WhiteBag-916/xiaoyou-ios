//
//  ActivityJoinInCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityJoinInCell.h"
#import "TagListView.h"
#import "TagsCommonView.h"
#import "JoinInHeadView.h"
#import "JoinInTopView.h"
#import "Tags.h"
#import "ContactManager.h"
#import "YCommonAlertView.h"

@interface ActivityJoinInCell ()

@property (nonatomic,assign) CELLTYPE       cellType;
@property (nonatomic,strong) JoinInHeadView *joinInHeadView;
@property (nonatomic,strong) JoinInTopView  *joinTopView;
@property (nonatomic,strong) TagsCommonView *tagsView;
@property (nonatomic,strong) UIView         *tagsWrapView;
@property (nonatomic,strong) Author         *author;

@property (nonatomic,strong) UIImageView    *noSomeOneJoinImageView;   //没有人参加提示
@end

@implementation ActivityJoinInCell

-(instancetype)init
{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}


-(BOOL)needLine
{
    return YES;
}





//初始化控件
-(void)initView
{
    _joinInHeadView = [[JoinInHeadView alloc]init];
    [self.contentView addSubview:_joinInHeadView];
    [_joinInHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(0).priorityHigh();
        make.height.mas_equalTo(SCALE_NUM(49)).priorityLow();
    }];
    
    _joinTopView = [[JoinInTopView alloc]init];
    [self.contentView addSubview:_joinTopView];
    [_joinTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_joinInHeadView.mas_bottom).offset(0);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo(SCALE_NUM(60));
    }];
    
    _tagsWrapView = [[UIView alloc]init];
    [self.contentView addSubview:_tagsWrapView];
    _tagsWrapView.backgroundColor = RGBACOLOR(246, 247, 249, 1);
    [_tagsWrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_joinTopView.mas_bottom).offset(SCALE_NUM(0));
        make.leading.mas_equalTo(SCALE_NUM(71));
        make.trailing.mas_equalTo(SCALE_NUM(-12));
        make.bottom.mas_equalTo(SCALE_NUM(-12));
    }];
    
    
    _tagsView = [[TagsCommonView alloc]init];
    [_tagsWrapView addSubview:_tagsView];
    [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(SCALE_NUM(10));
        make.trailing.mas_equalTo(SCALE_NUM(0));
        make.bottom.mas_equalTo(SCALE_NUM(0));
    }];
    _tagsView.backgroundColor = RGBACOLOR(246, 247, 249, 1);
    
    _noSomeOneJoinImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_noSomeOneJoinImageView];
    _noSomeOneJoinImageView.hidden = YES;
    _noSomeOneJoinImageView.image = [[UIImage imageNamed:@"no_someone_signup"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_noSomeOneJoinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_joinInHeadView.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(SCALE_NUM(0));
    }];
}

-(void)setData:(Author *)joinModel WithType:(CELLTYPE)type
{
    _author = joinModel;
    [self setType:type];
    
    BOOL noData = (joinModel.uid == nil && joinModel.studentNo == nil);
    BOOL noTags = (joinModel.propetiesCommon.count == 0 && joinModel.tagsCommon.count == 0);
    //没有人参加
    _noSomeOneJoinImageView.hidden = !noData;
    _joinTopView.hidden = noData;
    _tagsWrapView.hidden = noTags;
    //处理没有数据的情况
    if (noData) {
        [_noSomeOneJoinImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(SCALE_NUM(100));
        }];
        return;
    }
    
    [_joinTopView setData:joinModel];
    //如果有tag，更新标签
    if (!noTags) {
        [_tagsView setData:joinModel];
    }
}


-(void)setType:(CELLTYPE)type
{
    if (type == IS_TOPVIEW) {
        [_joinInHeadView setContent];
        [_joinInHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(SCALE_NUM(49)).priorityHigh();
            make.height.mas_equalTo(SCALE_NUM(0)).priorityLow();
        }];
    }
    else if (type == NOT_TOPVIEW) {
        [_joinInHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityHigh();
            make.height.mas_equalTo(SCALE_NUM(49)).priorityLow();
        }];
        [_joinInHeadView clearContent];
    }
}

@end
