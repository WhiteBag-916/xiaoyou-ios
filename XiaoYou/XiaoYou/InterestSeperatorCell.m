//
//  InterestSeperatorCell.m
//  XiaoYou
//
//  Created by 李思良 on 15/10/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "InterestSeperatorCell.h"

@interface InterestSeperatorCell()
@property (strong, nonatomic) UIImageView *labelLine;
@property (strong, nonatomic) UIImageView *line;
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation InterestSeperatorCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haokan_bottom_line"]];
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.centerY.equalTo(self);
        }];
        
        _labelLine = [[UIImageView alloc] init];
        [self addSubview:_labelLine];
        _labelLine.contentMode = UIViewContentModeScaleAspectFit;
        [_labelLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.centerY.top.equalTo(self);
        }];
        _labelLine.image = [UIImage imageNamed:@"news_tag_time"];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = KCOLOR_B3;
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        _timeLabel.font = CONTENT_FONT(12);
    }
    return self;
}
- (void)updateState:(NSString *)time {
    _labelLine.hidden = (time.length == 0);
    _line.hidden = (time.length != 0);
    _timeLabel.hidden = (time.length == 0);
    _timeLabel.text = time;
}
@end
