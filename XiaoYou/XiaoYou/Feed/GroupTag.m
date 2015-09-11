//
//  GroupTag.m
//  XiaoYou
//
//  Created by HuiYin on 15/9/10.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupTag.h"
#import "FeedInfo.h"
#import "GroupModel.h"

@implementation GroupTag

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tagGroupIcon = [[UIImageView alloc] init];
        _tagGroupIcon.image = [UIImage imageNamed:@"group_logo"];
        [self addSubview:_tagGroupIcon];
        [_tagGroupIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_NUM(16));
            make.height.mas_equalTo(SCALE_NUM(14));
            make.centerY.equalTo(self);
        }];
        _tagGroupName = [[UILabel alloc] init];
        _tagGroupName.textColor = KCOLORWHITE_696969;
        _tagGroupName.font = CONTENT_FONT(10);
        [self addSubview:_tagGroupName];
        [_tagGroupName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (void)setData:(id)inData
{
    self.hidden = YES;
    
    if ([inData isKindOfClass:[FeedInfo class]]) {
        FeedInfo * feedInfo = inData;
        if (feedInfo.groupModels.count > 0)
        {
            NSMutableString * groupNameStr = [[NSMutableString alloc] init];
            for (int i = 0; i < feedInfo.groupModels.count ; i++)
            {
                GroupModel * model = feedInfo.groupModels[i];
                NSString * tempStr = model.groupName;
                [groupNameStr appendString:tempStr];
            }
            _tagGroupName.text = groupNameStr;
            
            self.hidden = NO;
        }
    }
}

@end
