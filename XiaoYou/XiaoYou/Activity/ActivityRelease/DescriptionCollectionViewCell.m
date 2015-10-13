//
//  DescriptionCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "DescriptionCollectionViewCell.h"
#import "YTextView.h"

NSString *const kDescriptionCollectionViewCell = @"DescriptionCollectionViewCellId";

@interface DescriptionCollectionViewCell ()

@property (nonatomic,strong) UIButton * picButton;
@property (nonatomic,strong) YTextView * textView;

@end

@implementation DescriptionCollectionViewCell

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
    self.typeLabel.text = @"活动描述";
    
    
    
}

@end
