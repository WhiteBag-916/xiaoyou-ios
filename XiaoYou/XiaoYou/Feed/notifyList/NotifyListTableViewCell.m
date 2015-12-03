//
//  NotifyListTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "NotifyListTableViewCell.h"
#import "YFaceImageView.h"
#import "YUtils+UI.h"
#import "AlertList.h"
#import "YUtils+Component.h"

NSString *const kNotifyListTableViewCell = @"NotifyListTableViewCellId";

#define KFACEIMGSIZE SCALE_NUM(26)
#define KFACEMARGIN SCALE_NUM(18)
#define KTIMEMARGIN SCALE_NUM(10)
#define KCONTENTMARGIN SCALE_NUM(17)

@interface NotifyListTableViewCell ()

@property (nonatomic, strong) YFaceImageView *face;             //头像
@property (nonatomic, strong) UILabel *contentLabel;            //提醒内容
@property (nonatomic, strong) UILabel *timeLabel;               //时间

@end

@implementation NotifyListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        //头像
        _face = [[YFaceImageView alloc] init];
        [self.contentView addSubview:_face];
        [_face mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(KFACEMARGIN);
            make.width.height.mas_equalTo(KFACEIMGSIZE);
            make.centerY.equalTo(self.contentView);
        }];
        _face.layer.cornerRadius = KFACEIMGSIZE/2;
        _face.clipsToBounds = true;
        
        //时间
        _timeLabel = [YUtils initLabel:CONTENT_FONT(10)
                                 color:KCOLOR_455A64
                                  text:@"刚刚"
                                 frame:CGRectZero
                             alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-KTIMEMARGIN);
            make.centerY.equalTo(self.contentView);
        }];
        
        //content
        _contentLabel = [YUtils initLabel:CONTENT_FONT(12)
                                    color:KCOLOR_455A64
                                     text:@"评论评论评论评论评论评论评论评论"
                                    frame:CGRectZero
                                alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_face.mas_right).offset(KCONTENTMARGIN);
            make.right.equalTo(_timeLabel.mas_left).offset(-KCONTENTMARGIN);
            make.centerY.equalTo(self.contentView);
        }];
    }
    
    return self;
}

- (BOOL)needLine
{
    return YES;
}

- (void)initData:(AlertList *)alertList {
    [_face setData:alertList.userId imageUrl:alertList.headPic];
    _contentLabel.text = alertList.content;
    _timeLabel.text = [YUtils
                       distanceTimeToday:[NSDate
                                          dateWithTimeIntervalSince1970:alertList.createTime/1000]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
