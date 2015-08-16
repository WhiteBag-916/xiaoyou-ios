

//
//  TagListTableViewCell.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "TagListTableViewCell.h"
#import "YUtils+Component.h"
#import "Masonry.h"

NSString *const KTagListTableViewCell = @"TagListTableViewCellId";

@interface TagListTableViewCell()
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UIImageView *addIcon;
@end
@implementation TagListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _tagLabel = [YUtils initLabel:CONTENT_FONT(15) color:[UIColor whiteColor] text:@"测试" frame:CGRectZero alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_tagLabel];
        [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.contentView);
        }];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (void)setData:(NSString *)text {
    
}
@end
