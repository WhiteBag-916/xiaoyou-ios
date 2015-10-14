//
//  DateAndTimeCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "DateAndTimeCollectionViewCell.h"

NSString *const kDateAndTimeCollectionViewCell = @"DateAndTimeCollectionViewCellId";

@implementation DateAndTimeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changUI];
    }
    return self;
}

-(void)changUI
{ 
    self.numImageView.image = [UIImage imageNamed:@"img_num3"];
    self.typeLabel.text = @"时间";
    
}

@end
