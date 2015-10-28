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
#import "UIImageView+WebCache.h"
#import "ContactManager.h"
#import "YCommonAlertView.h"

@interface ActivityJoinInCell ()

@property (nonatomic,assign) CELLTYPE       cellType;
@property (nonatomic,strong) JoinInHeadView *joinInHeadView;
@property (nonatomic,strong) JoinInTopView  *joinTopView;

@property (nonatomic,strong) TagsCommonView *tagsView;

@property (nonatomic,strong) UIView         *tagsWrapView;

@property (nonatomic,strong) Author         *author;

@end

@implementation ActivityJoinInCell

-(instancetype)initWithType:(CELLTYPE)type
{
    if (self = [super init]) {
        [self initViewWithType];
        [self setCellType:type];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//            [self initViewWithType];
//    }
//    return self;
//}


-(void)setCellType:(CELLTYPE)cellType
{
    if (cellType == IS_TOPVIEW) {
        [_joinInHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(SCALE_NUM(49)).priorityHigh();
        }];
        [_joinInHeadView updateConstraints];
    }
    else if (cellType == NOT_TOPVIEW) {
        [_joinInHeadView clearContent];
    }
}


//初始化控件
-(void)initViewWithType
{
    _joinInHeadView = [[JoinInHeadView alloc]init];
    [self.contentView addSubview:_joinInHeadView];
    [_joinInHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.width.mas_equalTo(0).priorityLow();
        make.height.mas_equalTo(0).priorityLow();
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
        make.top.equalTo(_joinTopView.mas_bottom).offset(SCALE_NUM(15));
        make.leading.mas_equalTo(71);
        make.trailing.mas_equalTo(-20);
        make.height.mas_equalTo(100);
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
//    Tags *tag1 = [[Tags alloc]init];
//    tag1.name = @"班";
//    tag1.equal = YES;
//    
//    Tags *tag2 = [[Tags alloc]init];
//    tag2.name = @"社";
//    
//    Tags *tag3 = [[Tags alloc]init];
//    tag3.name = @"乡";
//    
//    Tags *tag4 = [[Tags alloc]init];
//    tag4.name = @"托福GRE";
//    tag4.equal = YES;
//    
//    Tags *tag5 = [[Tags alloc]init];
//    tag5.name = @"雅思";
//    
//    Tags *tag6 = [[Tags alloc]init];
//    tag6.name = @"铁饭碗攻略";
//    
//    ProfileInfo *profile = [[ProfileInfo alloc]init];
//    profile.propetiesCommon = [NSArray arrayWithObjects:tag1,tag2,tag3,nil];
//    profile.tagModels = [NSArray arrayWithObjects:tag4,tag5,tag6, nil];
//    [_tagsView setData:profile];
}

-(void)setData:(Author *)joinModel
{
    _author = joinModel;
    [_joinTopView setData:joinModel];
    
    ProfileInfo *profile = [[ProfileInfo alloc]init];
    profile.propetiesCommon = joinModel.propetiesCommon;
    profile.tagModels = joinModel.tagsCommon;
    [_tagsView setData:profile];
    
    if ([joinModel.gender isEqualToString:@"男"]) {
        _joinTopView.genderImageView.image = [UIImage imageNamed:@"funny_detail_boy"];
    } else
    {
        _joinTopView.genderImageView.image = [UIImage imageNamed:@"funny_detail_girl"];
    }

    
//    ProfileInfo *info = [[ProfileInfo alloc]init];
//    info.tagModels = joinModel.tagsCommon;
    CGFloat height = [self calculatorTagsCommHeightByProfileInfo:profile];
    
    [_tagsWrapView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((height));
        
    }];
}

-(CGFloat)calculatorTagsCommHeightByProfileInfo:(ProfileInfo*)model
{
    if (model.tagModels.count > 0)
    {
        CGFloat height = 55;
        for (int i = 0; i < model.tagModels.count; i++)
        {
            CGFloat width;
            Tags * tag = model.tagModels[i];
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGSize textSize = [tag.name boundingRectWithSize:CGSizeMake(150, 14) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
            width += (10);
            width += textSize.width + 15;
            if (width > SCREEN_WIDTH - 117)
            {
                height += (20);
                width = (10) + textSize.width;
            }
        }
        return height;
    }
    else
    {
        if (model.propetiesCommon.count <= 0) {
            return 0;
        }
        else
            return 40;
    }
}

@end
