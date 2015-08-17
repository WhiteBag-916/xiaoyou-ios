

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
#define KLABELHEIGHT SCALE_NUM(40)
#define kLABELWIDTH SCALE_NUM(120)
#define KLABELRADIUS SCALE_NUM(5)

@interface TagListTableViewCell()
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UIImageView *addIcon;
@end
@implementation TagListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _tagLabel = [YUtils initLabel:CONTENT_FONT(13) color:KCOLORWHITE text:@"测试" frame:CGRectZero alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_tagLabel];
        [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(kLABELWIDTH);
            make.height.mas_equalTo(KLABELHEIGHT);
        }];
        self.backgroundColor = [UIColor clearColor];
        _tagLabel.backgroundColor = KCOLORGREEN_179587;
        _tagLabel.layer.cornerRadius = KLABELRADIUS;
        _tagLabel.clipsToBounds = true;
        
        _addIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:_addIcon];
        [_addIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(KLABELHEIGHT/2);
            make.center.equalTo(_tagLabel);
        }];
        _addIcon.image = [UIImage imageNamed:@"add-02"];
    }
    return self;
}
- (void)setData:(NSString *)text {
    _tagLabel.text = text;
    if (text == nil) {
        _addIcon.hidden = false;
        _tagLabel.hidden = true;
    } else {
        _addIcon.hidden= true;
        _tagLabel.height = false;
    }
}
@end
