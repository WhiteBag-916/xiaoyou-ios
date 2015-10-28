//
//  FeedTag.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "FeedTag.h"
#import "Tags.h"
#define KLABELHEIGHT SCALE_NUM(10)

@interface FeedTag()

@property (nonatomic, strong, readwrite) UIImageView *tagIcon;      //tag图标

@property (nonatomic, strong, readwrite) SKTagView *tagContent;     //tag标签

@end

@implementation FeedTag

- (id)init {
    self = [super init];
    if (self) {
        self.clipsToBounds = true;
        _tagIcon = [[UIImageView alloc] init];
        [self addSubview:_tagIcon];
        [_tagIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_NUM(11));
            make.height.mas_equalTo(SCALE_NUM(14));
            make.left.top.equalTo(self);
            make.bottom.equalTo(self).priorityLow();
        }];
        
        _tagContent = [[SKTagView alloc] init];
        [self addSubview:_tagContent];
        [_tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tagIcon.mas_centerY).offset(-KLABELHEIGHT);
            make.right.bottom.equalTo(self);
        }];
        _tagContent.insets = 21;
        _tagContent.lineSpace = 0;
        _tagContent.singleLine = false;
        _tagContent.preferredMaxLayoutWidth = SCALE_NUM(230);
        [self setIsRelated:false];
        
    }
    
    return self;
}

- (void)setData:(NSArray *)tags {
    [_tagContent removeAllTags];
    if (tags.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityHigh();
        }];
    } else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityLow();
        }];
        BOOL hasRelate = false;
        for (int i = 0; i < tags.count; i++) {
            BOOL isRelate = [tags[i] equal];
            hasRelate |= isRelate;
            SKTag *tag = [SKTag tagWithText:[tags[i] name]];
            tag.font = CONTENT_FONT(10);
            if (isRelate) {
                tag.textColor = KCOLOR_009688;
            } else {
                tag.textColor = KCOLORWHITE_696969;
            }
            [_tagContent addTag:tag];
        }
        [self setIsRelated:hasRelate];
    }
}

- (void)setData {
    [_tagContent removeAllTags];

    NSArray *labelName = @[@"金融", @"留学咨询", @"学校生活", @"工作", @"互联网信息"];
    for (int i = 0; i < labelName.count; i++) {
        SKTag *tag = [SKTag tagWithText:labelName[i]];
        tag.font = CONTENT_FONT(10);
        tag.textColor = KCOLORWHITE_696969;
        tag.textColor = KCOLOR_009688;
        [_tagContent addTag:tag];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _tagContent.preferredMaxLayoutWidth = _tagContent.width;
}
- (void)setIsRelated:(BOOL)isRelated {
    if (isRelated) {
        _tagIcon.image = [UIImage imageNamed:@"tag-green"];
    } else {
        _tagIcon.image = [UIImage imageNamed:@"tag-grey"];
    }
}
@end
