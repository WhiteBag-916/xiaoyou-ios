//
//  TypeCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TypeCollectionViewCell.h"
#import "TypeDetailCollectionView.h"

NSString *const kTypeCollectionViewCell = @"TypeCollectionViewCellId";

@interface TypeCollectionViewCell ()

@property (nonatomic,strong) TypeDetailCollectionView * collectionView;

@end

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
    
    UILabel * topLabel = [[UILabel alloc] init];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = CONTENT_FONT(12);
    topLabel.textColor = KCOLORGREEN_B5;
    topLabel.text = @"选择您本次活动的类型,可以多选哦:";
    [self.backView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.equalTo(self.numImageView);
        make.height.mas_equalTo(12);
        make.right.equalTo(self.backView.mas_right).offset(-12);
    }];
    
    //CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.minimumInteritemSpacing = 5;
//    layout.minimumLineSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[TypeDetailCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(12);
        make.width.left.equalTo(topLabel);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-12);
    }];
    
}

@end
