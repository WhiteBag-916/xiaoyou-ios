//
//  SearchFilterTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SearchFilterTableViewCell.h"
#import "YUtils+Component.h"

NSString *const kSearchFilterTableViewCell = @"SearchFilterTableViewCellId";

@interface SearchFilterTableViewCell()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation SearchFilterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLabel = [YUtils initLabel:CONTENT_FONT(15)
                                 color:KCOLORGREEN_79909e
                                  text:@""
                                 frame:CGRectZero
                             alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 11, 0, 0));
        }];
        
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
        line.backgroundColor = KCOLORGREEN_e6ebea;
    }
    
    return self;
}

- (void)initData:(NSString *)name select:(BOOL)isSelect {
    _nameLabel.text = name;
    
    if (isSelect) {
        _nameLabel.textColor = KCOLORWHITE;
        self.contentView.backgroundColor = KCOLORGREEN_79909e;
    } else {
        _nameLabel.textColor = KCOLORGREEN_79909e;
        self.contentView.backgroundColor = KCOLORWHITE;
    }
}

@end
