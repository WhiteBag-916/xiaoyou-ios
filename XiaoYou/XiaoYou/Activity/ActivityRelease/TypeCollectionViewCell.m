//
//  TypeCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TypeCollectionViewCell.h"

NSString *const kTypeCollectionViewCell = @"TypeCollectionViewCellId";

@implementation TypeCollectionViewCell

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
    self.numImageView.image = [UIImage imageNamed:@"img_num5"];
    self.typeLabel.text = @"类型";
    
}

@end
