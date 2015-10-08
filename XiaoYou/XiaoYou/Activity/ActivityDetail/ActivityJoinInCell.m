//
//  ActivityJoinInCell.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityJoinInCell.h"
#import "TagListView.h"
#define REUSEID @"joinincell"
@interface ActivityJoinInCell ()
////上面部分通用部分View
//@property (nonatomic,strong) UIImageView    *headImageView;
//@property (nonatomic,strong) UILabel        *nameLabel;
//@property (nonatomic,strong) UIImageView    *genderImageView;
//@property (nonatomic,strong) UIView         *detailInfoView;
@property (nonatomic,strong) TagListView *tagListView;

@end

@implementation ActivityJoinInCell


+(ActivityJoinInCell *)cellWithTableView:(UITableView *)tableView
{
    ActivityJoinInCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID];
    if (!cell) {
        cell = [[ActivityJoinInCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

-(void)initView {
    _tagListView = [[TagListView alloc]init];
    [self.contentView addSubview:_tagListView];
    [_tagListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
