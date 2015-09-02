
//
//  ProfileFeedCell.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileFeedCell.h"
#import "ProfileFeedContentView.h"
#import "FeedInfo.h"
#import "Feed.h"
NSString *const KProfileFeedCell = @"KProfileFeedCell";

#define KCONTENTMARGIN_LEFT SCALE_NUM(65)
#define KMARGIN SCALE_NUM(10)

#define KDATEWIDTH SCALE_NUM(32)
#define KDATEHEIGHT SCALE_NUM(68)


#define KDATEMARGIN_TOP SCALE_NUM(5)
#define KDATEMARGIN_LEFT SCALE_NUM(5)
#define KDATEMIDMARGIN SCALE_NUM(10)
@interface ProfileFeedCell()
//feed内容
@property (nonatomic, strong) ProfileFeedContentView *content;
//年月日信息
@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@end

@implementation ProfileFeedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initContent];
        [self initDateView];
    }
    return self;
}
- (void)initContent {
    _content = [[ProfileFeedContentView alloc] initWithType:ProfileFeedList];
    [self.contentView addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(KMARGIN);
        make.bottom.lessThanOrEqualTo(self.contentView).offset(-KMARGIN);
        make.right.equalTo(self.contentView).offset(-KMARGIN);
        make.left.equalTo(self.contentView).offset(KCONTENTMARGIN_LEFT);
    }];
}
- (void)initDateView {
    UIView *dateView = [[UIView alloc] init];
    [self.contentView addSubview:dateView];
    dateView.backgroundColor = KCOLORGREEN_f2f2f2;
    dateView.layer.borderColor = [KCOLORGREEN_455A64 CGColor];
    dateView.layer.cornerRadius = 3;
    dateView.layer.borderWidth = 1;
    dateView.clipsToBounds = true;
    [dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_content);
        make.left.mas_equalTo(KMARGIN);
        make.width.mas_equalTo(KDATEWIDTH);
        make.height.mas_equalTo(KDATEHEIGHT);
        make.bottom.lessThanOrEqualTo(self.contentView).offset(-KMARGIN);
    }];
    
    _yearLabel = [YUtils initLabel:CONTENT_FONT(8) color:KCOLORGREEN_455A64 text:@"2015" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_yearLabel];
    [_yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(dateView);
        make.top.equalTo(dateView).offset(KDATEMARGIN_TOP);
    }];
    
    _monthLabel = [YUtils initLabel:CONTENT_FONT(10) color:KCOLORGREEN_455A64 text:@"12" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_monthLabel];
    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(dateView);
        make.top.equalTo(_yearLabel.mas_bottom).offset(KDATEMIDMARGIN);
    }];
    
    _dayLabel = [YUtils initLabel:CONTENT_FONT(14) color:KCOLORGREEN_455A64 text:@"31" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(dateView);
        make.bottom.equalTo(dateView).offset(-KDATEMARGIN_TOP);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [dateView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KDATEMARGIN_LEFT);
        make.centerX.equalTo(dateView);
        make.top.equalTo(_monthLabel.mas_bottom);
        make.bottom.equalTo(_dayLabel.mas_top);
    }];
    
    UIView *line = [[UIView alloc] init];
    [lineView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView);
        make.centerY.equalTo(lineView);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = KCOLORGREEN_79909e;
    line.transform = CGAffineTransformMakeRotation(-M_PI/8);
}
- (void)setData:(FeedInfo *)info {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:info.feed.createTime/1000];
    _yearLabel.text = [NSString stringWithFormat:@"%d", (int)date.getYear];
    _monthLabel.text = [NSString stringWithFormat:@"%d", (int)date.getMonth];
    _dayLabel.text = [NSString stringWithFormat:@"%d", (int)date.getDay];
    [_content setData:info];
}


@end
