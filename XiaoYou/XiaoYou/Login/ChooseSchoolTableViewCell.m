//
//  ChooseSchoolTableViewCell.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ChooseSchoolTableViewCell.h"
#import "YUtils+UI.h"

NSString *const kChooseSchoolTableViewCell = @"ChooseSchoolTableViewCellId";

@interface ChooseSchoolTableViewCell()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation ChooseSchoolTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLabel = [YUtils initLabel:CONTENT_FONT(14)
                                 color:[UIColor blackColor]
                                  text:@""
                                 frame:CGRectZero
                             alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 11, 0, 0));
        }];
        
        self.contentView.backgroundColor = KCOLOR_e6ebea;
    }
    
    return self;
}

- (BOOL)needLine {
    return YES;
}

- (UIColor *)lineColor {
    return [UIColor hexChangeFloat:@"c0c2c1"];
}

- (void)initData:(NSString *)name {
    _nameLabel.text = name;
}
@end
