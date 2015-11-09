//
//  InterestTableViewCell.m
//  XiaoYou
//
//  Created by 李思良 on 15/10/24.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "InterestTableViewCell.h"
#import "NSDate+Category.h"
#import "NewsList.h"

@interface InterestTableViewCell()
@property (strong ,nonatomic) UIImageView *picture;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *source;
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation InterestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:KInterestCell]) {
        _picture = [[UIImageView alloc] init];
        [self.contentView addSubview:_picture];
        [_picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.mas_equalTo(12);
            make.right.equalTo(self.contentView).offset(-12);
            make.height.equalTo(_picture.mas_width).multipliedBy(0.3547);
        }];
        _picture.clipsToBounds = true;
        _picture.layer.cornerRadius = 4;
        
        _title = [YUtils initLabel:CONTENT_FONT(15) color:[UIColor blackColor] text:@"你最关心的校园资讯" alignment:NSTextAlignmentLeft];
        _title.numberOfLines = 0;
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_picture);
            make.top.equalTo(_picture.mas_bottom).offset(15);
        }];
        
        UIImageView *tint = [[UIImageView alloc] init];
        [self.contentView addSubview:tint];
        [tint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_title);
            make.height.width.mas_equalTo(12);
            make.top.equalTo(_title.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView);
        }];
        tint.image = [UIImage imageNamed:@"news_icon_location"];
        
        _source = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor hexChangeFloat:@"b5b5b5"] text:@"今日头条" alignment:NSTextAlignmentLeft];
        _source.numberOfLines = 0;
        [self.contentView addSubview:_source];
        [_source mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tint.mas_right).offset(7);
            make.top.bottom.equalTo(tint);
        }];
        
        _timeLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor hexChangeFloat:@"b5b5b5"] text:@"3小时前" alignment:NSTextAlignmentRight];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_picture);
            make.top.bottom.equalTo(_source);
        }];
    }
    return self;
}
- (void)setData:(NewsList *)model {
    [_picture setNormalImageWithUrl:model.coverImg];
    _title.text = model.title;
    _source.text = model.source;
    _timeLabel.text = [[NSDate dateWithTimeIntervalSince1970:(NSInteger)model.publishTime/1000] formatForInterest];
}


@end
