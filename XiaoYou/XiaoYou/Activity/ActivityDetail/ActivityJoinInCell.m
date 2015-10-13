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

#define REUSEID @"joinincell"

@interface ActivityJoinInCell ()

@property (nonatomic,assign) CELLTYPE       cellType;
@property (nonatomic,strong) JoinInHeadView *joinInHeadView;
@property (nonatomic,strong) JoinInTopView  *joinTopView;

@property (nonatomic,strong) TagsCommonView *tagsView;
@end

@implementation ActivityJoinInCell


+(ActivityJoinInCell *)cellWithTableView:(UITableView *)tableView cellType:(CELLTYPE)type
{
    ActivityJoinInCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID];
    cell.cellType = type;
    if (!cell) {
        cell = [[ActivityJoinInCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.cellType == DEFAULT_VIEW || self.cellType == NOT_TOPVIEW)
            [self initViewWithType:NOT_TOPVIEW];
        else
            [self initViewWithType:IS_TOPVIEW];
    }
    return self;
}

//初始化控件
-(void)initViewWithType:(CELLTYPE)type
{
    _joinInHeadView = [[JoinInHeadView alloc]init];
    [self addSubview:_joinInHeadView];
    [_joinInHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(SCALE_NUM(49));
    }];
    
    _joinTopView = [[JoinInTopView alloc]init];
    [self addSubview:_joinTopView];
    [_joinTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_joinInHeadView.mas_bottom).offset(0);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo(SCALE_NUM(60));
    }];
    
    _tagsView = [[TagsCommonView alloc]init];
    [self addSubview:_tagsView];
    [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.leading.mas_equalTo(71);
        make.trailing.mas_equalTo(-20);
        make.height.mas_equalTo(100);
    }];
    _tagsView.backgroundColor = [UIColor cyanColor];
    Tags *tag1 = [[Tags alloc]init];
    tag1.name = @"班";
    tag1.equal = YES;
    
    Tags *tag2 = [[Tags alloc]init];
    tag2.name = @"社";
    
    Tags *tag3 = [[Tags alloc]init];
    tag3.name = @"乡";
    
    
    ProfileInfo *profile = [[ProfileInfo alloc]init];
    profile.propetiesCommon = [NSArray arrayWithObjects:tag1,tag2,tag3,nil];
    profile.tagModels = [NSArray arrayWithObjects:tag1,tag2,tag3, nil];
    [_tagsView setData:profile];
}


-(void)setCellInfo
{
    
}

@end
