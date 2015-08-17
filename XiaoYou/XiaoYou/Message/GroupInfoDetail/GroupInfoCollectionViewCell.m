//
//  GroupInfoCollectionViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupInfoCollectionViewCell.h"

#define kHeadImageViewHeight            50

NSString *const kGroupInfoCollectionViewCell = @"GroupInfoCollectionViewCellId";

@interface GroupInfoCollectionViewCell ()

@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)UILabel * nameLabel;

@end

@implementation GroupInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = [UIColor magentaColor];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.equalTo(self.contentView);
            make.height.width.mas_equalTo(kHeadImageViewHeight);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headImageView.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)setCellInfo:(NSDictionary *) groupDic
{
    _nameLabel.text = groupDic[@"name"];
}

@end
