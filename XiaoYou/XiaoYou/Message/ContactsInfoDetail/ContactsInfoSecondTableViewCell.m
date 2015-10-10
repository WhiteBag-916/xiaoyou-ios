//
//  ContactsInfoSecondTableViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ContactsInfoSecondTableViewCell.h"
#import "TagsCommonView.h"
#import "ProfileInfo.h"

NSString *const kContactsInfoSecondTableViewCell = @"ContactsInfoSecondTableViewCellId";

@interface ContactsInfoSecondTableViewCell ()

@property (nonatomic,strong)TagsCommonView * tagsCommonView;

@end

@implementation ContactsInfoSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    UIView * backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor hexChangeFloat:@"F9F9F9"];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.right.mas_equalTo(-12);
        make.left.mas_equalTo(70);
        make.top.mas_equalTo(6);
    }];
    
    _tagsCommonView = [[TagsCommonView alloc] initWithCollectionViewHeight:40 andModel:nil];
    _tagsCommonView.backgroundColor = [UIColor hexChangeFloat:@"F9F9F9"];
    [backView addSubview:_tagsCommonView];
    [_tagsCommonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(12);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellInfo:(ProfileInfo *) model
{
    [_tagsCommonView setData:model];
}

@end
